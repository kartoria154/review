package com.project.board.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
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
	@RequestMapping(value = "/board/list.do")
	public ModelAndView boardList(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		int cpage = 1;
		if(request.getParameter("cpage") != null && !request.getParameter("cpage").equals("")) {
			cpage = Integer.parseInt(request.getParameter("cpage"));
		}
		int searchData = 0;
		int listNum = 0;
		if(request.getParameter("listNum") != null && !request.getParameter("listNum").equals("")) {
			listNum =  Integer.parseInt(request.getParameter("listNum"));
		}
		if(listNum == 1) {
			searchData = 1;
		} else if(listNum == 2) {
			searchData = 2;
		}
		//System.out.println(cpage);
		BoardListTO listTO = new BoardListTO();
		BoardTO bTo = new BoardTO();
		listTO.setCpage(cpage);
		listTO = dao.boardList(listTO, bTo, searchData);
		mav.addObject("listTO", listTO);
		mav.setViewName("/board_list2");
		return mav;
	}
	
	/*
	
	// list 페이지의 게시물 정보를 부르는 메서드
	@RequestMapping(value = "/board/list.data")
	public ModelAndView boardListData(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		int cpage = 1;
		if(request.getParameter("cpage") != null && !request.getParameter("cpage").equals("")) {
			cpage = Integer.parseInt(request.getParameter("cpage"));
		}
		int searchData = 0;
		int listNum = 0;
		if(request.getParameter("listNum") != null && !request.getParameter("listNum").equals("")) {
			listNum =  Integer.parseInt(request.getParameter("listNum"));
		}
		if(listNum == 1) {
			searchData = 4;
		} else if(listNum == 2) {
			searchData = 5;
		}
		//System.out.println(cpage);
		BoardListTO listTO = new BoardListTO();
		BoardTO bTo = new BoardTO();
		listTO.setCpage(cpage);
		listTO = dao.boardList(listTO, bTo, searchData);
		mav.addObject("listTO", listTO);
		mav.setViewName("/ajaxPages/listData");
		return mav;
	}
	
	*/
	
	/*
	@RequestMapping(value = "/board/searchList.do")
	public ModelAndView searchListData(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		int cpage = 1;
		if(request.getParameter("cpage") != null && !request.getParameter("cpage").equals("")) {
			cpage = Integer.parseInt(request.getParameter("cpage"));
		}
		BoardListTO listTO = new BoardListTO();
		BoardTO bTo = new BoardTO();
		int searchData = 0;
		if(!request.getParameter("productCategory").equals("all")) {
			if(request.getParameter("productNameSearch") != null && !request.getParameter("productNameSearch").equals("")) {
				// 전체 카테고리가 아니고 검색어가 있을시
				searchData = 3;
				bTo.setProductCategory(request.getParameter("productCategory"));
				bTo.setProductName(request.getParameter("productNameSearch"));
			} else {
				// 전체 카테고리가 아니고 검색어가 없을시
				searchData = 2;
				bTo.setProductCategory(request.getParameter("productCategory"));
			}
		} else {
			if(!request.getParameter("productNameSearch").equals("") && request.getParameter("productNameSearch") != null) {
				// 전체 카테고리에서 검색어가 있을시
				searchData = 1;
				bTo.setProductName(request.getParameter("productNameSearch"));
			}
		}
		listTO.setCpage(cpage);
		listTO = dao.boardList(listTO, bTo, searchData);
		mav.addObject("listTO", listTO);
		mav.setViewName("/board_list2");
		return mav;
	}
	*/
	
	@RequestMapping(value = "/board/searchList.do")
	public ModelAndView searchListData(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		int cpage = 1;
		if(request.getParameter("cpage") != null && !request.getParameter("cpage").equals("")) {
			cpage = Integer.parseInt(request.getParameter("cpage"));
		}
		BoardListTO listTO = new BoardListTO();
		BoardTO bTo = new BoardTO();
		int searchData = 3;
		if(!request.getParameter("productCategory").equals("all") && request.getParameter("productCategory") != null && request.getParameter("productCategory").equals("")) {
			bTo.setProductCategory(request.getParameter("productCategory"));
		} else {
			bTo.setProductCategory("%%");
		}
		bTo.setProductName(request.getParameter("productNameSearch"));
		System.out.println(bTo.getProductCategory());
		System.out.println(bTo.getProductName());
		listTO.setCpage(cpage);
		listTO = dao.boardList(listTO, bTo, searchData);
		mav.addObject("listTO", listTO);
		mav.setViewName("/board_list2");
		return mav;
	}
	
	// 카테고리 메서드
	@RequestMapping(value = "/board/productCategory.data")
	public JSONArray productCategory(HttpServletRequest request, HttpServletResponse response) {
		ArrayList<String> Lists = dao.productCategory();
		JSONArray categoryList = new JSONArray();
		for(String str : Lists) {
			categoryList.add(str);
		}
		return categoryList;
	}
	
	// 카테고리 메서드
	@RequestMapping(value = "/board/searchListData.data")
	public JSONArray productSearchListData(HttpServletRequest request, HttpServletResponse response) {
		String searchCategory = "%%";
		if(request.getParameter("searchCategory") != null && !request.getParameter("searchCategory").equals("") && !request.getParameter("searchCategory").equals("all")) {
			searchCategory = "%" + request.getParameter("searchCategory") + "%";
		}
		ArrayList<String> Lists = dao.productSearchListData(searchCategory);
		JSONArray productListData = new JSONArray();
		for(String str : Lists) {
			productListData.add(str);
		}
		return productListData;
	}
	
	// write 페이지 호출 메서드
	@RequestMapping(value = "/board/write.do")
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
				// [0]: 사진파일명 [1]:사진 파일의 확장자 명
				String[] fileName = upload.getOriginalFilename().split(".");
									// 파일의 중복을 피하기 위해 UUID 사용
				to.setProductFileName(fileName[0] + UUID.randomUUID().toString() + "." + fileName);
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
			// 사진 파일을 업로드 했을 때 파일 업로드
			if(!upload.isEmpty()) {
				try {
					// [0]: 사진파일명 [1]:사진 파일의 확장자 명
					String[] fileName = upload.getOriginalFilename().split(".");
										// 파일의 중복을 피하기 위해 UUID 사용
					to.setProductFileName(fileName[0] + UUID.randomUUID().toString() + "." + fileName);
					// 파일 업로드
					upload.transferTo(new File(to.getProductFileName()));
				} catch (IllegalStateException e) {
					System.out.println("[IllegalState 에러]" + e.getMessage());
				} catch (IOException e) {
					System.out.println("[IO 에러]" + e.getMessage());
				}
			}
			flag = dao.boardModify_ok(to);
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
	
	// 댓글 목록을 부르기 위한 메서드
	@RequestMapping(value = "/board/cmt.data")
	public ModelAndView boardCmtData(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		CommentTO to = new CommentTO();
		HttpSession session = request.getSession();
		// 게시물의 번호로 DB에서 댓글 목록 가져옴
		to.setProductSeq(Integer.parseInt(request.getParameter("productSeq")));
		ArrayList<CommentTO> cmtList = cmtDao.commentList(to);
		int id_check = 0;
		if(cmtList.size() != 0) {
			// 대댓글을 표현하기 위한 변수
			int cmtMaxGrpl = cmtDao.cmtMaxGrpl(Integer.parseInt(request.getParameter("productSeq")));
			mav.addObject("cmtMaxGrpl", cmtMaxGrpl);
			for(int i = 0; i < cmtList.size(); i++ ) {
				if((int)session.getAttribute("userSeq") == cmtList.get(i).getUserSeq() && cmtList.get(i).getCmtGrpl() == 0) {
					id_check = 1;
				}
			}
		}
		mav.addObject("id_check", id_check);
		mav.addObject("cmtList", cmtList);
		mav.setViewName("/ajaxPages/cmtData");
		return mav;
	}
	
	@RequestMapping(value = "/board/cmtParentWrite_ok.do")
	public JSONObject boardCmtParentWrite_ok(HttpServletRequest request, HttpServletResponse response) {
		CommentTO to = new CommentTO();
		HttpSession session = request.getSession();
		to.setUserSeq((int)session.getAttribute("userSeq"));
		to.setId((String)session.getAttribute("id"));
		to.setNickName((String)session.getAttribute("nickName"));
		to.setCmtContent(request.getParameter("cmtContent"));
		to.setCmtGrade(Double.parseDouble(request.getParameter("cmtGrade")));
		to.setProductSeq(Integer.parseInt(request.getParameter("productSeq")));
		int flag = cmtDao.cmtParentWrite_ok(to);
		JSONObject result = new JSONObject();
		result.put("flag", flag);
		return result;
	}
	
	@RequestMapping(value = "/board/cmtReplyWrite_ok.do")
	public JSONObject boardCmtReplyWrite_ok(HttpServletRequest request, HttpServletResponse response) {
		CommentTO to = new CommentTO();
		HttpSession session = request.getSession();
		to.setUserSeq((int)session.getAttribute("userSeq"));
		to.setId((String)session.getAttribute("id"));
		to.setNickName((String)session.getAttribute("nickName"));
		to.setCmtContent(request.getParameter("cmtContent"));
		to.setProductSeq(Integer.parseInt(request.getParameter("productSeq")));
		int pSeq = Integer.parseInt(request.getParameter("pSeq"));
		int flag = cmtDao.cmtReplyWrite_ok(to, pSeq);
		JSONObject result = new JSONObject();
		result.put("flag", flag);
		return result;
	}
	
	@RequestMapping(value = "/board/cmtReplyModify_ok.do")
	public JSONObject boardCmtReplyModify_ok(HttpServletRequest request, HttpServletResponse response) {
		CommentTO to = new CommentTO();
		to.setCmtContent(request.getParameter("cmtContent"));
		to.setCmtSeq(Integer.parseInt(request.getParameter("cSeq")));
		
		int flag;
		//System.out.println(request.getParameter("cmtGrade") );
		if(request.getParameter("cmtGrade") != null) {
			to.setCmtGrade(Double.parseDouble(request.getParameter("cmtGrade")));
			int productSeq = Integer.parseInt(request.getParameter("productSeq"));
			flag = cmtDao.cmtParentModify_ok(to, productSeq);
		} else {
			flag = cmtDao.cmtReplyModify_ok(to);
		}
		JSONObject result = new JSONObject();
		result.put("flag", flag);
		return result;
	}
	
	@RequestMapping(value = "/board/cmtReplyDelete_ok.do")
	public JSONObject boardCmtReplyDelete_ok(HttpServletRequest request, HttpServletResponse response) {
		CommentTO to = new CommentTO();
		MemberTO memTO = new MemberTO();
		HttpSession session = request.getSession();
		memTO.setId((String)session.getAttribute("id"));
		memTO.setPassword(request.getParameter("password"));
		int memberCK = memDao.membar_check(memTO);
		int flag = 2;
		if(memberCK == 1) {
			to.setCmtSeq(Integer.parseInt(request.getParameter("cSeq")));
			int productSeq = Integer.parseInt(request.getParameter("productSeq"));
			flag = cmtDao.cmtReplyDelete_ok(to, productSeq);
		}
		JSONObject result = new JSONObject();
		result.put("flag", flag);
		return result;
	}
	
	
}
