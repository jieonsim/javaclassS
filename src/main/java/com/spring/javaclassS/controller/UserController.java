package com.spring.javaclassS.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaclassS.service.UserService;
import com.spring.javaclassS.vo.UserVO;

@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	UserService userService;

	// user 리스트
	@RequestMapping(value = "/userList", method = RequestMethod.GET)
	public String getUserList(Model model) {

		List<UserVO> vos = userService.getUserList();

		model.addAttribute("vos", vos);

		return "user/userList";
	}

	// user 1건 삭제처리
	@RequestMapping(value = "/userDelete", method = RequestMethod.GET)
	public String getUserDelete(int idx) {
		int res = userService.setUserDelete(idx);
		if (res != 0)
			return "redirect:/message/userDeleteOk";
		else
			return "redirect:/message/userDeleteNo";
	}

	// user 1건 입력처리
	@RequestMapping(value = "/userInputOk", method = RequestMethod.POST)
	public String getUserInputOk(UserVO vo) {
		int res = userService.setUserInputOk(vo);
		if (res != 0)
			return "redirect:/message/userInputOk";
		else
			return "redirect:/message/userInputNo";
	}

	// user 1건 조회처리, 단 모든 레코드들도 함께 출력한다.
	@RequestMapping(value = "/userSearch/{mid}", method = RequestMethod.GET)
	public String userSearchGet(@PathVariable String mid, Model model) {
		List<UserVO> searchVos = userService.getUserIdSearch(mid);
		model.addAttribute("searchVos", searchVos);

		List<UserVO> vos = userService.getUserList();
		model.addAttribute("vos", vos);

		return "user/userList";
	}

	// user정보 수정하기
	@RequestMapping(value = "/userUpdateOk", method = RequestMethod.POST)
	public String userUpdateOkPost(UserVO vo, Model model) {
		int res = userService.setUserUpdateOk(vo);
		if (res != 0)
			return "redirect:/message/userUpdateOk";
		else
			return "redirect:/message/userUpdateNo";
	}
}
