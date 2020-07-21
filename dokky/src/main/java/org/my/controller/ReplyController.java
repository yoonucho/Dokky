package org.my.controller;
	import org.my.domain.Criteria;
	import org.my.domain.ReplyDisLikeVO;
	import org.my.domain.ReplyLikeVO;
	import org.my.domain.ReplyPageDTO;
	import org.my.domain.ReplyVO;
	import org.my.domain.commonVO;
	import org.my.service.ReplyService;
	import org.springframework.http.HttpStatus;
	import org.springframework.http.MediaType;
	import org.springframework.http.ResponseEntity;
	import org.springframework.security.access.prepost.PreAuthorize;
	import org.springframework.stereotype.Controller;
	import org.springframework.web.bind.annotation.DeleteMapping;
	import org.springframework.web.bind.annotation.GetMapping;
	import org.springframework.web.bind.annotation.PathVariable;
	import org.springframework.web.bind.annotation.PostMapping;
	import org.springframework.web.bind.annotation.RequestBody;
	import org.springframework.web.bind.annotation.RequestMapping;
	import org.springframework.web.bind.annotation.RequestMethod;
	import org.springframework.web.bind.annotation.RequestParam;
	import org.springframework.web.bind.annotation.ResponseBody;
	import lombok.AllArgsConstructor;
	import lombok.extern.log4j.Log4j;
			
@RequestMapping("/replies/")
@Controller
@Log4j
@AllArgsConstructor
public class ReplyController {
	
	private ReplyService replyService;
	
