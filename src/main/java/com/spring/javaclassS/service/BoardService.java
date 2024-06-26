package com.spring.javaclassS.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.javaclassS.vo.BoardReplyVO;
import com.spring.javaclassS.vo.BoardVO;

public interface BoardService {

	public ArrayList<BoardVO> getBoardList();

	public int setBoardInput(BoardVO vo);

	public BoardVO getBoardContent(int idx);

	public ArrayList<BoardVO> getBoardList(int startIndexNo, int pageSize);

	public void setReadNumPlus(int idx);

	public BoardVO getPreNexSearch(int idx, String str);

	public void imgCheck(String content);

	public void imgBackup(String content);

	public void imgDelete(String content);

	public int setBoardUpdate(BoardVO vo);

	public int setBoardDelete(int idx);

	public BoardReplyVO getBoardParentReplyCheck(int boardIdx);

	public int setBoardReplyInput(BoardReplyVO replyVO);

	public List<BoardReplyVO> getBoardReply(int idx);

	public void setReplyOrderUpdate(int boardIdx, int re_order);

	public List<BoardVO> getBoardSearchList(int startIndexNo, int pageSize, String search,
			String searchString);
}
