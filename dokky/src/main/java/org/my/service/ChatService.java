package org.my.service;
	import java.util.List;
	import org.my.domain.ChatMemberVO;
	import org.my.domain.ChatRoomVO;
	import org.my.domain.ChatContentVO;
	import org.my.domain.ChatRoom;

public interface ChatService {
	
	public String hasRoom(String roomOwnerId, String chat_memberId);
	
	public boolean createSingleChat(ChatRoomVO chatRoomVO, ChatMemberVO chatMemberVO);
	
	public List<ChatContentVO> getChatContents(Long chatRoomNum);
	
	public ChatMemberVO getChatMember(Long chatRoomNum, String userId);
	
	public ChatRoom addChatRoom(String chatRoomNum);
	
	public ChatRoom findChatRoom(String id);
	
	public void createChatContent(ChatContentVO chatContentVO);
	
	public void createNoticeContent(ChatContentVO chatContentVO);
	
}
