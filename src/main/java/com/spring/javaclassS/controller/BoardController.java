package com.spring.javaclassS.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaclassS.pagination.PageProcess;
import com.spring.javaclassS.service.BoardService;
import com.spring.javaclassS.vo.BoardReplyVO;
import com.spring.javaclassS.vo.BoardVO;
import com.spring.javaclassS.vo.PageVO;
import com.spring.javaclassS.vo.ResponseVO;

@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	BoardService boardService;

	@Autowired
	PageProcess pageProcess;

	@RequestMapping(value = "/boardList", method = RequestMethod.GET)
	public String boardListGet(Model model,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
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
		// 1.만약 content에 이미지가 저장되어 있다면, 저장된 이미지만 골라서 board폴더에 따로
		// 보관시켜준다.('/data/ckeditor'폴더에서 '/data/board'폴더로 복사처리)
		if (vo.getContent().indexOf("src=\"/") != -1) {
			boardService.imgCheck(vo.getContent());
		}

		// 2.이미지 작업(복사작업)을 모두 마치면, ckeditor폴더경로를 board폴더 경로로 변경처리한다.
		vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/board/"));

		// 3.content안의 그림에 대한 정리와 내용정리가 끝나면 변경된 내용을 vo에 담은후 DB에 저장한다.
		int res = boardService.setBoardInput(vo);

		if (res != 0) {
			return "redirect:/message/boardInputOk";
		}
		return "redirect:/message/boardInputNo";
	}

	@RequestMapping(value = "/boardContent", method = RequestMethod.GET)
	public String boardContentGet(int idx, Model model, HttpServletRequest request,
			@RequestParam(name = "search", defaultValue = "", required = false) String search,
			@RequestParam(name = "searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name = "flag", defaultValue = "", required = false) String flag,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "10", required = false) int pageSize) {

		// 조회수 증가하기 (중복허용)
		// boardService.setReadNumPlus(idx);

		// 조회수 증가하기 (중복방지)
		HttpSession session = request.getSession();
		@SuppressWarnings("unchecked")
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
		model.addAttribute("flag", flag);
		model.addAttribute("search", search);
		model.addAttribute("searchString", searchString);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);

		// 이전글 다음글 가져오기
		BoardVO preVo = boardService.getPreNexSearch(idx, "preVo");
		BoardVO nextVo = boardService.getPreNexSearch(idx, "nextVo");
		model.addAttribute("preVo", preVo);
		model.addAttribute("nextVo", nextVo);

		// 댓글(대댓글) 가져오기
		List<BoardReplyVO> replyVos = boardService.getBoardReply(idx);
		model.addAttribute("replyVos", replyVos);

		return "board/boardContent";
	}

	@RequestMapping(value = "/boardUpdate", method = RequestMethod.GET)
	public String boardUpdateGet(int idx, Model model,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "10", required = false) int pageSize) {
		// 수정 화면으로 이동할 시에는 기존 원본 파일의 그림파일이 존재한다면 현재 폴더(board)의 그림파일을 ckeditor 폴더로 복사

		BoardVO vo = boardService.getBoardContent(idx);

		if (vo.getContent().indexOf("src=\"/") != -1) {
			boardService.imgBackup(vo.getContent());
		}

		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		return "board/boardUpdate";
	}

