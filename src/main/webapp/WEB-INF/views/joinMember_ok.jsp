<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	int flag = (Integer)request.getAttribute("flag");

	out.println("<script type='text/javascript'>");
	if(flag == 0){
		out.println("alert('환영합니다!!!');");
		out.println("location.href='/login.do';");
	} else {
		out.println("alert('다시 입력해주십시오.');");
		out.println("history.back();");
	}
	out.println("</script>");
	
%>