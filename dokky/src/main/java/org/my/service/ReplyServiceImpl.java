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
	private ReplyMapper mapper;

	@Setter(onMethod_ = @Autowired)
	private BoardMapper boardMapper;
	
	@Setter(onMethod_ = @Autowired)
	private CommonMapper commonMapper;
		
	@Transactional
	@Override
	public int register(commonVO vo) {
		
		log.info("register......" + vo);
		
		ReplyVO replyVO = vo.getReplyVO();

		log.info("updateReplyCnt......" + vo);
		boardMapper.updateReplyCnt(replyVO.getNum(),1);
		
		log.info("insertAlarm: ");
		commonMapper.insertAlarm(vo.getAlarmVO());
		
		log.info("insert......" + replyVO); 
		
		if(replyVO.getParent_num() == 0 ) {//시퀀스값은 디폴트 1부터 시작하니까 0으로 기준을 잡자
			return mapper.insert(replyVO);//일반 루트 부모 댓글 입력
		}else {//자식 댓글 입력
			List<ReplyVO> list = mapper.selectNextReply(replyVO);//이게 댓글의 순서를 결정하는 아주 중요한 핵심
			/*한개의 루트그룹 기준으로 생각할때 대댓글의 그룹순서는 대댓글을 달고자 하는 대상인 부모댓글(루트가 아닌 경우도 포함)보다
			그룹 순서가 크면서(밑에 있으면서) 깊이가 작거나 같은 최초의 댓글의 그룹순서가 된다*/
			if(list.isEmpty()){//그런데 최초의 댓글이 없다면
				int lastReplyStep = mapper.lastReplyStep(replyVO.getParent_num());//그룹내에 맨 마지막 댓글의 순서번호를가져오고
				
				replyVO.setOrder_step(lastReplyStep+1);//순서번호에 +1을 해준다 
				
				return mapper.reInsert(replyVO);
			}else{// 최초의 댓글이 있다면
				ReplyVO firstVO = list.get(0);
				
				replyVO.setOrder_step(firstVO.getOrder_step());
				
				log.info("updateOrder_step......");
				mapper.updateOrder_step(replyVO);//나머지 아래 스텝값 모두 1씩 올려줌
				
				log.info("reInsertreplyVO......" + replyVO);
				return mapper.reInsert(replyVO);//최초의 댓글에 해당하는 스텝값으로 변경
			}
		}
	} 
	
	 @Override
	 public ReplyVO get(Long reply_num) {
	
	    log.info("get......" + reply_num);
	
	    return mapper.read(reply_num);
	
	 }

	  @Override
	  public int modify(ReplyVO vo) {
	
	    log.info("modify......" + vo);
	
	    return mapper.update(vo);
	
	  }

    @Transactional
	@Override 
	public int remove(Long reply_num) {

		log.info("remove...." + reply_num);

		ReplyVO vo = mapper.read(reply_num); 

		boardMapper.updateReplyCnt(vo.getNum(), -1);
		
		return mapper.delete(reply_num);
		
		}
	  
	  @Override
	  public ReplyPageDTO getListPage(Criteria cri, Long num) {
	       
	    return new ReplyPageDTO(
	        mapper.getCountBynum(num), 
	        mapper.getListWithPaging(cri, num));
	  }
	  
		@Override
		public String checkLikeValue(ReplyLikeVO vo) { 
			
			log.info("checkLikeValue");
			return mapper.checkLikeValue(vo); 
		}
		
		@Transactional
		@Override
		public int registerLike(commonVO vo) {//댓글 좋아요 첫 컬럼 등록 및 좋아요 push

			ReplyLikeVO replyLikeVO = vo.getReplyLikeVO();
			
			log.info("registerLike...." + vo);
			mapper.registerLike(replyLikeVO); 
			
			log.info("insertAlarm: ");
			commonMapper.insertAlarm(vo.getAlarmVO());
			
			log.info("pushLike....");
			return mapper.pushLike(replyLikeVO.getReply_num()); 
		}
		
		@Transactional
		@Override
		public int pushLike(commonVO vo) {//댓글 좋아요 누르기  
			
			ReplyLikeVO replyLikeVO = vo.getReplyLikeVO();
			
			log.info("pushLikeValue...."+replyLikeVO);  
			mapper.pushLikeValue(replyLikeVO);
			
			log.info("insertAlarm: "+vo.getAlarmVO());
			commonMapper.insertAlarm(vo.getAlarmVO());
			
			log.info("pushLike....");
			return mapper.pushLike(replyLikeVO.getReply_num()); 
		}
		
		@Transactional 
		@Override
		public int pullLike(commonVO vo) {//댓글  좋아요 취소 pull
			
			ReplyLikeVO replyLikeVO = vo.getReplyLikeVO();
			
			log.info("pullLikeValue...."+vo);
			mapper.pullLikeValue(replyLikeVO);
			
			log.info("insertAlarm: ");
			commonMapper.deleteAlarm(vo.getAlarmVO());
			
			log.info("pullLike....");
			return mapper.pullLike(replyLikeVO.getReply_num());
		}
		
		@Override
		public String getLikeCount(Long reply_num) {
	  
			log.info("getLikeCount");
			return mapper.getLikeCount(reply_num);
		}
		
		@Transactional
		@Override
		public int registerDisLike(commonVO vo) {//싫어요 컬럼 등록 및 싫어요 push

			ReplyDisLikeVO replyDisLikeVO = vo.getReplyDisLikeVO();
			
			log.info("registerDisLike...." + vo);
			mapper.registerDisLike(replyDisLikeVO);
			
			log.info("insertAlarm: ");
			commonMapper.insertAlarm(vo.getAlarmVO());
			
			log.info("pushDisLike....");
			return mapper.pushDisLike(replyDisLikeVO.getReply_num()); 
		}
		
		@Transactional
		@Override
		public int pullDisLike(commonVO vo) {//싫어요 취소 pull
			
			ReplyDisLikeVO replyDisLikeVO = vo.getReplyDisLikeVO();
			
			log.info("pulldislikeCheck...."+vo);
			mapper.pulldislikeCheck(replyDisLikeVO); 
			
			log.info("insertAlarm: ");
			commonMapper.deleteAlarm(vo.getAlarmVO());
			
			log.info("pullDisLike....");
			return mapper.pullDisLike(replyDisLikeVO.getReply_num()); 
		}
		
		@Transactional
		@Override 
		public int pushDisLike(commonVO vo) {//싫어요 누르기
			
			ReplyDisLikeVO replyDisLikeVO = vo.getReplyDisLikeVO();
			
			log.info("pushDislikeValue...."+vo);
			mapper.pushDislikeValue(replyDisLikeVO); 
			
			log.info("insertAlarm: "); 
			commonMapper.insertAlarm(vo.getAlarmVO());
			
			log.info("pushDisLike....");
			return mapper.pushDisLike(replyDisLikeVO.getReply_num());
		}
		
		@Override
		public String checkDisLikeValue(ReplyDisLikeVO vo) {
			
			log.info("checkDisLikeValue"); 
			return mapper.checkDisLikeValue(vo); 
		}
		
		@Override
		public String getDisLikeCount(Long num) {
	 
			log.info("getDisLikeCount");
			return mapper.getDisLikeCount(num);
		}
		
		@Transactional
		@Override 
		public String replyDonateMoney(commonVO vo) {
			
			replyDonateVO replyDonateVO = vo.getReplyDonateVO();
			
			log.info("updateMycash");
			boardMapper.updateMycash(replyDonateVO.getMoney(),replyDonateVO.getUserId());
			
			log.info("insertMyCashHistory");
			mapper.insertMyCashHistory(replyDonateVO); 
			 
			log.info("updateReplyUserCash");
			log.info(vo);
			mapper.updateReplyUserCash(replyDonateVO);
			 
			log.info("insertReplyUserCashHistory");
			   mapper.insertReplyUserCashHistory(replyDonateVO);
			
			log.info("updateReplyMoney");
			mapper.updateReplyMoney(replyDonateVO);
			
			log.info("insertAlarm: ");
			commonMapper.insertAlarm(vo.getAlarmVO());
			
			log.info("getReplyMoney");
			return mapper.getReplyMoney(replyDonateVO);
		}
}