//	@RequestMapping(value = "/boardUpdate", method = RequestMethod.POST)
//	public String boardUpdatePost(BoardVO vo, Model model,
//			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
//			@RequestParam(name = "pageSize", defaultValue = "10", required = false) int pageSize) {
//		// 수정된 자료가 원본 자료와 완전히 동일하다면 수정할 필요가 없다. 즉 DB에 저장된 원본자료를 불러와서 현재 vo에 담긴
//		// 내용(content)과
//
//		BoardVO origVo = boardService.getBoardContent(vo.getIdx());
//
//		// content의 내용이 조금이라도 변경되었다면 내용을 수정한 것이기에 그림 파일 처리 유무를 결정한다.
//		if (!origVo.getContent().equals(vo.getContent())) {
//			// 1. 기존 board 폴더에 그림이 존재했다면 원본 그림을 모두 삭제 처리한다.
//			// (원본 그림은 수정 창에 들어오기 전에 ckeditor 폴더에 저장시켜두었다.)
//			if (origVo.getContent().indexOf("src=\"/") != -1) {
//				boardService.imgDelete(origVo.getContent());
//			}
//
//			// 2. 앞 삭제 작업이 끝나면 'board'폴더를 'ckeditor'로 경로 변경한다.
//			vo.setContent(vo.getContent().replace("/data/board/", "/data/ckeditor/"));
//
//			// 1,2 작업을 마치면 파일을 처음 업로드한 것과 같은 작업 처리를 해준다.
//			// 즉 content에 이미지가 저장되어있다면 저장된 이미지만 골라서 '/data/board/폴더에 복사 저장처리한다.'
//			if (origVo.getContent().indexOf("src=\"/") != -1) {
//				boardService.imgCheck(vo.getContent());
//			}
//
//			// 이미지들의 모든 복사 작업을 마치면 폴더명을 'ckeditor'에서 'board'폴더로 변경처리한다.
//			vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/board/"));
//		}
//		// content안의 내용과 그림 파일까지 잘 정비된 vo를 db에 update를 시켜준다.
//		int res = boardService.setBoardUpdate(vo);
//
//		model.addAttribute("idx", vo.getIdx());
//		model.addAttribute("pag", pageSize);
//		model.addAttribute("pageSize", pageSize);
//
//		if (res != 0) {
//			return "redirect:/message/boardUpdateOk";
//		} else {
//			return "redirect:/message/boardUpdateNo";
//		}
//	}

	@RequestMapping(value = "/boardUpdate", method = RequestMethod.POST)
	@ResponseBody
	public ResponseVO boardUpdatePost(BoardVO vo, Model model,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "10", required = false) int pageSize) {
		ResponseVO response = new ResponseVO();

		BoardVO origVo = boardService.getBoardContent(vo.getIdx());

		if (!origVo.getContent().equals(vo.getContent())) {
			if (origVo.getContent().indexOf("src=\"/") != -1) {
				boardService.imgDelete(origVo.getContent());
			}

			vo.setContent(vo.getContent().replace("/data/board/", "/data/ckeditor/"));

			if (vo.getContent().indexOf("src=\"/") != -1) {
				boardService.imgCheck(vo.getContent());
			}

			vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/board/"));
		}

		int res = boardService.setBoardUpdate(vo);

		if (res != 0) {
			response.setMsg("게시글이 수정되었습니다.");
			response.setUrl(
					"/board/boardContent?idx=" + vo.getIdx() + "&pag=" + pag + "&pageSize=" + pageSize);
		} else {
			response.setMsg("게시글이 수정에 실패하였습니다.");
			response.setUrl(
					"/board/boardUpdate?idx=" + vo.getIdx() + "&pag=" + pag + "&pageSize=" + pageSize);
		}

		return response;
	}

