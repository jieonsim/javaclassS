package com.spring.javaclassS.service;

import java.util.ArrayList;

import com.spring.javaclassS.vo.GuestVO;

public interface AdminService {

	public int getMemberTotRecCnt(int level);

	public ArrayList<GuestVO> getMemberList(int startIndexNo, int pageSize, int level);

	public int setMemberLevelCheck(int idx, int level);

	public String setLevelSelectCheck(String idxSelectArray, int levelSelect);

	public int setMemberDeleteOk(int idx);

}
