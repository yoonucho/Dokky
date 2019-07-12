package org.my.service;
	import org.my.domain.MemberVO;
	import org.my.mapper.MemberMapper;
	import org.springframework.beans.factory.annotation.Autowired;
	import org.springframework.stereotype.Service;
	import org.springframework.transaction.annotation.Transactional;
	import lombok.Setter;
	import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class MemberServiceImpl implements MemberService {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	@Transactional
	@Override 
	public boolean registerMembers(MemberVO vo) {

		log.info("registerMembers..." + vo);
		
		log.info("registerMember_auth..." + vo);
		
		return mapper.registerMembers(vo) == 1 && mapper.registerMember_auth(vo) == 1;
	}
}
