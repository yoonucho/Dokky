package org.my.domain;
	import java.util.Date;
	import lombok.Data;
	
@Data
public class cashVO {  
	  private Long cash_num;
	  private String cashKind;
	  private Long cashAmount;
	  private String userId;
	  private String specification;
	  private String title;
	  private String reply_content;
	  private Long board_num;
	  private Date regDate;
}
