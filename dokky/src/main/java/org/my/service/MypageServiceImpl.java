package org.my.service;
	import java.util.List;
	import org.my.domain.BoardVO;
	import org.my.domain.Criteria;
	import org.my.domain.MemberVO;
	import org.my.domain.ReplyVO;
	import org.my.domain.cashVO;
	import org.my.domain.scrapVO;
	import org.my.mapper.MypageMapper;
	import org.springframework.beans.factory.annotation.Autowired;
	import org.springframework.security.crypto.password.PasswordEncoder;
	import org.springframework.stereotype.Service;
	import org.springframework.transaction.annotation.Transactional;
	import lombok.Setter;
	import lombok.extern.log4j.Log4j;

@Log4j 
@Service
public class MypageServiceImpl implements MypageService {

	@Setter(onMethod_ = @Autowired)
	private MypageMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwencoder;
	
	@Override
	public MemberVO getMyInfo(String userId) {

		log.info("get MemberVO");

		return mapper.getMyInfo(userId);
	}
	
	@Transactional
	@Override
	public boolean updateMyInfo(MemberVO board) {

		log.info("updateMyInfo......" + board);
		
		String nickName = board.getNickName();
		
		String userId = board.getUserId();
		
		boolean nickNameResult = nickName.equals(mapper.getMyNickName(userId));
		
		if(!nickNameResult) {//닉네임을 변경한다면 
			
			mapper.updateBoardNickName(userId, nickName);//게시글 닉네임 변경처리
			
			mapper.updateReplyNickName(userId, nickName);//댓글 닉네임 변경처리
			
			mapper.updateNoteFromNickName(userId, nickName);//쪽지 받는이 닉네임 변경처리
			
			mapper.updateNoteToNickName(userId, nickName);//쪽지 보낸이 닉네임 변경처리
			
			mapper.updateAlarmNickName(userId, nickName);//알림 닉네임 변경처리
		}
		
		boolean updateResult = mapper.updateMyInfo(board) == 1; //회원테이블 변경처리
		
		return updateResult;
	}
	
	@Override
	public String getMemberPW(String userId) {

		log.info("getMemberPW");

		return mapper.getMemberPW(userId);
	}
	
	@Override
	public boolean updateMyPassword(String userId, String userPw) {
		
		log.info("updateMyPassword1");
		
		boolean updateResult = mapper.updateMyPassword(userId,userPw) == 1; 
		
		return updateResult;
	}
	@Override
	public List<BoardVO> getMyBoardList(Criteria cri) {

		log.info("getMyBoardList with criteria: " + cri);

		return mapper.getMyBoardList(cri);
	}
	
	@Override
	public int getMyBoardCount(Criteria cri) {

		log.info("getMyBoardCount");
		
		return mapper.getMyBoardCount(cri);
	}
	
	@Override
	 public List<ReplyVO> getMyReplylist(Criteria cri) {
	       
		log.info("getMyReplylist with criteria: " + cri);
		
	    return mapper.getMyReplylist(cri); 
	 }
	
	@Override
	public int getMyReplyCount(Criteria cri) {

		log.info("getMyReplyCount");
		
		return mapper.getMyReplyCount(cri);
	}
	
	@Override
	public int getScrapCnt(int board_num, String userId) {
		
		log.info("getScrapCnt");
		
		int getResult = mapper.getScrapCnt(board_num,userId); 
		
		return getResult;
	}
	
	@Override
	public int deleteScrap(int board_num, String userId) {
		
		log.info("deleteScrap");
		
		int deleteResult = mapper.deleteScrap(board_num, userId); 
		
		return deleteResult;
	}
	
	@Override
	public boolean insertScrapData(int board_num, String userId) {
		
		log.info("insertScrapData");
		
		boolean inserResult = mapper.insertScrapData(board_num, userId) == 1; 
		
		return inserResult;
	}
	
	@Override
	public List<scrapVO> getMyScraplist(Criteria cri) {

		log.info("getMyScraplist with criteria: " + cri);

		return mapper.getMyScraplist(cri);
	}
	
	@Override
	public int getMyScrapCount(String userId) {
		
		log.info("getMyScrapCount");
		
		int getResult = mapper.getMyScrapCount(userId); 
		
		return getResult;
	}
	
	@Override
	public boolean insertChargeData(cashVO vo) {
		
		log.info("insertChargeData");
		
		boolean inserResult = mapper.insertChargeData(vo) == 1; 
		
		return inserResult;
	}
	
	@Override
	public boolean insertReChargeData(cashVO vo) {
		
		log.info("insertReChargeData");
		
		boolean inserResult = mapper.insertReChargeData(vo) == 1; 
		
		return inserResult;
	}
	
	@Override
	public List<cashVO> getMyCashHistory(Criteria cri) {

		log.info("getMyCashHistory");

		return mapper.getMyCashHistory(cri);
	}
	
	@Override
	public int getMyCashHistoryCount(String userId) {
		
		log.info("getMyCashHistoryCount");
		
		int getResult = mapper.getMyCashHistoryCount(userId); 
		
		return getResult;
	}
	
	@Override
	
	public void removeAllScrap(Long scrap_num) {
		log.info("removeAllScrap");
		
		mapper.removeScrap(scrap_num);
	}
	
	
	
}

