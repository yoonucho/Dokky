package org.my.mapper;
	import java.util.List;
	import org.my.domain.BoardVO;
	import org.my.domain.MemberVO;

public interface MemberMapper {

	public MemberVO readMembers(String userId);

	public int registerMembers(MemberVO vo);

	public int registerMember_auth(MemberVO vo);

	public int IdCheckedCount(String inputId);

	public int nicknameCheckedCount(String inputNickname);

	public int emailCheckedCount(String inputEmail);

	public List<BoardVO> getRealtimeList();

	public List<BoardVO> getMonthlyList();

	public List<BoardVO> getDonationList();
	
	public int updatePreLoginDate(String userName);

	public int updatelastLoginDate(String userName);
	
}
