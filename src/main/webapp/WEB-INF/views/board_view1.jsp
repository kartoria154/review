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
		<link rel="stylesheet" type="text/css" href="../../css/board_view.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script type="text/javascript" src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
		<script type="text/javascript">
			const urlParams = new URL(location.href).searchParams;
	
			const testSeq = urlParams.get('productSeq');
			
			$( document ).ready( function() {
				cmtServer();
			});
			// cmtData 호출
			const cmtServer = function() {
				$.ajax({
					type: 'get',
					url: '/board/cmt.data',	 
					data: {"productSeq" : testSeq},
					//async:false,
					dataType: 'html',
					success: function(htmlData) {
						$("#cmtList").html(htmlData);
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
					<img style="vertical-align: middle" alt="" src="../../images/home_icon.gif" /> &gt; 게시물 &gt; 목록 &gt; <strong>상품</strong>
				</p>
			</div>
			<div class="contents_sub">
				<div class="board_view">
					<table>
						<tr>
							<th width="10%">[분류]상품명</th>
							<td width="45%">[${to.getProductCategory() }]${to.getProductName() }</td>
							<th width="10%">등록일</th>
							<td width="35%">${to.getProductWriteDate() }</td>
						</tr>
						<tr>
							<th>닉네임(아이디)</th>
							<td>${to.getNickName() }(${to.getId() })</td>
							<th>조회 / 평점</th>
							<td>${to.getProductHit() } / ${to.getProductGrade() }</td>
						</tr>
						<tr>
							<td colspan="2" height="200" valign="top" style="padding:20px; line-height:160%">
								<div id="bbs_file_wrap">
									<div>
										<img src="../../upload/${to.getProductFileName() }" width="700" onerror="" /><br />
									</div>
								</div>
							</td>
							<td colspan="2">${to.getProductContent() }</td>
						</tr>			
					</table>
					<div id="cmtList"></div>
				</div>
				<div class="btn_area">
					<div class="align_left">			
						<input type="button" value="목록" class="btn_list btn_txt02" style="cursor: pointer;" onclick="location.href='/board/list.do?cpage=${cpage}'" />
					</div>
					<div class="align_right">
						<c:if test="${sessionScope.userSeq == to.getUserSeq()}">
							<input type="button" value="수정" class="btn_list btn_txt02" style="cursor: pointer;" onclick="location.href='/board/modify.do?cpage=${cpage}&productSeq=${to.getProductSeq() }'" />
							<input type="button" value="삭제" class="btn_list btn_txt02" style="cursor: pointer;" onclick="location.href='/board/delete.do?cpage=${cpage}&productSeq=${to.getProductSeq() }'" />
						</c:if>
						<input type="button" value="쓰기" class="btn_write btn_txt01" style="cursor: pointer;" onclick="location.href='/board/write.do?cpage=${cpage}'" />
					</div>	
				</div>
			</div>
		</div>
	</body>
</html>
