package com.spring.javaclassS.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaclassS.service.DbtestService;
import com.spring.javaclassS.vo.UserVO;

@Controller
@RequestMapping("/dbtest")
public class DbtestController {

	@Autowired
	DbtestService dbtestService;

	@RequestMapping(value = "/dbtestList", method = RequestMethod.GET)
	public String dbtestListGet(Model model) {
		ArrayList<UserVO> vos = dbtestService.getDbtestList();
		model.addAttribute("vos", vos);
		return "user/dbtestList";
	}

	@RequestMapping(value = "/dbtestSearch/{mid}", method = RequestMethod.GET)
	public String dbtestSearchGet(Model model, @PathVariable String mid) {
		ArrayList<UserVO> vos = dbtestService.getDbtestList();
		model.addAttribute("vos", vos);

		ArrayList<UserVO> searchVos = dbtestService.getDbtestSearch(mid);
		model.addAttribute("searchVos", searchVos);

		return "user/dbtestList";
	}

	@RequestMapping(value = "/dbtestDelete", method = RequestMethod.GET)
	public String dbtestDeleteGet(int idx) {
		int res = dbtestService.setDbtestDelete(idx);

		if (res != 0)
			return "redirect:/message/dbtestDeleteOk";
		else
			return "redirect:/message/dbtestDeleteNo";
	}

	@RequestMapping(value = "/dbtestInputOk", method = RequestMethod.POST)
	public String dbtestInputOkPost(UserVO vo) {
		int res = dbtestService.setDbtestInputOk(vo);

		if (res != 0) {
			return "redirect:/message/dbtestInputOk";
		} else {
			return "redirect:/message/dbtestInputNo";
		}
	}

	@RequestMapping(value = "/dbtestUpdateOk", method = RequestMethod.POST)
	public String dbtestUpdateOkPost(UserVO vo) {
		int res = dbtestService.setDbtestUpdateOk(vo);

		if (res != 0) {
			return "redirect:/message/dbtestUpdateOk";
		} else {
			return "redirect:/message/dbtestUpdateNo";
		}
	}

	@RequestMapping(value = "/dbtestWindow", method = RequestMethod.GET)
	public String dbtestWindowGet(String mid, Model model) {
		UserVO vo = dbtestService.getUserIdCheck(mid);

		String idCheck = "";
		
		if (vo != null) {
			idCheck = "NO";
		} else {
			idCheck = "OK";
		}

		model.addAttribute("mid", mid);
		model.addAttribute("idCheck", idCheck);

		return "user/dbtestWindow";
	}
}