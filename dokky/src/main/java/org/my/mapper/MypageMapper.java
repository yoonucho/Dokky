package org.my.mapper;
	import java.util.List;
	import org.apache.ibatis.annotations.Param;
	import org.my.domain.BoardVO;
	import org.my.domain.Criteria;
	import org.my.domain.MemberVO;
	import org.my.domain.ReplyVO;
	import org.my.domain.cashVO;
	import org.my.domain.scrapVO;

public interface MypageMapper {

	public MemberVO getMyInfo(String userId);

	public int updateMyInfo(MemberVO board);
	
	public String getMyNickName(String userId);
	
	public void updateBoardNickName(@Param("userId") String userId, @Param("nickName") String nickName);
	
	public void updateReplyNickName(@Param("userId") String userId, @Param("nickName") String nickName);

	public void updateNoteFromNickName(@Param("userId") String userId, @Param("nickName") String nickName);
	
	public void updateNoteToNickName(@Param("userId") String userId, @Param("nickName") String nickName);

	public void updateAlarmNickName(@Param("userId") String userId, @Param("nickName") String nickName);

	public void updateCashlistNickName(@Param("userId") String userId, @Param("nickName") String nickName);
	
	public void updateReportedNickName(@Param("userId") String userId, @Param("nickName") String nickName);

	public void updateReportingNickName(@Param("userId") String userId, @Param("nickName") String nickName);
	
	public List<BoardVO> getMyBoardList(Criteria cri);
	
	public int getMyBoardCount(Criteria cri);

	public List<ReplyVO> getMyReplylist(Criteria cri);

	public int getMyReplyCount(Criteria cri);
	
	public List<scrapVO> getMyScraplist(Criteria cri);
	
	public int getMyScrapCount(String userId);
	
	public void removeScrap(Long scrap_num);
	
	public int insertChargeData(cashVO vo);

	public int insertReChargeData(cashVO vo);
	
	public List<cashVO> getMyCashHistory(Criteria cri);
	
	public int getMyCashHistoryCount(String userId);
	
	public int updateEnabled(String userId);

	/*아래는 현재쓰이지 않는 로직 주석
	 * public String getMemberPW(String userId);
	
	public int updateMyPassword(@Param("userId") String userId, @Param("userPw") String userPw);*/
}
