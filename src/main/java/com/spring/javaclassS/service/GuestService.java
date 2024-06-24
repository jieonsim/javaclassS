package com.spring.javaclassS.service;

import java.util.ArrayList;

import com.spring.javaclassS.vo.GuestVO;

public interface GuestService {

	public ArrayList<GuestVO> getGuestList();

	public int setGuestInput(GuestVO vo);

	public int getTotRecCnt();

	public ArrayList<GuestVO> getGuestList(int startIndexNo, int pageSize);

}
