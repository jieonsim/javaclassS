package com.spring.javaclassS.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javaclassS.service.GuestService;
import com.spring.javaclassS.vo.GuestVO;

@Controller
@RequestMapping("/guest")
public class GuestController {
	@Autowired
	GuestService guestService;

	// 방명록 리스트 보여주기
	@RequestMapping(value = "/guestList", method = RequestMethod.GET)
	public String guestListGet(Model model, @RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "3", required = false) int pageSize) {

		int totRecCnt = guestService.getTotRecCnt();
		int totPage = (totRecCnt % pageSize) == 0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;

		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;

		ArrayList<GuestVO> vos = guestService.getGuestList(startIndexNo, pageSize);
		model.addAttribute("vos", vos);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("totPage", totPage);
		model.addAttribute("curScrStartNo", curScrStartNo);
		model.addAttribute("blockSize", blockSize);
		model.addAttribute("curBlock", curBlock);
		model.addAttribute("lastBlock", lastBlock);
		
		return "guest/guestList";
	}

	@RequestMapping(value = "/guestInput", method = RequestMethod.GET)
	public String guestInputGet() {
		return "guest/guestInput";
	}

	@RequestMapping(value = "/guestInput", method = RequestMethod.POST)
	public String guestInputPost(GuestVO vo) {
		System.out.println("hostIp : " + vo.getHostIp());
		int res = guestService.setGuestInput(vo);
		if (res != 0) {
			return "redirect:/message/guestInputOk";
		} else {
			return "redirect:/message/guestInputNo";
		}
	}
}
