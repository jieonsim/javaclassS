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
	public int getGuestListTotRecCnt() {
		return adminDAO.getGuestListTotRecCnt();
	}

	@Override
	public ArrayList<GuestVO> getGuestList(int startIndexNo, int pageSize) {
		return adminDAO.getGuestList(startIndexNo, pageSize);
	}
}
