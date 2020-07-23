package org.my.service;
	import java.util.List;
	import org.my.domain.Criteria;
	import org.my.domain.ReplyDisLikeVO;
	import org.my.domain.ReplyLikeVO;
	import org.my.domain.ReplyPageDTO;
	import org.my.domain.ReplyVO;
	import org.my.domain.commonVO;
	import org.my.domain.replyDonateVO;
	import org.my.mapper.BoardMapper;
	import org.my.mapper.CommonMapper;
	import org.my.mapper.ReplyMapper;
	import org.springframework.beans.factory.annotation.Autowired;
	import org.springframework.stereotype.Service;
	import org.springframework.transaction.annotation.Transactional;
	import lombok.Setter;
	//import lombok.AllArgsConstructor;
	import lombok.extern.log4j.Log4j;

@Service
@Log4j
//@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService {
  
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper replyMapper;

	@Setter(onMethod_ = @Autowired)
	private BoardMapper boardMapper;
	
	@Setter(onMethod_ = @Autowired)
	private CommonMapper commonMapper;
		
	@Transactional
	@Override
	public int create(commonVO vo) {
		
		log.info("create......reply " + vo);
		ReplyVO replyVO = vo.getReplyVO();

		log.info("updateReplyCnt......" + vo);
		boardMapper.updateReplyCnt(replyVO.getBoard_num(), 1);
		
		if(vo.getAlarmVO() != null) {
			
			log.info("insertAlarm"); 
			commonMapper.insertAlarm(vo.getAlarmVO());
		}
		
		if(replyVO.getGroup_num() == 0 ) {//시퀀스값은 디폴트 1부터 시작하니까 0으로 기준을 잡자
			
			log.info("insertParentReply......" + replyVO); 
			return replyMapper.insertParentReply(replyVO);//일반 루트 부모 댓글 입력
			
		}else{//자식 댓글 입력 
			
			List<ReplyVO> list = replyMapper.selectNextReply(replyVO);//이게 댓글의 순서를 결정하는 2번째 중요한 핵심
			/*한개의 (부모)그룹번호 기준으로 생각할때 대댓글의 출력 순서는 대댓글을 달고자 하는 대상인 부모댓글(루트가 아닌 경우도 포함)의
			출력 순서 보다 크면서(밑에 있으면서), 부모댓글의 (레벨)깊이보다 작거나 같은 최초의 댓글의 그룹순서가 된다*/
			
			if(list.isEmpty()){//그런데 최초의 댓글이 없다면 
				//댓글의 순서를 결정하는 1번째 핵심
				int lastReplyStep = replyMapper.lastReplyStep(replyVO.getGroup_num());//그룹내에 맨 마지막 댓글의 순서번호를가져오고
				
				replyVO.setOrder_step(lastReplyStep+1);//순서번호에 +1을 해준다 
				
				log.info("insertChildReply......" + replyVO); 
				return replyMapper.insertChildReply(replyVO);//깊이도 +1해서 입력 해줌 ,
				
			}else{// 최초의 댓글이 있다면
				
				ReplyVO firstVO = list.get(0);
				
				replyMapper.updateOrder_step(firstVO);//최초댓글을 포함해서 나머지 아래 댓글의 순서값 모두 1씩 올려줌
				
				replyVO.setOrder_step(firstVO.getOrder_step());//최초의 댓글에 해당하는 순서값으로 변경후 입력
				
				log.info("insertChildReply......" + replyVO); 
				return replyMapper.insertChildReply(replyVO);//깊이도 +1해서 입력 해줌 , 
			}
		}
	} 
	
	@Override
	public ReplyVO read(Long reply_num) {
	
	    log.info("read......" + reply_num);
	
	    return replyMapper.read(reply_num);
	}
	
	@Override
	public ReplyPageDTO readReplyList(Criteria cri, Long board_num) {
		
		  return new ReplyPageDTO(replyMapper.getReplyCnt(board_num), 
	    						  replyMapper.readReplyListWithPaging(cri, board_num));
		  
	}

	@Override
	public int update(ReplyVO vo) {
	
	    log.info("update......" + vo);
	
	    return replyMapper.update(vo);
	
	}

    @Transactional
	@Override 
	public int delete(Long reply_num) {

    	log.info("delete...." + reply_num);

		Long board_num = replyMapper.getBoardNum(reply_num); 

		boardMapper.updateReplyCnt(board_num, -1);
		
		return replyMapper.delete(reply_num);
		
	}
	  
	@Transactional
	@Override 
	public String giveReplyWriterMoney(commonVO vo) {
		
		replyDonateVO replyDonateVO = vo.getReplyDonateVO();
		
		log.info("minusMycash");
		boardMapper.minusMycash(replyDonateVO.getMoney(), replyDonateVO.getUserId());
		
		log.info("createMyCashHistory");
		replyMapper.createMyCashHistory(replyDonateVO); 
		 
		log.info("plusReplyUserCash");
		replyMapper.plusReplyUserCash(replyDonateVO);
		 
		log.info("createReplyUserCashHistory");
		replyMapper.createReplyUserCashHistory(replyDonateVO);
		
		log.info("plusReplyMoney");
		replyMapper.plusReplyMoney(replyDonateVO);
		
		log.info("insertAlarm: ");
		commonMapper.insertAlarm(vo.getAlarmVO());
		
		log.info("getReplyMoney");
		return replyMapper.getReplyMoney(replyDonateVO);
	}
	  
	@Override
	public boolean checkReplyLikeButton(ReplyLikeVO vo) { 
		
		log.info("checkReplyLikeButton");
		
		return replyMapper.checkReplyLikeButton(vo) == 1; 
	}
	
	@Override
	public boolean checkReplyDislikeButton(ReplyDisLikeVO vo) {
		
		log.info("checkReplyDislikeButton"); 
		
		return replyMapper.checkReplyDislikeButton(vo) == 1; 
	}
		
	@Transactional
	@Override
	public boolean pushReplyLikeButton(commonVO vo) {//댓글 좋아요 버튼 누르기
		
		log.info("pushReplyLikeButton...." + vo);
		
		ReplyLikeVO replyLikeVO = vo.getReplyLikeVO();
		
		log.info("insertAlarm");
		
		commonMapper.insertAlarm(vo.getAlarmVO());
		
		return replyMapper.pushReplyLikeButton(replyLikeVO) == 1 && replyMapper.plusReplyLikeCount(replyLikeVO.getReply_num()) == 1; 
	}
	
	@Transactional
	@Override
	public boolean pushReplyDislikeButton(commonVO vo) {//댓글 싫어요 버튼 누르기
		
		log.info("pushReplyDislikeButton...." + vo);
		
		ReplyDisLikeVO replyDislikeVO = vo.getReplyDisLikeVO();
		
		log.info("insertAlarm");
		
		commonMapper.insertAlarm(vo.getAlarmVO());
		
		return replyMapper.pushReplyDislikeButton(replyDislikeVO) == 1 && replyMapper.plusReplyDislikeCount(replyDislikeVO.getReply_num()) == 1; 
	}
		
	@Transactional
	@Override
	public boolean pullReplyLikeButton(commonVO vo) {//댓글 좋아요 당기기(취소)
		
		log.info("pullReplyLikeButton...." + vo);
		
		ReplyLikeVO replyLikeVO = vo.getReplyLikeVO();
		
		log.info("deleteAlarm");
		
		commonMapper.deleteAlarm(vo.getAlarmVO());
		
		return replyMapper.pullReplyLikeButton(replyLikeVO) == 1 && replyMapper.minusReplyLikeCount(replyLikeVO.getReply_num()) == 1; 
	}
	
	@Transactional
	@Override
	public boolean pullReplyDislikeButton(commonVO vo) {//댓글 싫어요 당기기(취소)
		
		log.info("pullReplyDislikeButton...." + vo);
		
		ReplyDisLikeVO replyDislikeVO = vo.getReplyDisLikeVO();
		
		log.info("deleteAlarm");
		
		commonMapper.deleteAlarm(vo.getAlarmVO());
																					
		return replyMapper.pullReplyDislikeButton(replyDislikeVO) == 1 && replyMapper.minusReplyDislikeCount(replyDislikeVO.getReply_num()) == 1; 
	}
		
	@Override
	public String getLikeCount(Long reply_num) {
  
		log.info("getLikeCount");
		
		return replyMapper.getLikeCount(reply_num);
	}
	
	@Override
	public String getDislikeCount(Long reply_num) {
 
		log.info("getDislikeCount");
		
		return replyMapper.getDislikeCount(reply_num);
	}
		
}

