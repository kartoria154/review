<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0">
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<title>Insert title here</title>
		<link rel="stylesheet" type="text/css" href="../../css/board_list.css">
		<style type="text/css">
			.board_pagetab { text-align: center; }
			.board_pagetab a { text-decoration: none; font: 12px verdana; color: #000; padding: 0 3px 0 3px; }
			.board_pagetab a:hover { text-decoration: underline; background-color:#f2f2f2; }
			.on a { font-weight: bold; }
		</style>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script type="text/javascript">
			$( document ).ready( function() {
				listServer();
			});
			// listData 호출
			const listServer = function() {
				$.ajax({
					type: 'get',
					url: '/board/list.data',	 
					//async:false,
					dataType: 'html',
					success: function(htmlData) {
						$("#boardList").html(htmlData);
					},
					error: function(err) {
						alert('에러' + err.status);
					}
				});
			}
		</script>
	</head>
	
	<body>
		<div class="contents1"> 
			<div class="con_title"> 
				<span style="margin: 0px; text-align: left">
					<img style="vertical-align: middle" alt="" src="../../images/home_icon.gif" /> &gt; 게시물 &gt; <strong>목록</strong>
				</span>
				<span style="float: right;">
					<c:choose>
						<c:when test="${sessionScope.userSeq != null }">
							<input type="button" value="로그아웃" class="btn_write btn_txt01" style="cursor: pointer;" onclick="location.href='/logout_ok.do'" />
						</c:when>
						<c:otherwise>
							<input type="button" value="로그인" class="btn_write btn_txt01" style="cursor: pointer;" onclick="location.href='/login.do'" />
						</c:otherwise>
					</c:choose>
				</span>
			</div> 
			<!-- listData의 내용을 출력  -->
			<div class="contents_sub" id="boardList">
		  	</div>
		  	
		</div>
	</body>
</html>
