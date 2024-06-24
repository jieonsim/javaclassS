package com.spring.javaclassS.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS.vo.GuestVO;

public interface AdminDAO {

	public int getGuestListTotRecCnt();

	public ArrayList<GuestVO> getGuestList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

}
