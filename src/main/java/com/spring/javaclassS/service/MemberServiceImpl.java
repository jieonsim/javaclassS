package com.spring.javaclassS.service;

import java.util.ArrayList;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS.common.JavaclassProvide;
import com.spring.javaclassS.dao.MemberDAO;
import com.spring.javaclassS.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	MemberDAO memberDAO;
	
	@Autowired
	JavaclassProvide javaclassProvide;

	@Override
	public MemberVO getMemberIdCheck(String mid) {
		return memberDAO.getMemberIdCheck(mid);
	}

	@Override
	public MemberVO getMemberNickCheck(String nickName) {
		return memberDAO.getMemberNickCheck(nickName);
	}

	@Override
	public int setMemberJoinOk(MemberVO vo) {
		return memberDAO.setMemberJoinOk(vo);
	}

	@Override
	public void setMemberPasswordUpdate(String mid, String pwd) {
		memberDAO.setMemberPasswordUpdate(mid, pwd);
	}

	@Override
	public MemberVO findMid(String name, String email) {
		return memberDAO.findMid(name, email);
	}

	@Override
	public void setMemberInforUpdate(String mid, int point) {
		memberDAO.setMemberInforUpdate(mid, point);
	}

	@Override
	public int setPwdChangeOk(String mid, String pwd) {
		return memberDAO.setPwdChangeOk(mid, pwd);
	}

	@Override
	public void fileUpload(MultipartFile fName, MemberVO vo) {
		String urlPath = "member";
		
		UUID uid = UUID.randomUUID();
		String oFileName = fName.getOriginalFilename();
		String sFileName = vo.getMid() + "_" + uid.toString().substring(0, 8) + "_" + oFileName;
		
		try {
			javaclassProvide.writeFile(fName, sFileName, urlPath);
			vo.setPhoto(sFileName);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public ArrayList<MemberVO> getMemberList(int level) {
		return memberDAO.getMemberList(level);
	}
}