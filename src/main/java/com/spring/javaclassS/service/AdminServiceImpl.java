package com.spring.javaclassS.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS.dao.AdminDAO;
import com.spring.javaclassS.vo.GuestVO;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	AdminDAO adminDAO;

	@Override
	public int getMemberTotRecCnt(int level) {
		return adminDAO.getMemberTotRecCnt(level);
	}

	@Override
	public ArrayList<GuestVO> getMemberList(int startIndexNo, int pageSize, int level) {
		return adminDAO.getMemberList(startIndexNo, pageSize, level);
	}

	@Override
	public int setMemberLevelCheck(int idx, int level) {
		return adminDAO.setMemberLevelCheck(idx, level);
	}

	@Override
	public String setLevelSelectCheck(String idxSelectArray, int levelSelect) {
		String[] idxSelectArrays = idxSelectArray.split("/");
		
		String str = "0";
		for(String idx : idxSelectArrays) {
			adminDAO.setMemberLevelCheck(Integer.parseInt(idx), levelSelect);
			str = "1";
		}
		return str;
	}

	@Override
	public int setMemberDeleteOk(int idx) {
		return adminDAO.setMemberDeleteOk(idx);
	}
}
