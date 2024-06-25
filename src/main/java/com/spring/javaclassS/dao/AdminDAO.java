package com.spring.javaclassS.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS.vo.GuestVO;

public interface AdminDAO {

	public int getMemberTotRecCnt(@Param("level") int level);

	public ArrayList<GuestVO> getMemberList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("level") int level);

	public int setMemberLevelCheck(@Param("idx") int idx, @Param("level") int levelSelect);

	public int setMemberDeleteOk(@Param("idx") int idx);
}
