package com.spring.javaclassS.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaclassS.common.JavaclassProvide;
import com.spring.javaclassS.pagination.PageProcess;
import com.spring.javaclassS.service.DbShopService;
import com.spring.javaclassS.service.MemberService;
import com.spring.javaclassS.vo.DbProductVO;

@Controller
@RequestMapping("/dbShop")
public class DbShopController {

	@Autowired
	DbShopService dbShopService;

	@Autowired
	MemberService memberService;

	@Autowired
	PageProcess pageProcess;

	@Autowired
	JavaclassProvide javaclassProvide;

	@RequestMapping(value = "/dbCategory", method = RequestMethod.GET)
	public String adminMainGet(Model model) {
		List<DbProductVO> mainVOS = dbShopService.getCategoryMain();
		//List<DbProductVO> middleVOS = dbShopService.getCategoryMiddle();

		model.addAttribute("mainVOS", mainVOS);
		//model.addAttribute("middleVOS", middleVOS);
		return "admin/dbShop/dbCategory";
	}

	// 대분류 등록하기
	@RequestMapping(value = "/categoryMainInput", method = RequestMethod.POST)
	@ResponseBody
	public String categoryMainInputPost(DbProductVO vo) {
		// 현재 기존에 생성된 대분류명이 있는지 체크
		DbProductVO productVO = dbShopService.getCategoryMainOne(vo.getCategoryMainCode(),
				vo.getCategoryMainName());

		if (productVO != null)
			return "0";

		int res = dbShopService.setCategoryMainInput(vo);

		return res + "";
	}

	// 중분류 등록하기
	@RequestMapping(value = "/categoryMiddleInput", method = RequestMethod.POST)
	@ResponseBody
	public String categoryMiddleInputPost(DbProductVO vo) {
		// 현재 기존에 생성된 중분류명이 있는지 체크
		DbProductVO productVO = dbShopService.getCategoryMiddleOne(vo);

		if (productVO != null)
			return "0";

		int res = dbShopService.setCategoryMiddleInput(vo);

		return res + "";
	}

	// 대분류 삭제하기
	@RequestMapping(value = "/categoryMainDelete", method = RequestMethod.POST)
	@ResponseBody
	public String categoryMainDeletePost(DbProductVO vo) {
		// 삭제하려는 대분류의 하위 항목 있는지 체크
		DbProductVO middleVO = dbShopService.getCategoryMiddleOne(vo);

		if (middleVO != null)
			return "0";

		int res = dbShopService.setCategoryMainDelete(vo.getCategoryMainCode());

		return res + "";
	}
	// 중분류 삭제하기
	/*
	 * @RequestMapping(value = "/categoryMainDelete", method = RequestMethod.POST)
	 * 
	 * @ResponseBody public String categoryMainDeletePost(DbProductVO vo) { // 삭제하려는
	 * 대분류의 하위 항목 있는지 체크 DbProductVO middleVO =
	 * dbShopService.getCategoryMiddleOne(vo);
	 * 
	 * if (middleVO != null) return "0";
	 * 
	 * int res = dbShopService.setCategoryMainDelete(vo.getCategoryMainCode());
	 * 
	 * return res + ""; }
	 */

}
