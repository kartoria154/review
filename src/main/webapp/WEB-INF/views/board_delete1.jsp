<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.project.board.to.BoardTO" %>
<%
	// 로그인한 회원과 작성된 글의 회원번호가 같지 않을시 list로 돌아간다
	BoardTO to = (BoardTO)request.getAttribute("to");
	if(to.getUserSeq() != (int)session.getAttribute("userSeq")){
    	out.println("<script type='text/javascript'>");
    	out.println("alert('작성자가 일치하지 않습니다.');");
    	out.println("location.href='/board/list.do'");
    	out.println("</script>");
    } else {
    	int cpage = (int)request.getAttribute("cpage");
		String id = (String)session.getAttribute("id");
		String nickName = (String)session.getAttribute("nickName");
%>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0">
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<title>삭제창</title>
		<link rel="stylesheet" type="text/css" href="../../css/board_write.css">
		<script type="text/javascript">
			window.onload = function() {
				document.getElementById('dbtn').onclick = function() {
					//alert('click');
					if(document.dfrm.password.value.trim() == ''){
						alert('비밀번호 입력바람');
						return;
					}
					document.dfrm.submit();
				};
			};
		</script>
	</head>
	
	<body>
		<div class="contents1"> 
			<div class="con_title"> 
				<p style="margin: 0px; text-align: right">
					<img style="vertical-align: middle" alt="" src="../../images/home_icon.gif" /> &gt; 게시물 &gt; 목록 &gt; 상품 &gt; <strong>삭제</strong>
				</p>
			</div> 
		
			<form action="/board/delete_ok.do" method="post" name="dfrm">
				<input type="hidden" name="productSeq" value="${to.getProductSeq() }"/>
				<div class="contents_sub">
					<div class="board_write">
						<table>
						<tr>
							<th class="top">작성자(아이디)</th>
								<td class="top" colspan="3">${to.getNickName() }(${to.getId() })</td>
						</tr>
						<tr>
							<th>[분류]상품명</th>
							<td colspan="3">[${to.getProductCategory() }]${to.getProductName() }</td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td colspan="3"><input type="password" name="password" value="" class="board_view_input_mail"/></td>
						</tr>
						</table>
					</div>
		
					<div class="btn_area">
						<div class="align_left">			
							<input type="button" value="목록" class="btn_list btn_txt02" style="cursor: pointer;" onclick="location.href='/board/list.do?cpage=${cpage}'" />
							<input type="button" value="게시물보기" class="btn_list btn_txt02" style="cursor: pointer;" onclick="/board/view.do?cpage=${cpage}&productSeq=${to.getProductSeq() }'" />
						</div>
						<div class="align_right">			
							<input type="button" id="dbtn" value="삭제" class="btn_write btn_txt01" style="cursor: pointer;" />					
						</div>	
					</div>
				</div>
			</form>
		</div>
	</body>
</html>
<%
    }
%>

