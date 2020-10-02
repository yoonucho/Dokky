package org.my.service;
	import java.util.Date;
import java.util.LinkedHashMap;
	import java.util.List;
	import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.my.domain.ChatContentVO;
	import org.my.domain.ChatMemberVO;
	import org.my.domain.ChatRoomVO;
	import org.my.mapper.ChatMapper;
	import org.springframework.beans.factory.annotation.Autowired;
	import org.springframework.stereotype.Service;
	import org.springframework.transaction.annotation.Transactional;
	import lombok.Setter;
	import lombok.extern.log4j.Log4j;
	import org.my.domain.ChatRoom;

@Service
@Log4j
public class ChatServiceImpl implements ChatService {
	
		@Setter(onMethod_ = @Autowired)
		private ChatMapper chatMapper;
	
		private Map<String, ChatRoom> chatRoomMap = new LinkedHashMap<>();
	
		
	    @Override
	    public String hasRoom(String roomOwnerId, String chat_memberId) {
	    	
	    	log.info("hasRoom");
	    	
	    	String chatRoomNum = chatMapper.hasRoom(chat_memberId, roomOwnerId);
	    	
	    	if(chatRoomNum != null) {
	    		
	    		return chatRoomNum;
	    		
	    	}else {
	    		
	    		return chatMapper.hasRoom(roomOwnerId, chat_memberId);
	    	}
	    }
		
		@Transactional
		@Override
		public boolean createSingleChat(ChatRoomVO chatRoomVO, ChatMemberVO chatMemberVO) {
			 
			log.info("createSingleChat");
			
			int firstResult = chatMapper.createChatRoom(chatRoomVO);//채팅방 만들기
			
			chatMemberVO.setChatRoomNum(chatRoomVO.getChatRoomNum());
			
			int secondResult = chatMapper.createChatMember(chatMemberVO);//채팅 멤버 입력
			
			ChatContentVO chatContentVO = new ChatContentVO();

			chatContentVO.setChatRoomNum(chatRoomVO.getChatRoomNum());
			
			chatContentVO.setChat_content(chatRoomVO.getRoomOwnerNick()+"님이 "+chatMemberVO.getChat_memberNick()+"님을 초대했습니다");
			
			int thirdResult = chatMapper.createNoticeContent(chatContentVO);//공지 내용 입력
			
			chatMemberVO.setChat_memberId(chatRoomVO.getRoomOwnerId());
			
			chatMemberVO.setChat_memberNick(chatRoomVO.getRoomOwnerNick());
			
			int fourthResult = chatMapper.createChatMember(chatMemberVO);//채팅 방장 멤버 입력
			
			return firstResult == 1 && secondResult == 1 && thirdResult == 1 && fourthResult == 1 ;
		}
		
		@Override
		public List<ChatContentVO> getChatContents(Long chatRoomNum, Date recentOutDate){
	    	
	    	log.info("getChatContents");
	    	
	        return chatMapper.getChatContents(chatRoomNum, recentOutDate);
	    }
		
		@Override
		public ChatMemberVO getChatMember(Long chatRoomNum, String userId){
	    	
	    	log.info("getChatMember");
	    	
	        return chatMapper.getChatMember(chatRoomNum, userId);
	    }
		
		@Override
	    public ChatRoom addChatRoom(String chatRoomNum){
	    	
	    	log.info("addChatRoom");
	    	
	    	ChatRoom chatRoom = chatRoomMap.get(chatRoomNum);
	    	
	    	if(chatRoom == null) {
	    		
	    		chatRoom = new ChatRoom();
	    		
	    		chatRoomMap.put(chatRoomNum, chatRoom);
	    	}
	    	
	        return chatRoom;
	    }
		
		@Override
	    public ChatRoom findChatRoom(String chatRoomNum){
	    		
	    	log.info("findChatRoom");
	    	
	        return chatRoomMap.get(chatRoomNum);
	    }
		
		@Override
	    public void createChatContent(ChatContentVO chatContentVO){//채팅 내용 입력
	    		
	    	log.info("createChatContent");
	    	
	    	chatMapper.createChatContent(chatContentVO);
	    }
		
		@Override
	    public void createNoticeContent(ChatContentVO chatContentVO){//공지 내용 입력
	    		
	    	log.info("createNoticeContent");
	    	
	    	chatMapper.createNoticeContent(chatContentVO);
	    }
		
		@Override
		public void updateOutDate(Long chatRoomNum, String chat_memberId){
	    		
	    	log.info("updateOutDate");
	    	
	    	chatMapper.updateOutDate(chatRoomNum, chat_memberId);
		}
		
		public Date getRecentOutDate(Long chatRoomNum, String chat_memberId){
			
			log.info("getRecentOutDate");
			
			return chatMapper.getRecentOutDate(chatRoomNum, chat_memberId);
		}	
		
		@Transactional
		@Override
		public boolean updateRoomStatus(Long chatRoomNum, String chat_writerId){
	    		
	    	log.info("updateRoomStatus");
	    	
	    	return chatMapper.updateHeadCount(chatRoomNum, -1) == 1 && chatMapper.updatePresent_position(chatRoomNum, 1, chat_writerId) == 1 ;
		}
		
}

