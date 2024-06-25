package com.spring.javaclassS.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

// 우수회원 이상 사용 처리
public class Level1Interceptor extends HandlerInterceptorAdapter {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();

		int level = session.getAttribute("sLevel") == null ? 99 : (int) session.getAttribute("sLevel");

		// 관리자(0), 우수회원(1), 정회원(2), 준회원(3), 비회원(99), 탈퇴회원(999)
		if (level > 1) {
			// 비회원
			RequestDispatcher dispatcher;
			if (level == 99) {
				dispatcher = request.getRequestDispatcher("/message/memberNo");
			} else {
				// 정회원, 준회원
				dispatcher = request.getRequestDispatcher("/message/memberLevelNo");
			}
			dispatcher.forward(request, response);
			return false;
		}
		return true;
	}
}
