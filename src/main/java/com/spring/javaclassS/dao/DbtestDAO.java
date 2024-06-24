package com.spring.javaclassS.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS.vo.UserVO;

public interface DbtestDAO {

	public ArrayList<UserVO> getDbtestList();

	public ArrayList<UserVO> getDbtestSearch(@Param(value = "mid") String mid);

	public int setDbtestDelete(@Param(value = "idx") int idx);

	public int setDbtestInputOk(@Param(value = "vo") UserVO vo);

	public int setDbtestUpdateOk(@Param(value = "vo") UserVO vo);

	public UserVO getUserIdCheck(@Param(value = "mid") String mid);

}
