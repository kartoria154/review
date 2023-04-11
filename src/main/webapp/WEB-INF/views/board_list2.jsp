<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0">
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<title>게시물 목록(main)</title>
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
				productCategory();
				productListData();
			});	
			const productCategory = function(){
				$.ajax({
					type: 'get',
					url: '/board/productCategory.data',
					async:false,
					dataType: 'json',
					success: function(data){
						//console.log(data[1]);
						let categoryHtml = '<option value="all" selected="selected">--전체--</option>';
						for(let i = 0; i < data.length; i++){
							categoryHtml += '<option value="'+data[i]+'">'+data[i]+'</option>';
						};
						$("#productCategorySearch").html(categoryHtml);
					},
					error: function(err) {
						alert('에러' + err.status);
					}
				});
			};
			
			const productListData = function(){
				$.ajax({
					type:"get",
					url:"/board/searchListData.data",
					dataType: "json",
					success: function(jsonData){
						//console.log(jsonData);
						let htmlData = '';
						for(let i = 0; i < jsonData.length; i++){
							htmlData += '<option value="'+jsonData[i]+'"/>';
						};
						$("#testSearch").html(htmlData);
					}
				});
			};
			
			window.onload = function() {
				document.getElementById( 'searchBtn' ).onclick = function() {
					if(document.searchForm.productNameSearch.value.trim() == ''){
						alert( '검색어를 입력하셔야 합니다.' );
						return false;
					}
					document.searchForm.submit();
				}
				
				document.getElementById('productCategorySearch').onclick = function(){
					//console.log(document.getElementById('productCategorySearch').value.trim());
					var searchCategory = document.getElementById('productCategorySearch').value.trim();
					$.ajax({
						type:"get",
						url:"/board/searchListData.data",
						data: {"searchCategory": searchCategory},
						dataType: "json",
						success: function(jsonData){
							//console.log(jsonData);
							let htmlData = '';
							for(let i = 0; i < jsonData.length; i++){
								htmlData += '<option value="'+jsonData[i]+'"/>';
							};
							$("#testSearch").html(htmlData);
						}
					});
				}
				
				/*
				document.getElementById('productNameSearch').onkeyup = function(){
					var searchtxt = document.getElementById('productNameSearch').value.trim();
					var searchCategory = document.getElementById('productCategorySearch').value.trim();
					$.ajax({
						type:"get",
						url:"/board/searchListData.data",
						data: {
							"searchtxt": searchtxt,
							"searchCategory": searchCategory
						},
						dataType: "json",
						success: function(jsonData){
							//console.log(jsonData);
							let htmlData = '';
							for(let i = 0; i < jsonData.length; i++){
								htmlData += '<option value="'+jsonData[i]+'"/>';
							};
							$("#testSearch").html(htmlData);
						}
					});
				}
				*/
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
			<div class="contents_sub">
				<c:if test="${listTO != null}">
					<div class="board_top">
						<div class="bold">
							<span>총 
								<span class="txt_orange">${listTO.getTotalRecord() }</span>
								건 
								
							</span>
							<div style="float: right;">
								<form action="/board/searchList.do" method="get" name="searchForm">
									<select name="productCategory" id="productCategorySearch"></select>
									<input type="text" name="productNameSearch" id="productNameSearch" list="testSearch"/>
									<datalist id="testSearch"></datalist>
									<input type="button" id="searchBtn" value="검색" style="cursor: pointer;" />
								</form>
							</div>
						</div>
					</div>
					<div style="float: right;">
						<span><input id="newProducts" type="button" value="최신순(홈으로)" onclick="location.href='/board/list.do?listNum=0'"/></span> | <span><input id="hitProducts" type="button" value="조회수순" onclick="location.href='/board/list.do?listNum=1'"/></span> | <span><input id="gradeProducts" type="button" value="평점순" onclick="location.href='/board/list.do?listNum=2'"/></span>
					</div>
					<table class="board_list">
						<c:forEach var="lists" items="${listTO.getBoardLists() }" varStatus="status">
							<c:if test="${status.index % 5 == 0}">
								<tr>
							</c:if>
							<td width="20%" class="last2">
								<div class="board">
									<table class="boardT">
										<tr>
											<td class='boardThumbWrap'>
												<div class='boardThumb'>
													<a href='/board/view.do?cpage=${listTO.getCpage() }&productSeq=${lists.getProductSeq() }'><img src="../../upload/${lists.getProductFileName() }" border="0" width="100%" height="100%"/></a>
												</div>																		
											</td>
										</tr>
										<tr>
											<td>
												<div class='boardItem'>	
													<strong>[${lists.getProductCategory() }]${lists.getProductName() }</strong>
													<c:if test="${lists.getWgap() == 0 }">
														<img src="../../images/icon_new.gif" alt="NEW">
													</c:if>
												</div>
											</td>
										</tr>
										<tr>
											<td><div class='boardItem'><span class="bold_blue">${lists.getNickName() }(${lists.getId() })</span></div></td>
										</tr>
										<tr>
											<td><div class='boardItem'>${lists.getProductWriteDate() } <font>|</font> Hit ${lists.getProductHit() }</div></td>
										</tr>
										<tr>
											<td><div class='boardItem'>평점 : ${lists.getProductGrade() }</div></td>
										</tr>
									</table>
								</div>
							</td>
							<c:if test="${status.index % 5 == 4}">
								</tr>
							</c:if>
						</c:forEach>
					</table>
					
					<div class="align_right">		
						<input type="button" value="쓰기" class="btn_write btn_txt01" style="cursor: pointer;" onclick="location.href='/board/write.do?cpage=${listTO.getCpage()}'" />
					</div>
					<div class="paginate_regular">
						<div class="board_pagetab">
							<c:choose>
								 <c:when test="${param.listNum == null}">
								 	<c:choose>
										<c:when test="${listTO.getStartBlock() == 1 }">
											<span class="off"><a href="#">&lt;&lt;</a>&nbsp;&nbsp;</span>
										</c:when>
										<c:otherwise>
											<span class='off'><a href='/board/list.do?cpage=${listTO.getStartBlock() - listTO.getBlockPerPage()}'>&lt;&lt;</a>&nbsp;&nbsp;</span>
										</c:otherwise>
									</c:choose>
									
									<c:choose>
										<c:when test="${listTO.getCpage() == 1 }">
											<span class="off"><a href="#">&lt;</a>&nbsp;&nbsp;</span>
										</c:when>
										<c:otherwise>
											<span class='off'><a href='/board/list.do?cpage=${listTO.getCpage() - 1}'>&lt;</a>&nbsp;&nbsp;</span>
										</c:otherwise>
									</c:choose>
									
									<c:forEach var="i" begin="${listTO.getStartBlock() }" end="${listTO.getEndBlock() }">
										<c:choose>
											<c:when test="${i == listTO.getCpage() }">
												<span class="on"><a href="/board/list.do?cpage=${i }">[${i }]</a></span>
											</c:when>
											<c:otherwise>
												<span class="off"><a href="/board/list.do?cpage=${i }">[${i }]</a></span>
											</c:otherwise>
										</c:choose>
									</c:forEach>
									
									<c:choose>
										<c:when test="${listTO.getCpage() == listTO.getTotalPage() }">
											<span class="off">&nbsp;&nbsp;<a href="#">&gt;</a></span>
										</c:when>
										<c:otherwise>
											<span class="off">&nbsp;&nbsp;<a href="/board/list.do?cpage=${listTO.getCpage() + 1 }">&gt;</a></span>
										</c:otherwise>
									</c:choose>
									
									<c:choose>
										<c:when test="${listTO.getEndBlock() == listTO.getTotalPage() }">
											<span class="off">&nbsp;&nbsp;<a href="#">&gt;&gt;</a></span>
										</c:when>
										<c:otherwise>
											<span class="off">&nbsp;&nbsp;<a href="/board/list.do?cpage=${listTO.getStartBlock() + listTO.getBlockPerPage() }">&gt;&gt;</a></span>
										</c:otherwise>
									</c:choose>
								 </c:when>
								 
								 <c:otherwise>
								 	<c:choose>
										<c:when test="${listTO.getStartBlock() == 1 }">
											<span class="off"><a href="#">&lt;&lt;</a>&nbsp;&nbsp;</span>
										</c:when>
										<c:otherwise>
											<span class='off'><a href='/board/list.do?cpage=${listTO.getStartBlock() - listTO.getBlockPerPage()}&listNum=${param.listNum}'>&lt;&lt;</a>&nbsp;&nbsp;</span>
										</c:otherwise>
									</c:choose>
									
									<c:choose>
										<c:when test="${listTO.getCpage() == 1 }">
											<span class="off"><a href="#">&lt;</a>&nbsp;&nbsp;</span>
										</c:when>
										<c:otherwise>
											<span class='off'><a href='/board/list.do?cpage=${listTO.getCpage() - 1}&listNum=${param.listNum}'>&lt;</a>&nbsp;&nbsp;</span>
										</c:otherwise>
									</c:choose>
									
									<c:forEach var="i" begin="${listTO.getStartBlock() }" end="${listTO.getEndBlock() }">
										<c:choose>
											<c:when test="${i == listTO.getCpage() }">
												<span class="on"><a href="/board/list.do?cpage=${i }&listNum=${param.listNum}">[${i }]</a></span>
											</c:when>
											<c:otherwise>
												<span class="off"><a href="/board/list.do?cpage=${i }&listNum=${param.listNum}">[${i }]</a></span>
											</c:otherwise>
										</c:choose>
									</c:forEach>
									
									<c:choose>
										<c:when test="${listTO.getCpage() == listTO.getTotalPage() }">
											<span class="off">&nbsp;&nbsp;<a href="#">&gt;</a></span>
										</c:when>
										<c:otherwise>
											<span class="off">&nbsp;&nbsp;<a href="/board/list.do?cpage=${listTO.getCpage() + 1 }&listNum=${param.listNum}">&gt;</a></span>
										</c:otherwise>
									</c:choose>
									
									<c:choose>
										<c:when test="${listTO.getEndBlock() == listTO.getTotalPage() }&listNum=${param.listNum}">
											<span class="off">&nbsp;&nbsp;<a href="#">&gt;&gt;</a></span>
										</c:when>
										<c:otherwise>
											<span class="off">&nbsp;&nbsp;<a href="/board/list.do?cpage=${listTO.getStartBlock() + listTO.getBlockPerPage() }&listNum=${param.listNum}">&gt;&gt;</a></span>
										</c:otherwise>
									</c:choose>
								 </c:otherwise>
							</c:choose>
							
						</div>
					</div>
				</c:if>
		  	</div>
		</div>
	</body>
</html>
