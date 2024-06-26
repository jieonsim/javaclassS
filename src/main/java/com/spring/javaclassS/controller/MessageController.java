package com.spring.javaclassS.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {

	@RequestMapping(value = "/message/{msgFlag}", method = RequestMethod.GET)
	public String getMessage(Model model, @PathVariable String msgFlag,
			@RequestParam(name = "mid", defaultValue = "", required = false) String mid,
			@RequestParam(name = "idx", defaultValue = "", required = false) String idx,
			@RequestParam(name = "pag", defaultValue = "1", required = false) String pag,
			@RequestParam(name = "pageSize", defaultValue = "5", required = false) String pageSize) {

		if (msgFlag.equals("userDeleteOk")) {
			model.addAttribute("msg", "회원 자료가 삭제 되었습니다.");
			model.addAttribute("url", "/user/userList");
		} else if (msgFlag.equals("userDeleteNo")) {
			model.addAttribute("msg", "회원 자료가 삭제 실패");
			model.addAttribute("url", "/user/userList");
		} else if (msgFlag.equals("userInputOk")) {
			model.addAttribute("msg", "회원 자료가 등록되었습니다.");
			model.addAttribute("url", "/user/userList");
		} else if (msgFlag.equals("userInputNo")) {
			model.addAttribute("msg", "회원 자료 등록 실패");
			model.addAttribute("url", "/user/userList");
		} else if (msgFlag.equals("dbtestDeleteOk")) {
			model.addAttribute("msg", "회원 삭제 완료!");
			model.addAttribute("url", "/dbtest/dbtestList");
		} else if (msgFlag.equals("dbtestDeleteNo")) {
			model.addAttribute("msg", "회원 삭제 실패~~");
			model.addAttribute("url", "/dbtest/dbtestList");
		} else if (msgFlag.equals("dbtestInputOk")) {
			model.addAttribute("msg", "회원 가입 성공");
			model.addAttribute("url", "/dbtest/dbtestList");
		} else if (msgFlag.equals("dbtestInputNo")) {
			model.addAttribute("msg", "회원 가입 실패");
			model.addAttribute("url", "/dbtest/dbtestList");
		} else if (msgFlag.equals("dbtestUpdateOk")) {
			model.addAttribute("msg", "회원 정보 수정 성공");
			model.addAttribute("url", "/dbtest/dbtestList");
		} else if (msgFlag.equals("dbtestUpdateNo")) {
			model.addAttribute("msg", "회원 정보 수정 실패");
			model.addAttribute("url", "/dbtest/dbtestList");
		} else if (msgFlag.equals("dbtestWindowOk")) {
			model.addAttribute("msg", "사용할 수 있는 닉네임입니다.");
			model.addAttribute("url", "/dbtest/dbtestWindow");
		} else if (msgFlag.equals("dbtestWindowNo")) {
			model.addAttribute("msg", "사용할 수 없는 닉네임입니다. 다시 입력해주세요.");
			model.addAttribute("url", "/dbtest/dbtestWindow");
		} else if (msgFlag.equals("mailSendOk")) {
			model.addAttribute("msg", "메일 전송이 완료되었습니다.");
			model.addAttribute("url", "/study/mail/mailForm");
		} else if (msgFlag.equals("guestInputOk")) {
			model.addAttribute("msg", "방명록 등록이 완료되었습니다.");
			model.addAttribute("url", "/guest/guestList");
		} else if (msgFlag.equals("guestInputNo")) {
			model.addAttribute("msg", "방명록 등록이 실패하였습니다.");
			model.addAttribute("url", "/guest/guestInput");
		} else if (msgFlag.equals("idCheckNo")) {
			model.addAttribute("msg", "이미 사용 중인 아이디입니다.");
			model.addAttribute("url", "/member/memberJoin");
		} else if (msgFlag.equals("nickCheckNo")) {
			model.addAttribute("msg", "이미 사용 중인 닉네임입니다.");
			model.addAttribute("url", "/member/memberJoin");
		} else if (msgFlag.equals("memberJoinOk")) {
			model.addAttribute("msg", "회원 가입 완료");
			model.addAttribute("url", "/member/memberLogin");
		} else if (msgFlag.equals("memberJoinNo")) {
			model.addAttribute("msg", "회원 가입 실패");
			model.addAttribute("url", "/member/memberJoin");
		} else if (msgFlag.equals("memberLoginOk")) {
			model.addAttribute("msg", mid + "님 로그인 되었습니다.");
			model.addAttribute("url", "/member/memberMain");
		} else if (msgFlag.equals("memberLoginNo")) {
			model.addAttribute("msg", "로그인 실패");
			model.addAttribute("url", "/member/memberLogin");
		} else if (msgFlag.equals("memberLogout")) {
			model.addAttribute("msg", mid + "님 로그아웃 되었습니다.");
			model.addAttribute("url", "/member/memberLogin");
		} else if (msgFlag.equals("fileUploadOk")) {
			model.addAttribute("msg", "파일이 업로드되었습니다.");
			model.addAttribute("url", "/study/fileUpload/fileUpload");
		} else if (msgFlag.equals("fileUploadNo")) {
			model.addAttribute("msg", "파일이 업로드에 실패하였습니다.");
			model.addAttribute("url", "/study/fileUpload/fileUpload");
		} else if (msgFlag.equals("adminNo")) {
			model.addAttribute("msg", "관리자만 접속하실 수 있습니다.");
			model.addAttribute("url", "/");
		} else if (msgFlag.equals("memberNo")) {
			model.addAttribute("msg", "회원 로그인 후 사용하실 수 있습니다.");
			model.addAttribute("url", "/");
		} else if (msgFlag.equals("memberLevelNo")) {
			model.addAttribute("msg", "회원 등급을 확인하세요.");
			model.addAttribute("url", "/member/memberMain");
		} else if (msgFlag.equals("boardInputOk")) {
			model.addAttribute("msg", "게시판에 글이 등록되었습니다.");
			model.addAttribute("url", "/board/boardList");
		} else if (msgFlag.equals("boardInputNo")) {
			model.addAttribute("msg", "게시판에 글 등록이 실패하였습니다.");
			model.addAttribute("url", "/board/boardInput");
		} else if (msgFlag.equals("boardUpdateOk")) {
			model.addAttribute("msg", "게시글이 수정되었습니다.");
			model.addAttribute("url",
					"/board/boardContent?idx=" + idx + "&pag=" + pag + "&pageSize=" + pageSize);
		} else if (msgFlag.equals("boardUpdateNo")) {
			model.addAttribute("msg", "게시글이 수정에 실패하였습니다.");
			model.addAttribute("url",
					"/board/boardUpdate?idx=" + idx + "&pag=" + pag + "&pageSize=" + pageSize);
		} else if (msgFlag.equals("boardDeleteOk")) {
			model.addAttribute("msg", "게시글이 삭제되었습니다.");
			model.addAttribute("url", "/board/boardList");
		} else if (msgFlag.equals("boardDeleteNo")) {
			model.addAttribute("msg", "게시글 삭제 실패");
			model.addAttribute("url",
					"/board/boardContent?idx=" + idx + "&pag=" + pag + "&pageSize=" + pageSize);
		} 

		return "include/message";
	}
}