//	@RequestMapping(value = "/boardDelete", method = RequestMethod.GET)
//	public String boardDeleteGet(int idx,
//			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
//			@RequestParam(name = "pageSize", defaultValue = "10", required = false) int pageSize) {
//		// 게시글에 사진이 존재한다면 서버에 저장된 사진을 삭제처리한다.
//		BoardVO vo = boardService.getBoardContent(idx);
//		if (vo.getContent().indexOf("src=\"/") != -1) {
//			boardService.imgDelete(vo.getContent());
//		}
//
//		// 사진 작업이 끝나면 DB에 저장된 실제 정보 레코드를 삭제처리한다.
//		int res = boardService.setBoardDelete(idx);
//
//		if (res != 0) {
//			return "redirect:/message/boardDeleteOk";
//		} else {
//			return "redirect:/message/boardDeleteNo?idx=" + idx + "&pag=" + pag + "&pageSize=" + pageSize;
//		}
//	}
//    @RequestMapping(value = "/boardDelete", method = RequestMethod.GET)
//    @ResponseBody
//    public Map<String, String> boardDeleteGet(int idx,
//                                              @RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
//                                              @RequestParam(name = "pageSize", defaultValue = "10", required = false) int pageSize) {
//        Map<String, String> result = new HashMap<>();
//        
//        BoardVO vo = boardService.getBoardContent(idx);
//        if (vo.getContent().indexOf("src=\"/") != -1) {
//            boardService.imgDelete(vo.getContent());
//        }
//
//        int res = boardService.setBoardDelete(idx);
//
//        if (res != 0) {
//            result.put("msg", "게시글이 삭제되었습니다.");
//            result.put("url", "/board/boardList");
//        } else {
//            result.put("msg", "게시글 삭제 실패");
//            result.put("url", "/board/boardContent?idx=" + idx + "&pag=" + pag + "&pageSize=" + pageSize);
//        }
//
//        return result;
//    }
	@RequestMapping(value = "/boardDelete", method = RequestMethod.GET)
	@ResponseBody
	public ResponseVO boardDeleteGet(int idx,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "10", required = false) int pageSize) {
		ResponseVO response = new ResponseVO();

		// 실제 삭제 로직
		int res = boardService.setBoardDelete(idx);

		if (res != 0) {
			response.setMsg("게시글이 삭제되었습니다.");
			response.setUrl("/board/boardList");
		} else {
			response.setMsg("게시글 삭제 실패");
			response.setUrl("/board/boardContent?idx=" + idx + "&pag=" + pag + "&pageSize=" + pageSize);
		}

		return response;
	}

	// 부모 댓글 입력 처리(원본 글에 대한 댓글)
	@ResponseBody
	@RequestMapping(value = "/boardReplyInput", method = RequestMethod.POST)
	public String boardReplyInputPost(BoardReplyVO replyVO) {
		// 부모 댓글의 경우는 re_step = 0, re_order = 1로 처리
		// (단, 원본글의 첫번째 부모댓글은 re_order=1이지만,
		// 2번 이상은 마지막 부모 댓글의 re_order보다 +1 처리 시켜준다.)
		BoardReplyVO replyParentVO = boardService.getBoardParentReplyCheck(replyVO.getBoardIdx());

		if (replyParentVO == null) {
			replyVO.setRe_order(1);
		} else {
			replyVO.setRe_order(replyParentVO.getRe_order() + 1);
		}

		replyVO.setRe_step(0);
		int res = boardService.setBoardReplyInput(replyVO);

		return res + "";
	}

	// 대댓글 입력처리(부모댓글에 대한 댓글)
	@ResponseBody
	@RequestMapping(value = "/boardReplyInputRe", method = RequestMethod.POST)
	public String boardReplyInputRePost(BoardReplyVO replyVO) {
		// 대댓글(답변글)의 1.re_step은 부모댓글의 re_step+1,
		// 2.re_order는 부모의 re_order보다 큰 댓글은 모두 +1처리후, 3.자신의 re_order+1시켜준다.

		replyVO.setRe_step(replyVO.getRe_step() + 1); // 1번처리

		boardService.setReplyOrderUpdate(replyVO.getBoardIdx(), replyVO.getRe_order()); // 2번 처리

		replyVO.setRe_order(replyVO.getRe_order() + 1);

		int res = boardService.setBoardReplyInput(replyVO);

		return res + "";
	}

	// boardlist 페이지 내 검색기
	/* @RequestMapping(value = "/boardSearch", method = RequestMethod.POST) */
	// @RequestMapping(value = "/boardSearch", method = { RequestMethod.GET, RequestMethod.POST })
	@RequestMapping(value = "/boardSearch")
	public String boardSearchPost(Model model, String search,
			@RequestParam(name = "searchString", defaultValue = "", required = false) String searchString,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "10", required = false) int pageSize) {

		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "board", search, searchString);

		List<BoardVO> vos = boardService.getBoardSearchList(pageVO.getStartIndexNo(), pageSize, search,
				searchString);

		String searchTitle = "";
		if (pageVO.getSearch().equals("title")) {
			searchTitle = "글제목";
		} else if (pageVO.getSearch().equals("nickName")) {
			searchTitle = "글쓴이";
		} else {
			searchTitle = "글내용";
		}

		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("searchTitle", searchTitle);
		model.addAttribute("search", search);
		model.addAttribute("searchString", searchString);
		model.addAttribute("searchCount", vos.size());

		return "board/boardSearchList";
	}

}
