package com.spring.javaclassS.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS.dao.UserDAO;
import com.spring.javaclassS.vo.UserVO;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	UserDAO userDAO;

	@Override
	public List<UserVO> getUserList() {
		return userDAO.getUserList();
	}

	@Override
	public int setUserDelete(int idx) {
		return userDAO.setUserDelete(idx);
	}

	@Override
	public int setUserInputOk(UserVO vo) {
		return userDAO.setUserInputOk(vo);
	}

	@Override
	public List<UserVO> getUserIdSearch(String mid) {
		return userDAO.getUserIdSearch(mid);
	}

	@Override
	public int setUserUpdateOk(UserVO vo) {
		return userDAO.setUserUpdateOk(vo);
	}
}
