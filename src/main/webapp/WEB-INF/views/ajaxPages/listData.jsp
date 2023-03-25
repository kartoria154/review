<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.project.board.to.BoardListTO" %>
<%@ page import="com.project.board.to.BoardListTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	BoardListTO listTOJS = (BoardListTO)request.getAttribute("listTO");
	int cpage = listTOJS.getCpage();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
	<body>
		<c:if test="${listTO != null}">
			<div class="board_top">
				<div class="bold">
					<p>총 <span class="txt_orange">${listTO2.getTotalRecord() }</span>건 <span style="float: right;"><input type="text" name="searck"/><input type="button" value="검색"/></span></p>
				</div>
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
											<a href='/board/view.do?cpage=${listTO.getCpage() })'><img src="../../upload/${lists.getProductFileName() }" border="0" width="100%" height="100%"/></a>
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