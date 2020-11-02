package org.my.service;
	import java.util.Date;
	import java.util.LinkedHashMap;
	import java.util.List;
	import java.util.Map;
	import org.my.domain.ChatContentVO;
	import org.my.domain.ChatMemberVO;
	import org.my.domain.ChatReadVO;
	import org.my.domain.ChatRoom;
	import org.my.domain.ChatRoomVO;
	import org.my.domain.Criteria;
	import org.my.domain.ReplyPageDTO;
	import org.my.domain.chatRoomDTO;
	import org.my.mapper.ChatMapper;
	import org.springframework.beans.factory.annotation.Autowired;
	import org.springframework.stereotype.Service;
	import org.springframework.transaction.annotation.Transactional;
	import lombok.Setter;
	import lombok.extern.log4j.Log4j;
	import org.my.domain.chatRoomDTO;
	import java.util.List;
	import java.util.ArrayList;//임포트 해주자

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
			
			chatContentVO.setRegDate(new Date());
			
			int thirdResult = chatMapper.createNoticeContent(chatContentVO);//공지 내용 입력
	    	
    		chatMapper.createChatReadType(chatContentVO.getChatRoomNum(), chatContentVO.getChatContentNum() , chatMemberVO.getChat_memberId(), chatMemberVO.getChat_memberNick(), 1);//공지라 하더라도 채팅 내용불러올시에 읽음처리 값이 필요함
    		chatMapper.createChatReadType(chatContentVO.getChatRoomNum(), chatContentVO.getChatContentNum() , chatRoomVO.getRoomOwnerId(), chatRoomVO.getRoomOwnerNick(),1 );
			
			chatMemberVO.setChat_memberId(chatRoomVO.getRoomOwnerId());
			
			chatMemberVO.setChat_memberNick(chatRoomVO.getRoomOwnerNick());
			
			int fourthResult = chatMapper.createChatMember(chatMemberVO);//채팅 방장 멤버 입력
			
			return firstResult == 1 && secondResult == 1 && thirdResult == 1 && fourthResult == 1 ;
		}
		
		@Override
		public List<ChatContentVO> getChatContents(Long chatRoomNum, Date recentOutDate, String chat_memberId){
	    	
	    	log.info("getChatContents");
	    	
	        return chatMapper.getChatContents(chatRoomNum, recentOutDate, chat_memberId);
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
	    public boolean removeAllChatData(Long chatRoomNum){
	    		
	    	log.info("removeAllChatData");
	    	
	    	if(chatMapper.removeChatRoom(chatRoomNum) == 1){
	    		
		    	chatRoomMap.remove(chatRoomNum.toString());
		    	
		    	log.info("chatRoomMap.remove");

		    	return true;
	    	
	    	}else {
	    		
	    		return false;
	    	}
	    }
		
		@Transactional
		@Override
	    public void createChatContent(ChatContentVO chatContentVO){//채팅 내용 입력
	    		
	    	log.info("createChatContent");
	    	
	    	chatMapper.createChatContent(chatContentVO);
	    	
	    	List<ChatMemberVO> memberList = chatMapper.getChatMembers(chatContentVO.getChatRoomNum());
	    	
	    	log.info("createChatReadType");
	    	
	    	for(ChatMemberVO memberVO : memberList){
	    		
	    		chatMapper.createChatReadType(chatContentVO.getChatRoomNum(), chatContentVO.getChatContentNum() , memberVO.getChat_memberId(), memberVO.getChat_memberNick(), 0);
	    	}
	    }
		
		@Override
	    public void createNoticeContent(ChatContentVO chatContentVO){//공지 내용 입력
	    		
	    	log.info("createNoticeContent");
	    	
	    	chatMapper.createNoticeContent(chatContentVO);
	    	
	    	List<ChatMemberVO> memberList = chatMapper.getChatMembers(chatContentVO.getChatRoomNum());
	    	
	    	log.info("createChatReadType");
	    	
	    	for(ChatMemberVO memberVO : memberList){
	    		
	    		chatMapper.createChatReadType(chatContentVO.getChatRoomNum(), chatContentVO.getChatContentNum() , memberVO.getChat_memberId(), memberVO.getChat_memberNick(), 1);
	    	}
	    }
		
		@Override
		public void updateOutDate(Long chatRoomNum, String chat_memberId, Date date){
	    		
	    	log.info("updateOutDate");
	    	
	    	chatMapper.updateOutDate(chatRoomNum, chat_memberId, date);
		}
		
		@Override
		public Date getRecentOutDate(Long chatRoomNum, String chat_memberId){
			
			log.info("getRecentOutDate");
			
			return chatMapper.getRecentOutDate(chatRoomNum, chat_memberId);
		}	
		
		@Transactional
		@Override
		public boolean updateRoomStatus(Long chatRoomNum, String chat_writerId, int changeCount, int changePosition){
	    		
	    	log.info("updateRoomStatus");
	    	
	    	return chatMapper.updateHeadCount(chatRoomNum, changeCount) == 1 && chatMapper.updatePresent_position(chatRoomNum, changePosition, chat_writerId) == 1;
		}
		
		@Override
		public boolean getMyRoomStatus(Long chatRoomNum, String myId){
			
			log.info("getMyRoomStatus");
			
			return chatMapper.getMyRoomStatus(chatRoomNum, myId) == 1;
		}
		
		@Override
		public int getRoomHeadCount(Long chatRoomNum){
			
			log.info("getRoomHeadCount");
			
			return chatMapper.getRoomHeadCount(chatRoomNum);
		}
		
		@Override
		public int getHeadCount(Long chatRoomNum){
			
			log.info("getHeadCount");
			
			return chatMapper.getHeadCount(chatRoomNum);
		}
		
		@Transactional
		@Override
		public boolean readChat(ChatReadVO vo){
			
			log.info("readChat");
			
			return chatMapper.updateRead_type(vo) == 1 && chatMapper.updateReadCount(vo) == 1;
		}
		
		@Override
		public List<chatRoomDTO> getMyChatRoomList(String userId){
			
			log.info("getMyChatRoomList");
			
			List<chatRoomDTO> myChatRoomList = new ArrayList<>();
		    
			List<ChatRoomVO> myChatRoomVoList = chatMapper.getMyChatRoomVoList(userId);
			
			log.info("myChatRoomVoList="+myChatRoomVoList);
			
			for(ChatRoomVO ChatRoomVo : myChatRoomVoList) {
				
				Long chatRoomNum = ChatRoomVo.getChatRoomNum();
				
				log.info("chatRoomNum="+chatRoomNum);
				
				ChatContentVO ChatContentVo = chatMapper.getMyChatContentVo(chatRoomNum);
				
				log.info("ChatContentVo="+ChatContentVo);
				
				List<ChatReadVO> chatReadVoList = chatMapper.getMyChatReadVo(chatRoomNum, userId);
				
				log.info("chatReadVoList="+chatReadVoList);
				
				int notReadCnt = chatMapper.getNotReadCnt(chatRoomNum, userId);
				
				log.info("notReadCnt="+notReadCnt);
				
				myChatRoomList.add(new chatRoomDTO(ChatRoomVo, ChatContentVo, chatReadVoList, notReadCnt));
			}
			
			return myChatRoomList;
		}
		
}

