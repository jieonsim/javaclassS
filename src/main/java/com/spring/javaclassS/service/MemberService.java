package com.spring.javaclassS.service;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS.vo.MemberVO;

public interface MemberService {

	public MemberVO getMemberIdCheck(String mid);

	public MemberVO getMemberNickCheck(String nickName);

	public int setMemberJoinOk(MemberVO vo);

	public void setMemberPasswordUpdate(String mid, String pwd);

	public MemberVO findMid(String name, String email);

	public void setMemberInforUpdate(String mid, int point);

	public int setPwdChangeOk(String mid, String pwd);

	public void fileUpload(MultipartFile fName, MemberVO vo);

	public ArrayList<MemberVO> getMemberList(int level);
}
