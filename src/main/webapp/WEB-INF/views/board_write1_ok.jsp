<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	int flag = (Integer)request.getAttribute("flag");

	out.println("<script type='text/javascript'>");
	if(flag == 0){
		out.println("alert('게시글이 작성되었습니다.');");
		out.println("location.href='/board/list.do';");
	} else {
		out.println("alert('작성을 실패했습니다. 다시 입력해 주십시오.');");
		out.println("history.back();");
	}
	out.println("</script>");
	
%>