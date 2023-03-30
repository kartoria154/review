package com.project.board.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
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
import com.project.board.to.BoardListTO;
import com.project.board.to.BoardTO;
import com.project.board.to.CommentTO;
import com.project.member.dao.MemberDAO;
import com.project.member.to.MemberTO;

@RestController
public class BoardController {

	@Autowired
	private BoardDAO dao;
	
	@Autowired
	private CommentDAO cmtDao;
	
	@Autowired
	private MemberDAO memDao;
	
	// list 페이지 호출 메서드
	@RequestMapping(value = "board/list.do")
	public ModelAndView boardList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("board_list1");
		return mav;
	}
	
	// list 페이지의 게시물 정보를 부르는 메서드
	@RequestMapping(value = "/board/list.data")
	public ModelAndView boardListData(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		int cpage = 1;
		if(request.getParameter("cpage") != null && !request.getParameter("cpage").equals("")) {
			cpage = Integer.parseInt(request.getParameter("cpage"));
		}
		
		BoardListTO listTO = new BoardListTO();
		listTO.setCpage(cpage);
		listTO = dao.boardList(listTO);
		mav.addObject("listTO", listTO);
		mav.setViewName("/ajaxPages/listData");
		return mav;
	}
	
	// write 페이지 호출 메서드
	@RequestMapping(value = "board/write.do")
	public ModelAndView boardWrite(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("board_write1");
		mav.addObject("cpage", Integer.parseInt(request.getParameter("cpage")));
		return mav;
	}
	
	// 작성한 내용을 저장하기 위한 메서드
	@RequestMapping(value = "board/write_ok.do")
	public ModelAndView boardWrite_ok(HttpServletRequest request, HttpServletResponse response, @RequestParam("upload") MultipartFile upload) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		BoardTO to = new BoardTO();
					// 로그인 때 저장한 session값을 호출
		to.setUserSeq((int)session.getAttribute("userSeq"));
		to.setId((String)session.getAttribute("id"));
		to.setNickName((String)session.getAttribute("nickName"));
		to.setProductName(request.getParameter("productName"));
		to.setProductCategory(request.getParameter("productCategory"));
		to.setProductContent(request.getParameter("productContent"));
		// 사진 파일이 존재하면 사진을 지정 경로에 업로드하고 사진명을 db에 저장 
		if(!upload.isEmpty()) {
			try {
				// 사진 파일의 확장자 명
				String extention = upload.getOriginalFilename().substring(upload.getOriginalFilename().indexOf("."));
									// 파일의 중복을 피하기 위해 UUID 사용
				to.setProductFileName(UUID.randomUUID().toString() + extention);
				// 파일 업로드
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

	@RequestMapping(value = "board/view.do")
	public ModelAndView boardView(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		BoardTO to = new BoardTO();
		to.setProductSeq(Integer.parseInt(request.getParameter("productSeq")));
		to = dao.boardView(to);
		
		mav.addObject("to", to);
		mav.addObject("cpage", request.getParameter("cpage"));
		mav.setViewName("board_view1");
		return mav;
	}
	
	// list 페이지의 게시물 정보를 부르는 메서드
	@RequestMapping(value = "/board/cmt.data")
	public ModelAndView boardCmtData(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		CommentTO to = new CommentTO();
		to.setProductSeq(Integer.parseInt(request.getParameter("productSeq")));
		ArrayList<CommentTO> cmtList = cmtDao.commentList(to);
		if(cmtList.size() != 0) {
			int cmtMaxGrpl = cmtDao.cmtMaxGrpl(Integer.parseInt(request.getParameter("productSeq")));
			mav.addObject("cmtMaxGrpl", cmtMaxGrpl);
		}
		mav.addObject("cmtList", cmtList);
		mav.setViewName("/ajaxPages/cmtData");
		return mav;
	}
	
	@RequestMapping(value = "/board/modify.do")
	public ModelAndView boardModify(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		BoardTO to = new BoardTO();
		to.setProductSeq(Integer.parseInt(request.getParameter("productSeq")));
		to = dao.boardModify(to);
		mav.addObject("to", to);
		mav.addObject("cpage", Integer.parseInt(request.getParameter("cpage")));
		mav.setViewName("board_modify1");
		return mav;
	}
	
	@RequestMapping(value = "/board/modify_ok.do")
	public ModelAndView boardModify_ok(HttpServletRequest request, HttpServletResponse response, @RequestParam("upload") MultipartFile upload) {
		ModelAndView mav = new ModelAndView();
		BoardTO to = new BoardTO();
		MemberTO memTO = new MemberTO();
		HttpSession session = request.getSession();
		memTO.setId((String)session.getAttribute("id"));
		memTO.setPassword(request.getParameter("password"));
		int memberCK = memDao.membar_check(memTO);
		int flag = 3;
		if(memberCK == 1) {
			to.setProductSeq(Integer.parseInt(request.getParameter("productSeq")));
			to.setProductName(request.getParameter("productName"));
			to.setProductCategory(request.getParameter("productCategory"));
			to.setProductContent(request.getParameter("productContent"));
			if(!upload.isEmpty()) {
				try {
					// 사진 파일의 확장자 명
					String extention = upload.getOriginalFilename().substring(upload.getOriginalFilename().indexOf("."));
										// 파일의 중복을 피하기 위해 UUID 사용
					to.setProductFileName(UUID.randomUUID().toString() + extention);
					// 파일 업로드
					upload.transferTo(new File(to.getProductFileName()));
				} catch (IllegalStateException e) {
					System.out.println("[IllegalState 에러]" + e.getMessage());
				} catch (IOException e) {
					System.out.println("[IO 에러]" + e.getMessage());
				}
			}
			flag = dao.boardModify_ok(to);
		} else if(memberCK == 0) {
			flag = 3;
		}
		mav.addObject("flag", flag);
		mav.addObject("cpage", request.getParameter("cpage"));
		mav.addObject("productSeq", request.getParameter("productSeq"));
		mav.setViewName("board_modify1_ok");
		
		return mav;
	}
	
	@RequestMapping(value = "/board/delete.do")
	public ModelAndView boardDelete(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		BoardTO to = new BoardTO();
		to.setProductSeq(Integer.parseInt(request.getParameter("productSeq")));
		to = dao.boardModify(to);
		mav.addObject("to", to);
		mav.addObject("cpage", Integer.parseInt(request.getParameter("cpage")));
		mav.setViewName("board_delete1");
		return mav;
	}
	
	@RequestMapping(value = "/board/delete_ok.do")
	public ModelAndView boardDelete_ok(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		BoardTO to = new BoardTO();
		MemberTO memTO = new MemberTO();
		HttpSession session = request.getSession();
		memTO.setId((String)session.getAttribute("id"));
		memTO.setPassword(request.getParameter("password"));
		int memberCK = memDao.membar_check(memTO);
		int flag = 3;
		if(memberCK == 1) {
			to.setProductSeq(Integer.parseInt(request.getParameter("productSeq")));
			flag = dao.boardDelete_ok(to);
		} else if(memberCK == 0) {
			flag = 3;
		}
		mav.addObject("flag", flag);
		mav.setViewName("board_delete1_ok");
		return mav;
	}
}
