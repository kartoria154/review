<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	// 로그인을 하지 않을시 글 작성 불가
	if( session.getAttribute( "userSeq" ) == null){
    	out.println("<script type='text/javascript'>");
    	out.println("alert('로그인해야 됩니다.');");
    	out.println("location.href='/login.do'");
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
		<title>Insert title here</title>
		<link rel="stylesheet" type="text/css" href="../../css/board_write.css">
		<script type="text/javascript">
			window.onload = function() {
				document.getElementById( 'wbtn' ).onclick = function() {
					// 필수 입력 태그
					if( document.wfrm.productCategory.value.trim() == '' ) {
						alert( '제품 카테고리를 선택하십시오.' );
						return false;
					}
					if( document.wfrm.productName.value.trim() == '' ) {
						alert( '제품명을 입력하셔야 합니다.' );
						return false;
					}
					if( document.wfrm.productContent.value.trim() == '' ) {
						alert( '제품설명를 입력하셔야 합니다.' );
						return false;
					}
					if( document.wfrm.upload.value.trim() == '') {
						alert( '사진파일을 지정해야 합니다.' );
						return false;
					}
					
					document.wfrm.submit();
				};
			}
		</script>
	</head>
	
	<body>
		<div class="contents1"> 
			<div class="con_title"> 
				<p style="margin: 0px; text-align: right">
					<img style="vertical-align: middle" alt="" src="../../images/home_icon.gif" /> &gt; 게시판 &gt; <strong>게시물 작성</strong>
				</p>
			</div> 
		
			<form action="/board/write_ok.do" method="post" name="wfrm" enctype="multipart/form-data">
				<div class="contents_sub">
					<div class="board_write">
						<table>
							<tr>
								<th class="top">글쓴이</th>
								<td class="top" colspan="3"><%=nickName %>(<%=id %>)</td>
							</tr>
							<tr>
								<th>카테고리 / 상품명</th>
								<td colspan="3">
									<select name="productCategory">
									    <option value="">카테고리</option>
									    <option value="콜라">콜라</option>
									    <option value="사이다">사이다</option>
									</select>
									<input type="text" name="productName" value="" class="board_view_input" />
								</td>
							</tr>
							<tr>
								<th>제품설명</th>
								<td colspan="3">
									<textarea name="productContent" class="board_editor_area"></textarea>
								</td>
							</tr>
							<tr>
								<th>이미지</th>
								<td colspan="3">
									<input type="file" name="upload" value="" class="board_view_input" /><br /><br />
								</td>
							</tr>
						</table>
					</div>
					<div class="btn_area">
						<div class="align_left">			
							<input type="button" value="목록" class="btn_list btn_txt02" style="cursor: pointer;" onclick="location.href='/board/list.do?cpage=<%=cpage %>'" />
						</div>
						<div class="align_right">			
							<input type="button" id="wbtn" value="쓰기" class="btn_write btn_txt01" style="cursor: pointer;" />					
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
