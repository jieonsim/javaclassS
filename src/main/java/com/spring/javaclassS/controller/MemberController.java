package com.spring.javaclassS.controller;

import java.util.ArrayList;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS.service.MemberService;
import com.spring.javaclassS.vo.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	MemberService memberService;

	@Autowired
	BCryptPasswordEncoder passwordEncoder;

	@Autowired
	JavaMailSender mailSender;

	@RequestMapping(value = "/memberLogin", method = RequestMethod.GET)
	public String memberLoginGet(HttpServletRequest request) {
		// 로그인창에 아이디 체크 유무에 대한 처리
		// 쿠키를 검색해서 cMid가 있을때 가져와서 아이디입력 창에 뿌릴 수 있게 한다.

		Cookie[] cookies = request.getCookies();
		// request를 service객체에서 처리하는 건 불가하지만 controller에서는 가능
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				if (cookies[i].getName().equals("cMid")) {
					// pageContext.setAttribute("mid", cookies[i].getValue());
					// pageContext는 view에서 사용하는 것. model이나 request 등 저장소에 담으면됨,
					// 위에 request가 선언되어있으니 request에 담은 것
					request.setAttribute("mid", cookies[i].getValue());
					break;
				}
			}
		}
		return "member/memberLogin";
	}

	// Controller에서 초기값 정도는 처리하기, 그 외 비지니스로직은 서비스 객체에서 처리하기
	@RequestMapping(value = "/memberLogin", method = RequestMethod.POST)
	public String memberLoginPost(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			// name으로 받은 변수는 view에서 받은 거, 뒤에 변수는 controller에서 사용할 변수
			@RequestParam(name = "mid", defaultValue = "hkd1234", required = false) String mid, @RequestParam(name = "pwd", defaultValue = "1234", required = false) String pwd,
			@RequestParam(name = "idSave", defaultValue = "1234", required = false) String idSave) {

		// 로그인 인증처리(spring security의 BCryptPasswordEncoder 객체를 이용한 암호화된 비밀번호 비교하기)
		MemberVO vo = memberService.getMemberIdCheck(mid);

		if (vo != null && vo.getUserDel().equals("NO") && passwordEncoder.matches(pwd, vo.getPwd())) {
			// 로그인 인증 완료 시 처리할 부분(세션, 쿠키, 기타 설정값)
			// 1. 세션 처리
			String strLevel = "";
			if (vo.getLevel() == 0) {
				strLevel = "관리자";
			} else if (vo.getLevel() == 1) {
				strLevel = "우수회원";
			} else if (vo.getLevel() == 2) {
				strLevel = "정회원";
			} else if (vo.getLevel() == 3) {
				strLevel = "준회원";
			}

			session.setAttribute("sMid", mid);
			session.setAttribute("sNickName", vo.getNickName());
			session.setAttribute("sLevel", vo.getLevel());
			session.setAttribute("strLevel", strLevel);

			// 2. 쿠키 저장 / 삭제
			if (idSave.equals("on")) {
				// 읽을 때는 여러개 있을 수 있기 때문에 cookies로, 저장할 때는 하나씩 저장되기 때문에 cookie로 받음
				Cookie cookieMid = new Cookie("cMid", mid);
				// 루트부터 저장해서 루트부터 검색..
				cookieMid.setPath("/");
				// 쿠키 만료 시간을 7일로 지정
				cookieMid.setMaxAge(60 * 60 * 24 * 7);
				response.addCookie(cookieMid);
			} else {
				Cookie[] cookies = request.getCookies();
				if (cookies != null) {
					for (int i = 0; i < cookies.length; i++) {
						if (cookies[i].getName().equals("cMid")) {
							// 쿠키 삭제
							cookies[i].setMaxAge(0);
							response.addCookie(cookies[i]);
							break;
						}
					}
				}
			}

			// 3. 기타 처리 (DB에 처리해야할 것들(방문카운트, 포인트 등)
			// 숙제 방문포인트 : 1회 방문 시 point 10점 할당, 1일 최대 50점까지 할당 가능
			int point = 10;

			// 방문카운트
			memberService.setMemberInforUpdate(mid, point);
			return "redirect:/message/memberLoginOk?mid=" + mid;
		} else {
			return "redirect:/message/memberLoginNo";
		}
	}

	@RequestMapping(value = "/memberLogout", method = RequestMethod.GET)
	public String memberLogout(HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		session.invalidate();

		return "redirect:/message/memberLogout?mid=" + mid;
	}

	@RequestMapping(value = "/memberMain", method = RequestMethod.GET)
	public String memberMainGet(HttpSession session, Model model) {
		String mid = (String) session.getAttribute("sMid");
		MemberVO mVo = memberService.getMemberIdCheck(mid);

		model.addAttribute("mVo", mVo);
		return "member/memberMain";
	}

	@RequestMapping(value = "/memberJoin", method = RequestMethod.GET)
	public String memberJoinGet() {
		return "member/memberJoin";
	}

	@RequestMapping(value = "/memberJoin", method = RequestMethod.POST)
	public String memberJoinPost(MemberVO vo, MultipartFile fName) {
		// 아이디 / 닉네임 중복체크
		if (memberService.getMemberIdCheck(vo.getMid()) != null) {
			return "redirect:message/member/idCheckNo";
		}
		if (memberService.getMemberNickCheck(vo.getNickName()) != null) {
			return "redirect:message/member/nickCheckNo";
		}

		// 비밀번호 암호화
		// vo.getPwd로 유저가 입력한 비밀번호를 불러와 passwordEncoder.encode로 암호화처리하고 vo.setPwd로 암호화된
		// 비밀번호를 vo에 다시 저장
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));

		// 회원 사진 처리(service 객체에서 처리 후 DB에 저장한다.)
		if (fName != null && !fName.isEmpty()) {
			memberService.fileUpload(fName, vo); // fName과 함께 MemberVO를 전달
		} else {
			vo.setPhoto("noimage.jpg");
		}

		int res = memberService.setMemberJoinOk(vo);

		if (res != 0) {
			return "redirect:/message/memberJoinOk";
		} else {
			return "redirect:/message/memberJoinNo";
		}
	}

	@ResponseBody
	@RequestMapping(value = "/memberIdCheck", method = RequestMethod.GET)
	public String memberIdCheckGet(String mid) {
		MemberVO vo = memberService.getMemberIdCheck(mid);

		if (vo != null) {
			return "1";
		} else {
			return "0";
		}
	}

	@ResponseBody
	@RequestMapping(value = "/memberNickCheck", method = RequestMethod.GET)
	public String memberNickCheckGet(String nickName) {
		MemberVO vo = memberService.getMemberNickCheck(nickName);

		if (vo != null) {
			return "1";
		} else {
			return "0";
		}
	}

	@ResponseBody
	@RequestMapping(value = "/memberFindMid", method = RequestMethod.POST)
	public String memberFindMid(String name, String email) throws MessagingException {
		MemberVO vo = memberService.findMid(name, email);

		if (vo != null && vo.getEmail().equals(email)) {
			String mid = vo.getMid();

			// 찾은 아이디를 메일로 전송 처리한다.
			String title = "아이디 찾기로 찾으신 아이디 전달드립니다.";
			String mailFlag = "아이디 : " + mid;
			String res = mailSend(email, title, mailFlag);

			if (res == "1") {
				return "1";
			}
		}
		return "0";
	}

	@ResponseBody
	@RequestMapping(value = "/memberNewPassword", method = RequestMethod.POST)
	public String memberNewPasswordPost(String mid, String email, HttpSession session) throws MessagingException {
		MemberVO vo = memberService.getMemberIdCheck(mid);

		if (vo != null && vo.getEmail().equals(email)) {
			// 정보 확인 후 정보가 맞으면 임시 비밀번호를 발급 받아서 메일로 전송 처리한다.
			UUID uid = UUID.randomUUID();
			String pwd = uid.toString().substring(0, 8);

			// 새로 발급받은 비밀번호를 암호화 한 후 DB에 저장
			memberService.setMemberPasswordUpdate(mid, passwordEncoder.encode(pwd));

			// 발급 받은 비밀번호를 메일로 전송 처리한다.
			String title = "임시 비밀번호를 발급하였습니다.";
			String mailFlag = "임시 비밀번호 : " + pwd;
			String res = mailSend(email, title, mailFlag);

			// 새 비밀번호를 발급하였을 시에 sLogin이란 세션을 발생시키고,
			// 2분 안에 새 비밀번호로 로그인 후 비밀번호를 변경처리할 수 있도록 처리
			// 숙제
			session.setAttribute("sLogin", "OK");

			if (res == "1") {
				return "1";
			}
		}
		return "0";
	}

	// 메일 전송하기(아이디 찾기, 비밀번호 찾기)
	private String mailSend(String toMail, String title, String mailFlag) throws MessagingException {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String content = "";

		// 메일 전송을 위한 객체 : MimeMessage(), MimeMessageHelper()
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "utf-8");

		// 메일 보관함에 작성한 메세지들의 정보를 모두 저장시킨 후 작업 처리
		messageHelper.setTo(toMail); // 받는 사람 메일 주소
		messageHelper.setSubject(title); // 메일 제목
		messageHelper.setText(content); // 메일 내용

		// 메세지 보관함의 내용(content)에 발신자의 필요한 정보를 추가로 담아서 전송 처리한다.
		content = content.replace("\n", "<br>");
		content += "<br><hr><h3>" + mailFlag + "</h3><hr>";
		content += "<img src='cid:loginImage' width='500px'>";
		content += "<p>방문하기 : <a href='http://49.142.157.251:9090/javaclassJ8/main'>javaclass</a></p>";
		content += "<hr>";
		messageHelper.setText(content, true);

		// inline 그림 보내기
		// request.getSession().getServletContext().getRealPath("/resources/images/login.jpg");
		// 본문에 기재될 그림파일의 경로를 별도로 표시시켜준다. 그런 후 다시 보관함에 저장한다.
		FileSystemResource inlineImage = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/login.jpg"));
		messageHelper.addInline("loginImage", inlineImage);

		// 메일 전송하기
		mailSender.send(message);

		return "1";
	}

	@RequestMapping(value = "/memberPwdCheck/{pwdFlag}", method = RequestMethod.GET)
	public String memberPwdCheckGet(@PathVariable String pwdFlag, Model model) {
		model.addAttribute("pwdFlag", pwdFlag);
		return "member/memberPwdCheck";
	}

	@ResponseBody
	@RequestMapping(value = "/memberPwdCheck", method = RequestMethod.POST)
	public String memberPwdCheckPost(String mid, String pwd) {
		MemberVO vo = memberService.getMemberIdCheck(mid);

		if (passwordEncoder.matches(pwd, vo.getPwd()))
			return "1";
		return "0";
	}

	@ResponseBody
	@RequestMapping(value = "/memberPwdChangeOk", method = RequestMethod.POST)
	public String memberPwdChangeOkPost(String mid, String pwd) {
		return memberService.setPwdChangeOk(mid, passwordEncoder.encode(pwd)) + "";
	}

	@RequestMapping(value = "/memberList", method = RequestMethod.GET)
	public String memberListGet(Model model, HttpSession session) {
		int level = (Integer) session.getAttribute("sLevel");
		
		ArrayList<MemberVO> vos = memberService.getMemberList(level);
		model.addAttribute("vos", vos);
		return "member/memberList";
	}
	
}