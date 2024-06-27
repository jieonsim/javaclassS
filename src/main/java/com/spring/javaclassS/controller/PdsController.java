package com.spring.javaclassS.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartRequest;

import com.spring.javaclassS.common.JavaclassProvide;
import com.spring.javaclassS.pagination.PageProcess;
import com.spring.javaclassS.service.PdsService;
import com.spring.javaclassS.vo.PageVO;
import com.spring.javaclassS.vo.PdsVO;

@Controller
@RequestMapping("/pds")
public class PdsController {

	@Autowired
	PdsService pdsService;

	@Autowired
	PageProcess pageProcess;

	@Autowired
	JavaclassProvide javaclassProvide;

	@RequestMapping(value = "/pdsList", method = RequestMethod.GET)
	public String pdsListGet(Model model,
			@RequestParam(name = "part", defaultValue = "전체", required = false) String part,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "5", required = false) int pageSize) {

		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "pds", part, "");

		List<PdsVO> vos = pdsService.getPdsList(pageVO.getStartIndexNo(), pageSize, part);

		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);

		return "pds/pdsList";
	}

	@RequestMapping(value = "/pdsInput", method = RequestMethod.GET)
	public String pdsInputGet(
			@RequestParam(name = "part", defaultValue = "전체", required = false) String part) {
		return "pds/pdsInput";
	}

	@RequestMapping(value = "/pdsInput", method = RequestMethod.POST)
	public String pdsInputPost(MultipartRequest mFile, PdsVO vo) {

		int res = pdsService.setPdsUpload(mFile, vo);

		if (res != 0) {
			return "redirect:/message/pdsUploadOk";
		} else {
			return "redirect:/message/pdsUploadNo";
		}
	}

	@RequestMapping(value = "/pdsDownNumCheck", method = RequestMethod.POST)
	@ResponseBody
	public String pdsDownNumCheckPost(int idx) {
		return pdsService.pdsDownNumPlus(idx) + "";
	}

	@RequestMapping(value = "/pdsDeleteCheck", method = RequestMethod.POST)
	@ResponseBody
	public String pdsDeleteCheckPost(int idx, String fSName, HttpServletRequest request) {
		return pdsService.pdsDelete(idx, fSName, request) + "";
	}

	@RequestMapping(value = "/pdsContent", method = RequestMethod.GET)
	public String pdsContentGet(Model model, int idx,
			@RequestParam(name = "part", defaultValue = "전체", required = false) String part,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "5", required = false) int pageSize) {
		PdsVO vo = pdsService.getPdsContent(idx);
		model.addAttribute("vo", vo);
		return "pds/pdsContent";
	}
}
