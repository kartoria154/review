package com.project.board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.project.board.dao.BoardDAO;
import com.project.board.dao.CommentDAO;

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
}
