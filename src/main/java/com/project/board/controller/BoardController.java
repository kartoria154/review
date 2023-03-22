package com.project.board.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.project.board.dao.BoardDAO;
import com.project.board.dao.CommentDAO;
import com.project.board.to.BoardTO;

@RestController
public class BoardController {

	@Autowired
	private BoardDAO dao;
	
	@Autowired
	private CommentDAO cmtDao;
	
	@RequestMapping(value = "board/list.do")
	public ModelAndView boardList(HttpServletRequest request, HttpServletResponse response) {
		 ModelAndView mav = new ModelAndView();
		 mav.setViewName("board_list1");
		 return mav;
	}
	
	@RequestMapping(value = "board/write.do")
	public ModelAndView boardWrite(HttpServletRequest request, HttpServletResponse response) {
		 ModelAndView mav = new ModelAndView();
		 int cpage = 1;
		 mav.setViewName("board_write1");
		 mav.addObject("cpage", cpage);
		 return mav;
	}
	
	@RequestMapping(value = "board/write_ok.do")
	public ModelAndView boardWrite_ok(HttpServletRequest request, HttpServletResponse response, @RequestParam("upload") MultipartFile upload) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		BoardTO to = new BoardTO();
		
		to.setUserSeq((int)session.getAttribute("userSeq"));
		to.setId((String)session.getAttribute("id"));
		to.setNickName((String)session.getAttribute("nickName"));
		to.setProductName(request.getParameter("productName"));
		to.setProductCategory(request.getParameter("productCategory"));
		to.setProductContent(request.getParameter("productContent"));
		
		if(!upload.isEmpty()) {
			try {
				String extention = upload.getOriginalFilename().substring(upload.getOriginalFilename().indexOf("."));
				to.setProductFileName(UUID.randomUUID().toString() + extention);
				upload.transferTo(new File(to.getProductFileName()));
			} catch (IllegalStateException e) {
				System.out.println("[IllegalState 에러]" + e.getMessage());
			} catch (IOException e) {
				System.out.println("[IO 에러]" + e.getMessage());
			}
		}
		int flag = dao.boardWrite_ok(to);
		mav.addObject("flag", flag);
		mav.setViewName("board_write1_ok");
		return mav;
	}
}
