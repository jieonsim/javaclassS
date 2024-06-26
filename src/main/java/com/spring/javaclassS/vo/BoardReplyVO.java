package com.spring.javaclassS.vo;

import lombok.Data;

@Data
public class BoardReplyVO {
	private int idx;
	private int boardIdx;
	private int re_step;
	private int re_order;
	private String mid;
	private String nickName;
	private String WDate;
	private String hostIp;
	private String content;
}
