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
		<title>수정창</title>
		<link rel="stylesheet" type="text/css" href="../../css/board_write.css">
		<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
		<script type="text/javascript">
			window.onload = function() {
				document.getElementById('mbtn').onclick = function() {
					//alert('click');
					if(document.mfrm.password.value.trim() == ''){
						alert('비밀번호 입력바람');
						return;
					} else if(document.mfrm.productCategory.value.trim() == ''){
						alert('카테고리를 지정하십시오');
						return;
					}
					document.mfrm.submit();
				};
			};
			
			$( document ).ready( function() {
				productCategory();
				
			});	
			var productCategory = function(){
				$.ajax({
					type: 'get',
					url: '/board/productCategory.data',
					async:false,
					dataType: 'json',
					success: function(data){
						//console.log(data[1]);
						let categoryHtml = '';
						for(let i = 0; i < data.length; i++){
							categoryHtml += '<option value="'+data[i]+'">'+data[i]+'</option>';
						};
						$("#productCategorySearch").append(categoryHtml);
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
				<p style="margin: 0px; text-align: right">
					<img style="vertical-align: middle" alt="" src="../../images/home_icon.gif" /> &gt; 게시물 &gt; 목록 &gt; 상품 &gt; <strong>수정</strong>
				</p>
			</div> 
			<form action="/board/modify_ok.do" method="post" name="mfrm" enctype="multipart/form-data">
				<input type="hidden" name="productSeq" value="${to.getProductSeq() }"/>
				<input type="hidden" name="cpage" value="${cpage }"/>
				<div class="contents_sub">
					<div class="board_write">
						<table>
							<tr>
								<th class="top">작성자(아이디)</th>
								<td class="top" colspan="3">${to.getNickName() }(${to.getId() })</td>
							</tr>
							<tr>
								<th>[분류]상품명</th>
								<td colspan="3">
									<select name="productCategory" id="productCategorySearch" >
									    <option value="">--카테고리--</option>
									    <option value="${to.getProductCategory() }" selected="selected">이전 분류 : ${to.getProductCategory() }</option>
									    <!-- <option value="콜라">콜라</option>
									    <option value="사이다">사이다</option> -->
									</select>
									<input type="text" name="productName" value="${to.getProductName() }" class="board_view_input" />
								</td>
							</tr>
							<tr>
								<th>비밀번호</th>
								<td colspan="3"><input type="password" name="password" value="" class="board_view_input_mail"/></td>
							</tr>
							<tr>
								<th>내용</th>
								<td colspan="3">
									<textarea name="content" class="board_editor_area">${to.getProductContent() }</textarea>
								</td>
							</tr>
							<tr>
								<th>이미지</th>
								<td colspan="3">
									기존 이미지 : ${to.getProductFileName() }<br /><br />
									<input type="file" name="upload" value="" class="board_view_input" /><br /><br />
								</td>
							</tr>
							<tr>
								<th>등록일 / 조회수 / 평점</th>
								<td colspan="3">
									${to.getProductWriteDate() } / ${to.getProductHit() } / ${to.getProductGrade() }
								</td>
							</tr>
						</table>
					</div>
		
					<div class="btn_area">
						<div class="align_left">			
							<input type="button" value="목록" class="btn_list btn_txt02" style="cursor: pointer;" onclick="location.href='/board/list.do?cpage=${cpage}'" />
							<input type="button" value="게시물보기" class="btn_list btn_txt02" style="cursor: pointer;" onclick="location.href='/board/view.do?cpage=${cpage}&productSeq=${to.getProductSeq() }'" />
						</div>
						<div class="align_right">			
							<input type="button" id="mbtn" value="수정" class="btn_write btn_txt01" style="cursor: pointer;" />
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

