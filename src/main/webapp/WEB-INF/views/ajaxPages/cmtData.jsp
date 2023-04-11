<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<body>
		<!-- db에 해당 게시물의 comment가 존재 할시 실행 -->
		<c:if test="${cmtList.size() != 0 }">
			<table>
				<!-- 게시물의 갯수만큼 실행 -->
				<c:forEach var="lists" items="${cmtList }" varStatus="status">
					<tr>
						<!-- 해당 게시물의 grpl수만큼 실행하여 들여쓰기(대댓글)인지 표시 -->
						<c:forEach var="i" begin="1" end="${lists.getCmtGrpl() }">
							<td width="5%" class="cmtGrplB_bg">
								<img src='../../images/icon_re.gif'>
							</td>
						</c:forEach>
						<c:choose>
							<!-- 댓글과 대댓글을 구분하기 위해 grpl 사용 -->
							<c:when test="${lists.getCmtGrpl() == 0 }">
								<td class="coment_re" colspan="${cmtMaxGrpl - lists.getCmtGrpl() + 1 }">
									<strong>${lists.getNickName() }(${lists.getId() })</strong><br/>
									${lists.getCmtRegDate() }
									<div class="coment_re_txt">
										${lists.getCmtContent() }
									</div>
								</td>
								<!-- 댓글의 경우 작성한 평점 태그 추가 -->
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
																		<!-- 리스트에서 가장 높은 grpl -->
						<td class="coment_re" width="15%" align="right" tGrpl="${cmtMaxGrpl}">
							<!-- 로그인 여부 구분 -->
							<c:if test="${sessionScope.userSeq != null }">
								<!-- 로그인한 사용자와 작성자를 체크하여 같을시 수정과 삭제 가능 -->
								<c:if test="${lists.getUserSeq() == sessionScope.userSeq }">
									<input type="button" idx="cmtModify" cSeq="${lists.getCmtSeq() }" cgrpl="${lists.getCmtGrpl() }" value="댓글수정" class="btn_comment btn_txt02" style="cursor: pointer;" />
									<input type="button" idx="cmtDelete" cSeq="${lists.getCmtSeq() }" value="댓글삭제" class="btn_comment btn_txt02" style="cursor: pointer;" />
								</c:if>
								<input type="button" idx="cmtWrite" cSeq="${lists.getCmtSeq() }" value="댓글쓰기" class="btn_comment btn_txt02" style="cursor: pointer;" />
							</c:if>
						</td>
					</tr>
					<!-- 댓글 수정, 댓글 삭제, 댓글 쓰기 클릭시 입력창이 나오는 태그 -->
					<tr id="commentTxt${lists.getCmtSeq() }">
					</tr>
				</c:forEach>
			</table>
		</c:if>
		<!-- 로그인 여부 구분 -->
		<c:if test="${sessionScope.userSeq != null }">
			<form action="" method="post" name="pcfrm">
				<table>
					<tr>
						<c:choose>
							<!-- 해당 게시물에 댓글을 작성하여 평점을 남기지 않은 경우 댓글 작성 가능(대댓글 제외) -->
							<c:when test="${id_check == 1 }">
								<td width="86%" class="bg01">
									<textarea name="ccontent" cols="" rows="" class="coment_input_text" readonly="readonly">리뷰점수를 남기셨습니다.</textarea>
								</td>
								<td width="8%" class="bg01">
									상품 점수 <br/>
									<input size="8" type="text" name="pcgrade" value="" readonly="readonly"/><br/>
									0 ~ 5.0
								</td>
								<td width="6%" align="right" class="bg01">
								</td>
							</c:when>
							<c:otherwise>
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
							</c:otherwise>
						</c:choose>
					</tr>
				</table>
			</form>
		</c:if>
	</body>
</html>