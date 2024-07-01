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

	public String fileUpload(MultipartFile fName, String mid, String photo);

	public ArrayList<MemberVO> getMemberList(int level);

	public int setMemberUpdateOk(MemberVO vo);

	public int setUserDel(String mid);

	public MemberVO getMemberNickNameEmailCheck(String nickName, String email);

	public void setKaKaoMemberInput(String mid, String pwd, String nickName, String email);
}
