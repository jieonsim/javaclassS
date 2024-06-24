package com.spring.javaclassS.service;

import java.util.List;

import com.spring.javaclassS.vo.UserVO;

public interface UserService {

	public List<UserVO> getUserList();

	public int setUserDelete(int idx);

	public int setUserInputOk(UserVO vo);

	public List<UserVO> getUserIdSearch(String mid);

	public int setUserUpdateOk(UserVO vo);
}
