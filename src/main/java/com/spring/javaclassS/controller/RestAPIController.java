package com.spring.javaclassS.controller;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

//@Controller
// REST API 개념으로 자료를 전달할 때에는 @RestController 어노테이션을 이용해 규칙을 따른다.
@RestController
@RequestMapping("/restapi")
public class RestAPIController {

	// 브라우저에 직접 출력할 때 @ResponseBody 어노테이션 써주기
	@ResponseBody
	@RequestMapping(value = "/restapiTest2/{message}", method = RequestMethod.GET)
	public String restapiTest2Get(@PathVariable String message) {
		System.out.println("message : " + message);
		return "message: " + message;
	}

	// 위에 @RestController 어노테이션을 걸어줬기 때문에 ResponseBody 어노테이션이 없어도 출력이 된다.  
	@RequestMapping(value = "/restapiTest3/{message}", method = RequestMethod.GET)
	public String restapiTest3Get(@PathVariable String message) {
		System.out.println("message : " + message);
		return "message: " + message;
	}
}
