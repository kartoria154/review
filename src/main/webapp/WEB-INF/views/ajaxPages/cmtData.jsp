<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<body>
		<c:if test="${cmtList.size() != 0 }">
			<table>
				<c:forEach var="lists" items="${cmtList }" varStatus="status">
					<tr>
						<c:forEach var="i" begin="1" end="${lists.getCmtGrpl() }">
							<td width="5%" class="cmtGrplB_bg">
								<img src='../../images/icon_re.gif'>
							</td>
						</c:forEach>
						<c:choose>
							<c:when test="${lists.getCmtGrpl() == 0 }">
								<td class="coment_re" colspan="${cmtMaxGrpl - lists.getCmtGrpl() + 1 }">
									<strong>${lists.getNickName() }(${lists.getId() })</strong><br/>
									${lists.getCmtRegDate() }
									<div class="coment_re_txt">
										${lists.getCmtContent() }
									</div>
								</td>
								<td width="8%" class="coment_re">
									<h3 align="center">평점</h3>
									<h3 align="center" id="commentGrade">${lists.getCmtGrade() }</h3>
								</td>
							</c:when>
							<c:otherwise>
								<td class="coment_re" colspan="${cmtMaxGrpl - lists.getCmtGrpl() + 2}">
									<strong>${lists.getNickName() }(${lists.getId() })</strong><br/>
									${lists.getCmtRegDate() }
									<div class="coment_re_txt">
										${lists.getCmtContent() }
									</div>
								</td>
							</c:otherwise>
						</c:choose>
						
						<td class="coment_re" width="15%" align="right" tGrpl="${cmtMaxGrpl}">
							<c:if test="${sessionScope.userSeq != null }">
								<c:if test="${lists.getUserSeq() == sessionScope.userSeq }">
									<input type="button" idx="cmtModify" cSeq="${lists.getCmtSeq() }" cgrpl="${lists.getCmtGrpl() }" value="댓글수정" class="btn_comment btn_txt02" style="cursor: pointer;" />
									<input type="button" idx="cmtDelete" cSeq="${lists.getCmtSeq() }" value="댓글삭제" class="btn_comment btn_txt02" style="cursor: pointer;" />
								</c:if>
								<input type="button" idx="cmtWrite" cSeq="${lists.getCmtSeq() }" value="댓글쓰기" class="btn_comment btn_txt02" style="cursor: pointer;" />
							</c:if>
						</td>
					</tr>
					<tr id="commentTxt${lists.getCmtSeq() }">
					</tr>
				</c:forEach>
			</table>
		</c:if>
		<c:if test="${sessionScope.userSeq != null }">
			<form action="" method="post" name="pcfrm">
				<table>
					<tr>
						<td width="86%" class="bg01">
							<textarea name="ccontent" cols="" rows="" class="coment_input_text"></textarea>
						</td>
						<td width="8%" class="bg01">
							상품 점수 <br/>
							<input size="8" type="text" name="pcgrade" value="" /><br/>
							0 ~ 5.0
						</td>
						<td width="6%" align="right" class="bg01">
							<input type="button" id="pcbtn" value="댓글등록" class="btn_re btn_txt01" onclick="cmtParentWrite()" />
						</td>
					</tr>
				</table>
			</form>
		</c:if>
	</body>
</html>