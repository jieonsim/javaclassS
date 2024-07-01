package com.spring.javaclassS.common;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Calendar;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

@Service
public class JavaclassProvide {
	@Autowired
	JavaMailSender mailSender;
	
	// urlPath에 파일 저장하는 메소드. fName : 업로드 파일명 / sFileName : 디비에 저장될 이름 / urlPath : 저장
	// 경로
	public void writeFile(MultipartFile fName, String sFileName, String urlPath) throws IOException {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder
				.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext()
				.getRealPath("/resources/data/" + urlPath + "/");

		FileOutputStream fos = new FileOutputStream(realPath + sFileName);

		// fos.write(fName.getBytes());
		if (fName.getBytes().length != -1) {
			fos.write(fName.getBytes());
		}
		fos.flush();
		fos.close();
	}

	public void deleteFile(String photo, String urlPath) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder
				.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext()
				.getRealPath("/resources/data/" + urlPath + "/");

		File file = new File(realPath + photo);
		if (file.exists())
			file.delete();
	}

	// 파일 이름 변경하기 (중복 방지)
	public String saveFileName(String oFileName) {
		String fileName = "";

		// Calendar는 싱글톤 객체와 같이 때문에 객체를 생성하지 않는다.
		Calendar cal = Calendar.getInstance();
		fileName += cal.get(Calendar.YEAR);
		fileName += cal.get(Calendar.MONTH) + 1;
		fileName += cal.get(Calendar.DATE);
		fileName += cal.get(Calendar.HOUR_OF_DAY);
		fileName += cal.get(Calendar.MINUTE);
		fileName += cal.get(Calendar.SECOND);
		// fileName += cal.get(Calendar.MILLISECOND);
		fileName += "_" + oFileName;

		return fileName;
	}
	
	public String mailSend(String email, String title, String pwd) throws MessagingException {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder
				.currentRequestAttributes()).getRequest();
		String content = "";

		// 메일 전송을 위한 객체 : MimeMessage(), MimeMessageHelper()
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "utf-8");

		// 메일 보관함에 작성한 메세지들의 정보를 모두 저장시킨 후 작업 처리
		messageHelper.setTo(email); // 받는 사람 메일 주소
		messageHelper.setSubject(title); // 메일 제목
		messageHelper.setText(content); // 메일 내용

		// 메세지 보관함의 내용(content)에 발신자의 필요한 정보를 추가로 담아서 전송 처리한다.
		content = content.replace("\n", "<br>");
		content += "<br><hr><h3> 임시 비밀번호 : " + pwd + "</h3><hr>";
		content += "<img src='cid:loginImage' width='500px'>";
		content += "<p>방문하기 : <a href='http://49.142.157.251:9090/javaclassJ8/main'>javaclass</a></p>";
		content += "<hr>";
		messageHelper.setText(content, true);

		// inline 그림 보내기
		// request.getSession().getServletContext().getRealPath("/resources/images/login.jpg");
		// 본문에 기재될 그림파일의 경로를 별도로 표시시켜준다. 그런 후 다시 보관함에 저장한다.
		FileSystemResource inlineImage = new FileSystemResource(
				request.getSession().getServletContext().getRealPath("/resources/images/login.jpg"));
		messageHelper.addInline("loginImage", inlineImage);

		// 메일 전송하기
		mailSender.send(message);

		return "1";
	}
}
