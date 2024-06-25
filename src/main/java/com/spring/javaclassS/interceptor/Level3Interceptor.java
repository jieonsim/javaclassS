package com.spring.javaclassS.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

// 준회원 / 비회원 사용 처리
public class Level3Interceptor extends HandlerInterceptorAdapter {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();

		int level = session.getAttribute("sLevel") == null ? 99 : (int) session.getAttribute("sLevel");

		// 관리자(0), 우수회원(1), 정회원(2), 준회원(3), 비회원(99), 탈퇴회원(999)
		if (level > 3) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/message/memberNo");
			dispatcher.forward(request, response);
			return false;
		}
		return true;
	}
}
