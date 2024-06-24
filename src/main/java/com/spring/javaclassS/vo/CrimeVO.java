package com.spring.javaclassS.vo;

import lombok.Data;

@Data
public class CrimeVO {
	private int idx;
	private int year;
	private String police;
	private int robbery;
	private int theft;
	private int murder;
	private int violence;
	
	private int totRobbery;
	private int totMurder;
	private int totTheft;
	private int totViolence;
	private int avgRobbery;
	private int avgMurder;
	private int avgTheft;
	private int avgViolence;
}
