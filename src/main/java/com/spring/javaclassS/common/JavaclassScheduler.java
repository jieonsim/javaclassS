package com.spring.javaclassS.common;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

/*
- cron 사용예
매달 10일 14시에 실행 : cron = "0 0 14 10 * ?"
매달 10일, 20일 14시에 실행 : cron = "0 0 14 10,20 * ?"
매달 마지막날 23시에 실행 : cron = "0 0 23 L * ?"
매일 9시00분~9시55분, 18시00분~18시55분에 5분 간격으로 실행
				cron = "0 0/5 9,18 * * *"
매일 9시00분 ~ 18시00분에 5분 간격으로 실행
				cron = "0 0/5 9-18 * * *"
매년 7월달내 월~금 10시30분에 실행  : 요일(월:1, 화:2, 수:3~~~)
        cron = "0 30 10 ? 7 1-5"
매달 마지막 토요일 10시30분에 실행
        cron = "0 30 10 ? * 6L"
*/

//@Component
public class JavaclassScheduler {

	@Autowired
	private JavaMailSender mailSender;

	// 정해진 시간에 자동으로 실행 (cron = 초 분 시 일 월 요일) 기본값으로 '*'을 입력시켜준다.
	//@Scheduled(cron = "0/10 * * * * *") // 10초에 한번씩 자동 실행
	public void scheduleRun1() {
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String strToday = sdf.format(today);
		System.out.println("10초에 한번씩 메시지가 출력됩니다." + strToday);
	}

	//@Scheduled(cron = "0 0/1 * * * *") // 1분에 한번씩 자동 실행
	public void scheduleRun2() {
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String strToday = sdf.format(today);
		System.out.println("1분에 한번씩 메시지가 출력됩니다." + strToday);
	}

	//@Scheduled(cron = "5 * * * * *") // 5초에 한번씩 자동 실행
	public void scheduleRun3() {
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String strToday = sdf.format(today);
		System.out.println("5초에 한번씩 메시지가 출력됩니다." + strToday);
	}

	//@Scheduled(cron = "0 14 10 * * *") // 매일 10시 14분에 한번씩 자동 실행
	public void scheduleRun4() {
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String strToday = sdf.format(today);
		System.out.println("매일 10시 14분에 한번씩 메시지가 출력됩니다." + strToday);
	}

	//@Scheduled(cron = "0 46 10 * * *") // 매일 10시 31분에 한번씩 자동 실행
	public void scheduleRun5() throws MessagingException {
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String strToday = sdf.format(today);
		System.out.println("매일 10시 46분에 메일을 전송합니다." + strToday);
		
		String email = "wldjs0721@naver.com";
		String title =  "신제품 안내 메일";
		String content = "여름 신상품 안내 메일입니다.";
		
		// 메일 전송을 위한 객체 : MimeMessage(), MimeMessageHelper()
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "utf-8");

		// 메일 보관함에 작성한 메세지들의 정보를 모두 저장시킨 후 작업 처리
		messageHelper.setTo(email); // 받는 사람 메일 주소
		messageHelper.setSubject(title); // 메일 제목
		messageHelper.setText(content); // 메일 내용

		// 메세지 보관함의 내용(content)에 발신자의 필요한 정보를 추가로 담아서 전송 처리한다.
		content = content.replace("\n", "<br>");
		content += "<br><hr><h3>신상품</h3><hr>";
		content += "<img src='cid:loginImage' width='500px'>";
		content += "<p>방문하기 : <a href='http://49.142.157.251:9090/javaclassJ8/main'>javaclass</a></p>";
		/*content += "<p><img src='http://49.142.157.251:9090/javaclassJ8/images/dummy/newjeans1.jpg' /></p>";*/
		content += "<hr>";
		messageHelper.setText(content, true);

		// inline 그림 보내기
		FileSystemResource inlineImage = new FileSystemResource("D:\\javaclass\\springframework\\works\\javaclassS\\src\\main\\webapp\\resources\\images\\login.jpg");
		messageHelper.addInline("loginImage", inlineImage);

		// 메일 전송하기
		mailSender.send(message);
	}
}
