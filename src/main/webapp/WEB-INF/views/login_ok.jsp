<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	int flag = (Integer)request.getAttribute("flag");

	out.println("<script type='text/javascript'>");
	if(flag == 0){
		out.println("alert('환영합니다!!!');");
		out.println("location.href='./board/list.do';");
	} else {
		out.println("alert('ID 또는 PW가 틀렸습니다. 다시 입력해 주십시오.');");
		out.println("history.back();");
	}
	out.println("</script>");
	
%>