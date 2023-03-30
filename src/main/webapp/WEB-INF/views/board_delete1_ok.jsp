<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	int flag = (Integer)request.getAttribute("flag");

	out.println("<script type='text/javascript'>");
	if(flag == 0){
		out.println("alert('게시글이 삭제 되었습니다.');");
		out.println("location.href='/board/list.do';");
	}  else if(flag == 1){
		out.println("alert('잘못 입력하셨습니다.');");
		out.println("history.back();");
	} else if(flag == 2){
		out.println("alert('잘못 입력하셨습니다.(db오류)');");
		out.println("history.back();");
	} else {
		out.println("alert('비밀번호가 다릅니다.');");
		out.println("history.back();");
	}
	out.println("</script>");
	
%>