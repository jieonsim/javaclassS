package com.spring.javaclassS.pagination;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS.dao.BoardDAO;
import com.spring.javaclassS.dao.MemberDAO;
import com.spring.javaclassS.vo.PageVO;

@Service
public class PageProcess {
	@Autowired
	BoardDAO boardDAO;
	
	@Autowired
	MemberDAO memberDAO;

	// section : 게시판 종류 / part : 카테고리
	public PageVO totRecCnt(int pag, int pageSize, String section, String part, String searchString) {
		PageVO pageVO = new PageVO();
		
		int totRecCnt = 0;
		String search = "";
		
		if(section.equals("board")) {
			if(part.equals("")) {
				totRecCnt = boardDAO.totRecCnt();
			} else {
				search = part;
				totRecCnt = boardDAO.totRecCntSearch(search, searchString);
			}
		} 
//		else if (section.equals("pds")) {
//			totRecCnt = memberDAO.totRecCnt();
//		}
		
		int totPage = (totRecCnt % pageSize) == 0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;

		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setTotRecCnt(totRecCnt);
		pageVO.setTotPage(totPage);
		pageVO.setStartIndexNo(startIndexNo);
		pageVO.setCurScrStartNo(curScrStartNo);
		pageVO.setBlockSize(blockSize);
		pageVO.setCurBlock(curBlock);
		pageVO.setLastBlock(lastBlock);
		pageVO.setSearch(search);
		pageVO.setSearchString(searchString);
		pageVO.setPart(part);
		
		return pageVO;
	}
	
	
}
