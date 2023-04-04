<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script type="text/javascript">
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
			}
		</script>
	</head>
	<body>
		<c:if test="${listTO != null}">
			<div class="board_top">
				<div class="bold">
					<p>총 <span class="txt_orange">${listTO.getTotalRecord() }</span>건 <span style="float: right;">
						<select name="productCategory" id="productCategorySearch">
						    <!-- <option value="all" selected="selected">--전체--</option>
						    <option value="콜라">콜라</option>
						    <option value="사이다">사이다</option> -->
						</select>
						<input type="text" name="productNameSearch" id="productNameSearch"/><input type="button" value="검색" onclick="productSearch()"/></span>
					</p>
				</div>
			</div>
			<div style="float: right;">
				<span><input id="newProducts" type="button" value="최신순" onclick="listServer(0)"/></span> | <span><input id="hitProducts" type="button" value="조회수순" onclick="listServer(1)"/></span> | <span><input id="gradeProducts" type="button" value="평점순" onclick="listServer(2)"/></span>
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
				</div>
			</div>
		</c:if>
	</body>
</html>