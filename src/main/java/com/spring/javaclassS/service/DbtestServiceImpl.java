package com.spring.javaclassS.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS.dao.DbtestDAO;
import com.spring.javaclassS.vo.UserVO;

@Service
public class DbtestServiceImpl implements DbtestService {
	@Autowired
	DbtestDAO dbtestDAO;

	@Override
	public ArrayList<UserVO> getDbtestList() {
		return dbtestDAO.getDbtestList();
	}

	@Override
	public ArrayList<UserVO> getDbtestSearch(String mid) {
		return dbtestDAO.getDbtestSearch(mid);
	}

	@Override
	public int setDbtestDelete(int idx) {
		return dbtestDAO.setDbtestDelete(idx);
	}

	@Override
	public int setDbtestInputOk(UserVO vo) {
		return dbtestDAO.setDbtestInputOk(vo);
	}

	@Override
	public int setDbtestUpdateOk(UserVO vo) {
		return dbtestDAO.setDbtestUpdateOk(vo);
	}

	@Override
	public UserVO getUserIdCheck(String mid) {
		return dbtestDAO.getUserIdCheck(mid);
	}
}
