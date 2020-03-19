package org.my.visit;
	import javax.servlet.annotation.WebListener;
	import javax.servlet.http.HttpServletRequest;
	import javax.servlet.http.HttpSession;
	import javax.servlet.http.HttpSessionEvent;
	import javax.servlet.http.HttpSessionListener;
	import org.my.domain.VisitCountVO;
	import org.my.service.CommonService;
	import org.springframework.web.context.WebApplicationContext;
	import org.springframework.web.context.request.RequestContextHolder;
	import org.springframework.web.context.request.ServletRequestAttributes;
	import org.springframework.web.context.support.WebApplicationContextUtils;
	import lombok.extern.log4j.Log4j;

@Log4j  
@WebListener /* web.xml설정 안하고 @WebListener 어노테이션 설정함*/  
public class VisitSessionListener implements HttpSessionListener{
		
	 //@Setter(onMethod_ = @Autowired)
	 private CommonService service;
	 //세션이 생성될 때 호출
	 @Override
	 public void sessionCreated(HttpSessionEvent sessionEvent) {
		
		 log.info("sessionCreated");
		 
		 int todayCount = 0; // 오늘 방문자 수
	     int totalCount = 0; // 전체 방문자 수
		 
		  HttpSession session = sessionEvent.getSession(); 	
		  WebApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
		  //service =  (CommonService) ctx.getBean("CommonServiceImpl"); 
		  service =  (CommonService) ctx.getBean("commonServiceImpl");
		   
		  HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
			
		  VisitCountVO vo = new VisitCountVO();
		  
			  //vo.setIp(request.getRemoteAddr());//정확한 아이피 못가져옴
			  vo.setIp(getClientIpAddr(request));
		      vo.setAgent(request.getHeader("User-Agent"));//브라우저 정보
		      vo.setRefer(request.getHeader("referer"));//접속 전 사이트 정보
	      
	      service.insertVisitor(vo);
	       
	      todayCount = service.getVisitTodayCount();//0
	      totalCount = service.getVisitTotalCount();
          
	      session.setAttribute("totalCount", totalCount); 
	      session.setAttribute("todayCount", todayCount);
	      
	      String tests1 = service.tests1();//0
	      String tests2 = service.tests2();//0
	      String tests3 = service.tests3();//0
	      String tests4 = service.tests4();//0
	      String tests5 = service.tests5();//0
	      String tests6 = service.tests6();//0
	      log.info("tests11111"+tests1);
	      log.info("tests22222"+tests2);
	      log.info("tests33333"+tests3);
	      log.info("tests44444"+tests4);
	      log.info("tests55555"+tests5);
	      log.info("tests66666"+tests6);
		
	 }
	 @Override  //세션이 파괴될 때 호출
	 public void sessionDestroyed(HttpSessionEvent sessionEvent) {
		 log.info("sessionDestroyed");
	 }
	 
	 public String getClientIpAddr(HttpServletRequest request) {  //아이피가 정확히 안나올시
	        String ip = request.getHeader("X-Forwarded-For"); 
	        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	            ip = request.getHeader("Proxy-Client-IP");  
	        }  
	        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	            ip = request.getHeader("WL-Proxy-Client-IP");  
	        }  
	        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	            ip = request.getHeader("HTTP_CLIENT_IP");  
	        }  
	        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	            ip = request.getHeader("HTTP_X_FORWARDED_FOR");  
	        }  
	        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
	            ip = request.getRemoteAddr();  
	        }  
	        return ip;  
	    }

	 
}
	

      
    
