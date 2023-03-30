<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- cmtList, cmtMaxGrpl -->
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
						<td class="coment_re" colspan="${cmtMaxGrpl - lists.getCmtGrpl() + 1 }">
							<strong>54545</strong> (2016.09.19 02:00)
							<div class="coment_re_txt">
								Test
							</div>
						</td>
						<td class="coment_re" width="25%" align="right">
							<c:if test="${lists.getUserSeq() == sessionScope.userSeq }">
								<input type="button" value="수정" class="btn_comment btn_txt02" style="cursor: pointer;" />
								<input type="button" value="삭제" class="btn_comment btn_txt02" style="cursor: pointer;" />
							</c:if>
							<input type="button" value="댓글쓰기" class="btn_comment btn_txt02" style="cursor: pointer;" />
						</td>
					</tr>
					<tr id="commentTxt${lists.getCmtSeq() }">
					</tr>
				</c:forEach>
			</table>
		</c:if>
		<form action="" method="post" name="cfrm">
			<table>
				<tr>
					<td width="94%" class="bg01">
						<textarea name="ccontent" cols="" rows="" class="coment_input_text"></textarea>
					</td>
					<td width="6%" align="right" class="bg01">
						<input type="button" value="댓글등록" class="btn_re btn_txt01" />
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>