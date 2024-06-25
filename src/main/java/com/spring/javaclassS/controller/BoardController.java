package com.spring.javaclassS.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javaclassS.pagination.PageProcess;
import com.spring.javaclassS.service.BoardService;
import com.spring.javaclassS.vo.BoardVO;
import com.spring.javaclassS.vo.PageVO;

@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	BoardService boardService;

	@Autowired
	PageProcess pageProcess;

	@RequestMapping(value = "/boardList", method = RequestMethod.GET)
	public String boardListGet(Model model, @RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "10", required = false) int pageSize) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "board", "", "");

		ArrayList<BoardVO> vos = boardService.getBoardList(pageVO.getStartIndexNo(), pageSize);

		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);

		return "board/boardList";
	}

	@RequestMapping(value = "/boardInput", method = RequestMethod.GET)
	public String boardInputGet() {
		return "board/boardInput";
	}

	@RequestMapping(value = "/boardInput", method = RequestMethod.POST)
	public String boardInputPost(BoardVO vo) {

		int res = boardService.setBoardInput(vo);

		if (res != 0) {
			return "redirect:/message/boardInputOk";
		}
		return "redirect:/message/boardInputNo";
	}

	@RequestMapping(value = "/boardContent", method = RequestMethod.GET)
	public String boardContentGet(int idx, Model model, HttpServletRequest request, @RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "10", required = false) int pageSize) {

		// 조회수 증가하기 (중복허용)
		// boardService.setReadNumPlus(idx);

		// 조회수 증가하기 (중복방지)
		HttpSession session = request.getSession();
		ArrayList<String> contentReadNum = (ArrayList<String>) session.getAttribute("sContentIdx");
		if (contentReadNum == null)
			contentReadNum = new ArrayList<String>();
		String imsiContentReadNum = "board" + idx;
		if (!contentReadNum.contains(imsiContentReadNum)) {
			boardService.setReadNumPlus(idx);
			contentReadNum.add(imsiContentReadNum);
		}
		session.setAttribute("sContentIdx", contentReadNum);

		BoardVO vo = boardService.getBoardContent(idx);
		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);

		// 이전글 다음글 가져오기
		BoardVO preVo = boardService.getPreNexSearch(idx, "preVo");
		BoardVO nextVo = boardService.getPreNexSearch(idx, "nextVo");
		model.addAttribute("preVo", preVo);
		model.addAttribute("nextVo", nextVo);

		return "board/boardContent";
	}
}
