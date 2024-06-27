package com.spring.javaclassS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS.vo.PdsVO;

public interface PdsDAO {

	public List<PdsVO> getPdsList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("part") String part);

	public int setPdsUpload(@Param("vo") PdsVO vo);

	public int totRecCnt(@Param("part") String part);

	public int pdsDownNumPlus(@Param("idx") int idx);

	public int pdsDelete(@Param("idx") int idx);

	public PdsVO getPdsContent(@Param("idx") int idx);

}
