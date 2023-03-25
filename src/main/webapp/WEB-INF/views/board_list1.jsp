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
		<!--
			.board_pagetab { text-align: center; }
			.board_pagetab a { text-decoration: none; font: 12px verdana; color: #000; padding: 0 3px 0 3px; }
			.board_pagetab a:hover { text-decoration: underline; background-color:#f2f2f2; }
			.on a { font-weight: bold; }
		-->
		</style>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script type="text/javascript">
			/* var cpage;
			if(${cpage} != null){
				cpage = ${cpage};
			} else {
				cpage = 1;
			}
			 */
			$( document ).ready( function() {
				listServer();
			});
			
			const listServer = function() {
				$.ajax({
					type: 'get',
					url: '/board/list.data',	 
					//data : {"cpage" : cpage},
					async:false,
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
					<img style="vertical-align: middle" alt="" src="../../images/home_icon.gif" /> &gt; 커뮤니티 &gt; <strong>여행지리뷰</strong>
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
			<div class="contents_sub" id="boardList">	
				<!-- <div class="board_top">
					<div class="bold">
						<p>총 <span class="txt_orange">1</span>건 <span style="float: right;"><input type="text" name="searck"/><input type="button" value="검색"/></span></p>
					</div>
				</div>
				
				<table class="board_list">
					<tr>
						<td width="20%" class="last2">
							<div class="board">
								<table class="boardT">
								<tr>
									<td class='boardThumbWrap'>
										<div class='boardThumb'>
											<a href="board_view1.jsp"><img src="../../upload/cancola.png" border="0" width="100%" /></a>
										</div>																		
									</td>
								</tr>
								<tr>
									<td>
										<div class='boardItem'>	
											<strong>제주 올레길 좋아...</strong>
											<img src="../../images/icon_new.gif" alt="NEW">
										</div>
									</td>
								</tr>
								<tr>
									<td><div class='boardItem'><span class="bold_blue">여행자</span></div></td>
								</tr>
								<tr>
									<td><div class='boardItem'>2016.03.02 <font>|</font> Hit 329</div></td>
								</tr>
								</table>
							</div>
						</td>
			
						<td width="20%" class="last2">
							<div class="board">
								<table class="boardT">
								<tr>
									<td class='boardThumbWrap'>
										<div class='boardThumb'>
											<a href="board_view1.jsp"><img src="../../upload/607927_1_thumb1.jpg" border="0" width="100%" /></a>
										</div>																		
									</td>
								</tr>
								<tr>
									<td>
										<div class='boardItem'>	
											<strong>제주 올레길 좋아...</strong>
											<img src="../../images/icon_new.gif" alt="NEW">
										</div>
									</td>
								</tr>
								<tr>
									<td><div class='boardItem'><span class="bold_blue">여행자</span></div></td>
								</tr>
								<tr>
									<td><div class='boardItem'>2016.03.02 <font>|</font> Hit 329</div></td>
								</tr>
								</table>
							</div>
						</td>
						<td width="20%" class="last2">
							<div class="board">
								<table class="boardT">
								<tr>
									<td class='boardThumbWrap'>
										<div class='boardThumb'>
											<a href="board_view1.jsp"><img src="../../upload/607927_1_thumb1.jpg" border="0" width="100%" /></a>
										</div>																		
									</td>
								</tr>
								<tr>
									<td>
										<div class='boardItem'>	
											<strong>제주 올레길 좋아...</strong>
											<img src="../../images/icon_new.gif" alt="NEW">
										</div>
									</td>
								</tr>
								<tr>
									<td><div class='boardItem'><span class="bold_blue">여행자</span></div></td>
								</tr>
								<tr>
									<td><div class='boardItem'>2016.03.02 <font>|</font> Hit 329</div></td>
								</tr>
								</table>
							</div>
						</td>
						<td width="20%" class="last2">
							<div class="board">
								<table class="boardT">
								<tr>
									<td class='boardThumbWrap'>
										<div class='boardThumb'>
											<a href="board_view1.jsp"><img src="../../upload/607927_1_thumb1.jpg" border="0" width="100%" /></a>
										</div>																		
									</td>
								</tr>
								<tr>
									<td>
										<div class='boardItem'>	
											<strong>제주 올레길 좋아...</strong>
											<img src="../../images/icon_new.gif" alt="NEW">
										</div>
									</td>
								</tr>
								<tr>
									<td><div class='boardItem'><span class="bold_blue">여행자</span></div></td>
								</tr>
								<tr>
									<td><div class='boardItem'>2016.03.02 <font>|</font> Hit 329</div></td>
								</tr>
								</table>
							</div>
						</td>
						<td width="20%" class="last2">
							<div class="board">
								<table class="boardT">
								<tr>
									<td class='boardThumbWrap'>
										<div class='boardThumb'>
											<a href="board_view1.jsp"><img src="../../upload/607927_1_thumb1.jpg" border="0" width="100%" /></a>
										</div>																		
									</td>
								</tr>
								<tr>
									<td>
										<div class='boardItem'>	
											<strong>제주 올레길 좋아...</strong>
											<img src="../../images/icon_new.gif" alt="NEW">
										</div>
									</td>
								</tr>
								<tr>
									<td><div class='boardItem'><span class="bold_blue">여행자</span></div></td>
								</tr>
								<tr>
									<td><div class='boardItem'>2016.03.02 <font>|</font> Hit 329</div></td>
								</tr>
								</table>
							</div>
						</td>
					</tr>
				</table>
				<div class="align_right">		
					<input type="button" value="쓰기" class="btn_write btn_txt01" style="cursor: pointer;" onclick="location.href='/board/write.do'" />
				</div>
				<div class="paginate_regular">
					<div class="board_pagetab">
						<span class="off"><a href="#">&lt;&lt;</a>&nbsp;&nbsp;</span>
						<span class="off"><a href="#">&lt;</a>&nbsp;&nbsp;</span>
						<span class="off"><a href="#">[ 1 ]</a></span>
						<span class="on"><a href="#">[ 2 ]</a></span>
						<span class="off"><a href="#">[ 3 ]</a></span>
						<span class="off">&nbsp;&nbsp;<a href="#">&gt;</a></span>
						<span class="off">&nbsp;&nbsp;<a href="#">&gt;&gt;</a></span>
					</div>
				</div> -->
		  	</div>
		  	
		</div>
	</body>
</html>
