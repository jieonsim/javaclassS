package com.spring.javaclassS.vo;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;
import org.hibernate.validator.constraints.Range;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@SuppressWarnings("deprecation")
//@Data
@Setter
@Getter
@ToString
public class TransactionVO {
	private int idx;
	
	@NotEmpty
	@Size(min=3, max=10, message = "아이디 길이가 잘못되었습니다.")
	private String mid;
	
	@Size(min=2, max=20, message = "성명의 길이가 잘못되었습니다.")
	private String name;
	
	@Range(min=19, message = "미성년자는 가입할수 없습니다.")
	private int age;
	
	private String address;
	
	// user2테이블에서의 필드 추가
	private String job;
}
