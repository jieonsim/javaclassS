package com.spring.javaclassS.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaclassS.common.JavaclassProvide;
import com.spring.javaclassS.service.AdminService;
import com.spring.javaclassS.service.MemberService;
import com.spring.javaclassS.vo.GuestVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	MemberService memberService;
		
	@Autowired
	JavaclassProvide javaclassProvide;
	
	@RequestMapping(value = "/adminMain", method = RequestMethod.GET)
	public String adminMainGet() {
		return "admin/adminMain";
	}
	
	@RequestMapping(value = "/adminLeft", method = RequestMethod.GET)
	public String adminLeftGet() {
		return "admin/adminLeft";
	}
	
	@RequestMapping(value = "/adminContent", method = RequestMethod.GET)
	public String adminContentGet() {
		return "admin/adminContent";
	}
	
	@RequestMapping(value = "/member/memberList", method = RequestMethod.GET)
	public String memberListGet(HttpSession session, Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name="level", defaultValue = "99", required = false) int level
		) {
		int totRecCnt = adminService.getMemberTotRecCnt(level);
		int totPage = (totRecCnt % pageSize) == 0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		ArrayList<GuestVO> vos = adminService.getMemberList(startIndexNo, pageSize, level);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("totPage", totPage);
		model.addAttribute("curScrStartNo", curScrStartNo);
		model.addAttribute("blockSize", blockSize);
		model.addAttribute("curBlock", curBlock);
		model.addAttribute("lastBlock", lastBlock);
		
		return "admin/member/memberList";
	}
	
	// 회원 등급 변경하기
	@ResponseBody
	@RequestMapping(value = "/member/memberLevelChange", method = RequestMethod.POST)
	public String memberLevelChangePost(int idx, int level) {
		return adminService.setMemberLevelCheck(idx, level) + "";
	}
	
	// 선택한 회원 전체적으로 등급 변경하기
	@ResponseBody
	@RequestMapping(value = "/member/memberLevelSelectCheck", method = RequestMethod.POST)
	public String memberLevelSelectCheckPost(String idxSelectArray, int levelSelect) {
		//int res = adminService.setLevelSelectCheck(idxSelectArray, levelSelect);
		return adminService.setLevelSelectCheck(idxSelectArray, levelSelect);
	}
	
	// 선택한 회원 영구 삭제하기
	@ResponseBody
	@RequestMapping(value = "/member/memberDeleteOk", method = RequestMethod.POST)
	public String memberDeleteOkPost(int idx, String photo) {
		// 사진도 함께 삭제처리한다.(noimage.jpg가 아닐경우)
		if(!photo.equals("noimage.jpg")) javaclassProvide.deleteFile(photo, "member");
		
		return adminService.setMemberDeleteOk(idx) + "";
	}
	
	@RequestMapping(value = "/guest/guestList", method = RequestMethod.GET)
	public String adminLeftGetGet() {
		return "admin/guest/guestList";
	}
}
