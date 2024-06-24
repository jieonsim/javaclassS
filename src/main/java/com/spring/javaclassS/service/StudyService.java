package com.spring.javaclassS.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS.vo.CrimeVO;
import com.spring.javaclassS.vo.MemberVO;
import com.spring.javaclassS.vo.UserVO;

public interface StudyService {

	public String[] getCityStringArray(String dodo);

	public ArrayList<String> getCityArrayList(String dodo);

	public ArrayList<String> getUserMids();
	
	public HashMap<Object, Object> getUserDetails(String mid);

	public UserVO getUserMidSearch(String mid);

	public ArrayList<UserVO> getUserMidList(String mid);

	public void setSaveCrimeDate(CrimeVO vo);
	
	public void setDeleteCrimeDate(int year);

	public ArrayList<CrimeVO> getListCrimeDate(int year);

	public ArrayList<CrimeVO> getYearPoliceCheck(int year, String police, String yearOrder);

	public CrimeVO getAnalyzeTotal(int year, String police);

	public List<MemberVO> getMemberDetails();

	public int fileUpload(MultipartFile fName, String mid);

}
