package com.project.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.project.member.dao.MemberDAO;
import com.project.member.to.MemberTO;

@RestController
public class MemberController {
	
	@Autowired
	private MemberDAO dao;
	
	@RequestMapping(value = "login.do")
	public ModelAndView boardList(HttpServletRequest request, HttpServletResponse response) {
		 ModelAndView mav = new ModelAndView();
		 mav.setViewName("login");
		 return mav;
	}
	
	@RequestMapping(value = "login_ok.do")
	public ModelAndView login_ok(HttpServletRequest request, HttpServletResponse response) {
		 ModelAndView mav = new ModelAndView();
		 MemberTO to = new MemberTO();
		 HttpSession session = request.getSession();
		 to.setId(request.getParameter("id"));
		 to.setPassword(request.getParameter("password"));
		 to = dao.login_ok(to);
		 int flag = 1;
		 if(to != null) {
			 session.setAttribute("userSeq", to.getUserSeq());
			 session.setAttribute("id", to.getId());
			 session.setAttribute("password", to.getPassword());
			 session.setAttribute("userName", to.getUserName());
			 session.setAttribute("nickName", to.getNickName());
			 session.setAttribute("regDate", to.getRegDate());
			 flag = 0;
			 mav.addObject("flag", flag);
		 } else {
			 mav.addObject("flag", flag);
		 }
		 mav.setViewName("login_ok");
		 return mav;
	}
	
	@RequestMapping(value = "member/joinMember.do")
	public ModelAndView joinMember(HttpServletRequest request, HttpServletResponse response) {
		 ModelAndView mav = new ModelAndView();
		 mav.setViewName("joinMember");
		 return mav;
	}
	
	@RequestMapping(value = "member/joinMember_ok.do")
	public ModelAndView joinMember_ok(HttpServletRequest request, HttpServletResponse response) {
		 ModelAndView mav = new ModelAndView();
		 MemberTO to = new MemberTO();
		 to.setId(request.getParameter("id"));
		 to.setPassword(request.getParameter("password"));
		 to.setUserName(request.getParameter("userName"));
		 to.setNickName(request.getParameter("userNick"));
		 int flag = dao.joinMember_ok(to);
		 mav.addObject("flag", flag);
		 mav.setViewName("joinMember_ok");
		 return mav;
	}
}
