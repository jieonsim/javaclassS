package com.spring.javaclassS.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javaclassS.service.AdminService;
import com.spring.javaclassS.service.GuestService;
import com.spring.javaclassS.service.MemberService;
import com.spring.javaclassS.vo.GuestVO;
import com.spring.javaclassS.vo.MemberVO;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	AdminService adminService;

	@Autowired
	MemberService memberService;

	@Autowired
	GuestService guestService;

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

	@RequestMapping(value = "/guest/guestList", method = RequestMethod.GET)
	public String guestListGet(Model model, @RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "3", required = false) int pageSize) {

		int totRecCnt = adminService.getGuestListTotRecCnt();
		int totPage = (totRecCnt % pageSize) == 0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;

		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;

		ArrayList<GuestVO> vos = adminService.getGuestList(startIndexNo, pageSize);
		model.addAttribute("vos", vos);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("totPage", totPage);
		model.addAttribute("curScrStartNo", curScrStartNo);
		model.addAttribute("blockSize", blockSize);
		model.addAttribute("curBlock", curBlock);
		model.addAttribute("lastBlock", lastBlock);
		return "admin/guest/guestList";
	}

	@RequestMapping(value = "/board/boardList", method = RequestMethod.GET)
	public String boardListGet() {
		return "admin/board/boardList";
	}

	@RequestMapping(value = "/member/memberList", method = RequestMethod.GET)
	public String memberListGet(HttpSession session, Model model, @RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "10", required = false) int pageSize) {
		int level = (Integer) session.getAttribute("sLevel");

		ArrayList<MemberVO> vos = memberService.getMemberList(level);
		model.addAttribute("vos", vos);
		return "admin/member/memberList";
	}

	@RequestMapping(value = "/complaint/complaintList", method = RequestMethod.GET)
	public String complaintListGet() {
		return "admin/complaint/complaintList";
	}

}