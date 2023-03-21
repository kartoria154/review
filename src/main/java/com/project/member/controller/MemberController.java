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
	
	//로그인 창으로 이동
	@RequestMapping(value = "login.do")
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response) {
		 ModelAndView mav = new ModelAndView();
		 mav.setViewName("login");
		 return mav;
	}
	
	//로그인 창에서 입력 받은 데이터 DAO로 주고 받은 값이 있으면 session에 저장
	@RequestMapping(value = "login_ok.do")
	public ModelAndView login_ok(HttpServletRequest request, HttpServletResponse response) {
		 ModelAndView mav = new ModelAndView();
		 MemberTO to = new MemberTO();
		 HttpSession session = request.getSession();
		 to.setId(request.getParameter("id"));
		 to.setPassword(request.getParameter("password"));
		 to = dao.login_ok(to);	// db에 데이터가 없으면 to는 null로 넘어옴
		 int flag = 1;			// 1이면 로그인 실패, 0이면 로그인 성공
		 if(to != null) {		// db에 테이터가 있으면 존재하는 데이터를 session에 저장
			 session.setAttribute("userSeq", to.getUserSeq());
			 session.setAttribute("id", to.getId());
			 session.setAttribute("password", to.getPassword());
			 session.setAttribute("userName", to.getUserName());
			 session.setAttribute("nickName", to.getNickName());
			 session.setAttribute("regDate", to.getRegDate());
			 flag = 0;
			 mav.addObject("flag", flag);
		 } else {				// db에 데이터가 없으면 flag만 반영
			 mav.addObject("flag", flag);
		 }
		 mav.setViewName("login_ok");
		 return mav;
	}
	
	// 회원가입 페이지로 이동
	@RequestMapping(value = "member/joinMember.do")
	public ModelAndView joinMember(HttpServletRequest request, HttpServletResponse response) {
		 ModelAndView mav = new ModelAndView();
		 mav.setViewName("joinMember");
		 return mav;
	}

	// id 중복 검사
	@RequestMapping(value ="member/id_check.do")
	public int id_check(HttpServletRequest request, HttpServletResponse response) {
		MemberTO to = new MemberTO();
		to.setId(request.getParameter("id"));
		//System.out.println(request.getParameter("id"));
		int flag = dao.id_check(to);
		return flag;
	}	
		
	// 회원가입 실행 controller
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
	
	@RequestMapping(value = "logout_ok.do")
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) {
		 ModelAndView mav = new ModelAndView();
		 mav.setViewName("logout_ok");
		 return mav;
	}
	
	
}
