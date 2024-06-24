package com.spring.javaclassS.service;

import java.util.ArrayList;

import com.spring.javaclassS.vo.GuestVO;

public interface AdminService {

	public int getGuestListTotRecCnt();

	public ArrayList<GuestVO> getGuestList(int startIndexNo, int pageSize);

}