	@PreAuthorize("principal.username == #vo.replyVO.userId")
	@ResponseBody
	@PostMapping(value = "/reply", consumes = "application/json", produces = "text/plain; charset=UTF-8")
	public ResponseEntity<String> createReply(@RequestBody commonVO vo) {

		log.info("/replies/reply");
		log.info("vo : " + vo);
		
		int insertCount = replyService.create(vo);//댓글입력+알람입력

		return insertCount == 1  
				? new ResponseEntity<>("success", HttpStatus.OK) 
				: new ResponseEntity<>("fail", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "/reply/{reply_num}", produces = { MediaType.APPLICATION_JSON_UTF8_VALUE })
	@ResponseBody
	public ResponseEntity<ReplyVO> readReply(@PathVariable("reply_num") Long reply_num) {
	
		log.info("/replies/reply/"+reply_num);
		
		return new ResponseEntity<>(replyService.read(reply_num), HttpStatus.OK);
	}
	
	@GetMapping(value = "/list/{board_num}/{page}", produces = { MediaType.APPLICATION_JSON_UTF8_VALUE })
	@ResponseBody						//댓글 리스트
	public ResponseEntity<ReplyPageDTO> readReplyList(@PathVariable("board_num") Long board_num, 
													  @PathVariable("page") int page) {
		
		log.info("/replies/list/"+board_num+"/"+page);
		
		Criteria cri = new Criteria(page, 10);//댓글을 10개씩 보여줌 
		
		log.info("cri:" + cri);

		return new ResponseEntity<>(replyService.readReplyList(cri, board_num), HttpStatus.OK);
	}
	
	@PreAuthorize("principal.username == #vo.userId")
	@DeleteMapping(value = "/reply/{reply_num}", produces = { MediaType.TEXT_PLAIN_VALUE })
	@ResponseBody
	public ResponseEntity<String> deleteReply(@RequestBody ReplyVO vo, 
											  @PathVariable("reply_num") Long reply_num) {
		
		log.info("/replies/reply/"+reply_num);
		
		return replyService.delete(reply_num) == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	} 
	
	@PreAuthorize("principal.username == #userId")  
	@PostMapping("/deleteReplies")//댓글 다중삭제
		public String deleteReplies(@RequestParam("checkRow") String checkRow ,
				      				@RequestParam("userId")String userId, Criteria cri) {

		log.info("/replies/deleteReplies");
		log.info("checkRow..." + checkRow);
	 	
	 	String[] arrIdx = checkRow.split(",");
	 	
	 	for (int i=0; i<arrIdx.length; i++) {
	 		
	 		Long reply_num = Long.parseLong(arrIdx[i]);  
	 		
	 		log.info("delete...reply_num=" + reply_num);
	 		
	 		replyService.delete(reply_num);
	 	}
	 	
	 	return "redirect:/mypage/myReplylist?userId="+userId+"&pageNum="+cri.getPageNum()+"&amount="+cri.getAmount();
	}

	@PreAuthorize("principal.username == #vo.userId")
	@RequestMapping(method = { RequestMethod.PUT, RequestMethod.PATCH }, 
					value = "/reply", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE }) 
	@ResponseBody
	public ResponseEntity<String> updateReply(@RequestBody ReplyVO vo) {

		log.info("/replies/reply");
		log.info("ReplyVO: " + vo);

		return replyService.update(vo) == 1 
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>("fail", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PostMapping(value = "/giveReplyWriterMoney", consumes = "application/json", produces = "text/plain; charset=UTF-8")
	@ResponseBody
	public ResponseEntity<String> giveReplyWriterMoney(@RequestBody commonVO vo) {//기부하기
		
			log.info("/replies/giveReplyWriterMoney");
			log.info("replyDonateVO: " + vo);
			
			String replyMoney = replyService.giveReplyWriterMoney(vo);
			
			if(replyMoney != null) {
				
				return new ResponseEntity<>(replyMoney, HttpStatus.OK); 
				
			}else {
				
				return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
			}
	}
	
	
	@RequestMapping(method = { RequestMethod.PUT,RequestMethod.PATCH },
			value = "/likeCount", consumes = "application/json", produces = "text/plain; charset=UTF-8")
		@ResponseBody
		public ResponseEntity<String> updateLike(@RequestBody commonVO vo) {//댓글 좋아요 누르기 및 취소
		
			log.info("/replies/likeCount");
			
			ReplyLikeVO replyLikeVO = vo.getReplyLikeVO();
			
			String CheckResult = replyService.checkLikeValue(replyLikeVO);
			
			log.info("CheckResult: " + CheckResult);
			
			int returnVal = 0;
			
			if(CheckResult == null){ 
				returnVal = replyService.registerLike(vo);
				log.info("registerLike..." );
				 
			}else if(CheckResult.equals("pull")){
				returnVal = replyService.pushLike(vo);//댓글 좋아요 누르기
				log.info("pushLike...");
				
			}else if(CheckResult.equals("push")){
				returnVal = replyService.pullLike(vo);//댓글 좋아요 취소
				log.info("pullLike...");
			}
			
			log.info("returnVal: " + returnVal);
			
			return returnVal == 1 ? new ResponseEntity<>(replyService.getLikeCount(replyLikeVO.getReply_num()), HttpStatus.OK)
					: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	
	@RequestMapping(method = { RequestMethod.PUT,RequestMethod.PATCH },
			value = "/dislikeCount", consumes = "application/json", produces = "text/plain; charset=UTF-8")
		@ResponseBody
		public ResponseEntity<String> updateDisLike(@RequestBody commonVO vo) {//싫어요 누르기 및 취소
			
			log.info("/replies/dislikeCount");
		
			ReplyDisLikeVO boardDisLikeVO = vo.getReplyDisLikeVO();
			
			String CheckResult = replyService.checkDisLikeValue(boardDisLikeVO);
			 
			log.info("CheckResult: " + CheckResult);
			
			int returnVal = 0;
			 
			if(CheckResult == null){ 
				returnVal = replyService.registerDisLike(vo);
				log.info("registerDisLike..." );
				
			}else if(CheckResult.equals("pull")){
				
				returnVal = replyService.pushDisLike(vo);//싫어요 누르기
				log.info("pushDisLike...");
				
			}else if(CheckResult.equals("push")){
				returnVal = replyService.pullDisLike(vo); //싫어요 취소
				log.info("pullDisLike...");
			}
			
			log.info("returnVal: " + returnVal);
			
			return returnVal == 1 ? new ResponseEntity<>(replyService.getDisLikeCount(boardDisLikeVO.getReply_num()), HttpStatus.OK)
					: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	
		
}

