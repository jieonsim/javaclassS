package com.spring.javaclassS.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartRequest;

import com.spring.javaclassS.vo.PdsVO;

public interface PdsService {

	public List<PdsVO> getPdsList(int startIndexNo, int pageSize, String part);

	public int setPdsUpload(MultipartRequest mFile, PdsVO vo);

	public int pdsDownNumPlus(int idx);

	public int pdsDelete(int idx, String fSName, HttpServletRequest request);

	public PdsVO getPdsContent(int idx);

}
