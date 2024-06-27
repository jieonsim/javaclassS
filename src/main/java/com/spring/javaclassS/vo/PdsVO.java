package com.spring.javaclassS.vo;

import lombok.Data;

@Data
public class PdsVO {
	private int idx;
	private String mid;
	private String nickName;
	private String fName;
	private String fSName;
	private int fSize;
	private String title;
	private String part;
	private String fDate;
	private int downNum;
	private String openSw;
	private String hostIp;
	private String content;
	
	private int date_diff;
	private int hour_diff;
	
}
