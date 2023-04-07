<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0">
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<title>게시물 : ${to.getProductName() }</title>
		<link rel="stylesheet" type="text/css" href="../../css/board_view.css">
		<script type="text/javascript"  src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script type="text/javascript" src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
		<script type="text/javascript">
			
			const urlParams = new URL(location.href).searchParams;
	
			const testSeq = urlParams.get('productSeq');
			
			$( document ).ready( function() {
				cmtServer();
				
				$('input[idx="cmtWrite"]').button().on('click', function(){
					if($(this).val() == '댓글쓰기'){
						let cSeq = $(this).attr('cSeq');
						let tGrpl = $(this).parent().attr('tGrpl');
						let cmtHtml = '<td class="bg01" colspan="' + (Number(tGrpl)+2) + '">';
							cmtHtml += '	<input type="hidden" id="seq" name="seq" value="'+cSeq+'"/>';
							cmtHtml += '	<textarea id="cmtContent" name="ccontent" cols="" rows="" class="coment_input_text"></textarea>';
							cmtHtml += '</td>';
							cmtHtml += '<td width="15%" align="right" class="bg01">';
							cmtHtml += '	<input type="button" id="cmtBtn" value="댓글등록" class="btn_re btn_txt01" style="cursor: pointer;" onclick="cmtStart()" />';
							cmtHtml += '</td>';
						$("#commentTxt"+cSeq).html(cmtHtml);
						$(this).val('접기');
						$('input[idx="cmtModify"]').val('댓글수정');
						$('input[idx="cmtDelete"]').val('댓글삭제');
					} else if ($(this).val() == '접기'){
						let cSeq = $(this).attr('cSeq');
						$("#commentTxt"+cSeq).html('');
						$(this).val('댓글쓰기');
					}
				});
				
				$('input[idx="cmtModify"]').button().on('click', function(){
					if($(this).val() == '댓글수정'){
						let cSeq = $(this).attr('cSeq');
						let tGrpl = Number($(this).parent().attr('tGrpl'));
						let grpl = Number($(this).attr('cgrpl'));
						//console.log(grpl);
						//let cmtGrade = $('#commentGrade').val();
						//console.log(cmtGrade);
						let cmtHtml = '';
						if(grpl == 0){
							cmtHtml += '<td width="77%" class="bg01" colspan="' + (tGrpl+1) + '">';
							cmtHtml += '	<input type="hidden" id="seq" name="seq" value="'+cSeq+'"/>';
							cmtHtml += '	<input type="hidden" id="grpl" name="grpl" value="'+grpl+'"/>';
							cmtHtml += '	<textarea id="cmtContent" name="ccontent" cols="" rows="" class="coment_input_text"></textarea>';
							cmtHtml += '</td>';
							cmtHtml += '<td width="8%" class="bg01">';
							cmtHtml += '	상품 점수 <br/>';
							cmtHtml += '	<input size="8" type="text" id="cmtGrade" name="cmtGrade" value="" /><br/>';
							cmtHtml += '	0 ~ 5.0';
							cmtHtml += '</td>';
							cmtHtml += '<td width="15%" align="right" class="bg01">';
							cmtHtml += '	<input type="button" id="cmtBtn" value="댓글수정" class="btn_re btn_txt01" style="cursor: pointer;" onclick="cmtStart()" />';
							cmtHtml += '</td>';
						} else {
							cmtHtml += '<td class="bg01" colspan="' + (tGrpl+2) + '">';
							cmtHtml += '	<input type="hidden" id="seq" name="seq" value="'+cSeq+'"/>';
							cmtHtml += '	<input type="hidden" id="grpl" name="grpl" value="'+grpl+'"/>';
							cmtHtml += '	<textarea id="cmtContent" name="ccontent" cols="" rows="" class="coment_input_text"></textarea>';
							cmtHtml += '</td>';
							cmtHtml += '<td width="15%" align="right" class="bg01">';
							cmtHtml += '	<input type="button" id="cmtBtn" value="댓글수정" class="btn_re btn_txt01" style="cursor: pointer;" onclick="cmtStart()" />';
							cmtHtml += '</td>';
						}
						$("#commentTxt"+cSeq).html(cmtHtml);
						$(this).val('접기');
						$('input[idx="cmtWrite"]').val('댓글쓰기');
						$('input[idx="cmtDelete"]').val('댓글삭제');
					} else if ($(this).val() == '접기'){
						let cSeq = $(this).attr('cSeq');
						$("#commentTxt"+cSeq).html('');
						$(this).val('댓글수정');
					}
				});
				
				$('input[idx="cmtDelete"]').button().on('click', function(){
					if($(this).val() == '댓글삭제'){
						let cSeq = $(this).attr('cSeq');
						let tGrpl = $(this).parent().attr('tGrpl');
						let cmtHtml = '<td class="bg01" colspan="' + (Number(tGrpl)+2) + '">';
							cmtHtml += '	<input type="hidden" id="seq" name="seq" value="'+cSeq+'"/>';
							cmtHtml += '	비밀번호 : <input type="password" id="cmtContent" name="password" value="" class="board_view_input_mail"/>';
							cmtHtml += '</td>';
							cmtHtml += '<td width="15%" align="right" class="bg01">';
							cmtHtml += '	<input type="button" id="cmtBtn" value="댓글삭제" class="btn_re btn_txt01" style="cursor: pointer;" onclick="cmtStart()" />';
							cmtHtml += '</td>';
						$("#commentTxt"+cSeq).html(cmtHtml);
						$(this).val('접기');
						$('input[idx="cmtModify"]').val('댓글수정');
						$('input[idx="cmtWrite"]').val('댓글쓰기');
					} else if ($(this).val() == '접기'){
						let cSeq = $(this).attr('cSeq');
						$("#commentTxt"+cSeq).html('');
						$(this).val('댓글삭제');
					}
				});
			
			});
			// cmtData 호출
			const cmtServer = function() {
				$.ajax({
					type: 'get',
					url: '/board/cmt.data',	 
					data: {"productSeq" : testSeq},
					async:false,
					dataType: 'html',
					success: function(htmlData) {
						$("#cmtList").html(htmlData);
					},
					error: function(err) {
						alert('에러' + err.status);
					}
				});
			}

			const cmtParentWrite = function() {
				//alert('aaa');
				if(document.pcfrm.ccontent.value.trim() == ''){
					alert('후기 입력바람');
					return false;
				} else if(document.pcfrm.pcgrade.value.trim() == ''){
					alert('평점 입력바람');
					return false;
				}
				const ccontent = document.pcfrm.ccontent.value.trim();
				const pcgrade = document.pcfrm.pcgrade.value.trim();
				
				$.ajax({
					type: 'post',
					url: '/board/cmtParentWrite_ok.do',
					data: {
						"cmtContent": ccontent,
						"cmtGrade": pcgrade,
						"productSeq" : testSeq
					},
					dataType: 'json',
					success: function(jsonData){
						console.log(jsonData);
						if(jsonData.flag == 0){
							alert('정상처리');
							location.reload();
						} else if(jsonData.flag == 1){
							alert('데이터가 들어가지 않음 다시 시도해 주십시오.');
						} else{
							alert('오류');
						}
					},
					error: function(err) {
						alert('에러' + err.status);
					}
				});
			};
			
			function cmtStart(){
				if( document.getElementById( 'cmtContent' ).value.trim() == '' ) {
					alert( '내용을 입력 하십시오.' );
					return false;
				}
				const cmtContent = document.getElementById( 'cmtContent' ).value.trim();
				const cSeq = document.getElementById( 'seq').value.trim();
				if(document.getElementById('cmtBtn').value.trim() == '댓글등록'){
					cmtReplyWrite(cmtContent, cSeq, testSeq);
				} else if(document.getElementById('cmtBtn').value.trim() == '댓글수정'){
					//console.log(typeof document.getElementById('grpl').value.trim());
					if(document.getElementById('grpl').value.trim() == '0'){
						if(document.getElementById('cmtGrade').value.trim() == ''){
							alert( '평점을 입력 하십시오.' );
							return false;
						}
						const cmtGrade = document.getElementById('cmtGrade').value.trim();
						console.log(cmtGrade);
						cmtParentModify(cmtContent, cSeq, cmtGrade, testSeq);
					} else {
						cmtReplyModify(cmtContent, cSeq, testSeq);
					}
				} else if(document.getElementById('cmtBtn').value.trim() == '댓글삭제'){
					//alert( document.getElementById( 'cmtContent' ).value.trim() );
					cmtReplyDelete(cSeq, cmtContent, testSeq);
				}
			};
			
			const cmtReplyWrite = function(cmtContent, cSeq, productSeq){
				alert('실행');
				$.ajax({
					type: 'post',
					url: '/board/cmtReplyWrite_ok.do',
					data: {
						"cmtContent": cmtContent,
						"pSeq": cSeq,
						"productSeq" : productSeq
					},
					async:false,
					dataType: 'json',
					success: function(jsonData){
						console.log(jsonData);
						if(jsonData.flag == 0){
							alert('정상처리');
							location.reload();
						} else if(jsonData.flag == 1){
							alert('데이터가 들어가지 않음 다시 시도해 주십시오.');
						} else{
							alert('오류');
						}
					},
					error: function(err) {
						alert('에러' + err.status);
					}
				});
			};
			
			const cmtParentModify = function(cmtContent, cSeq, cmtGrade, productSeq){
				//alert('cmtParentModify 실행');
				$.ajax({
					type: 'post',
					url: '/board/cmtReplyModify_ok.do',
					data: {
						"cmtContent": cmtContent,
						"cSeq": cSeq,
						"cmtGrade" : cmtGrade,
						"productSeq" : productSeq
					},
					async:false,
					dataType: 'json',
					success: function(jsonData){
						console.log(jsonData);
						if(jsonData.flag == 0){
							alert('정상처리');
							location.reload();
						} else if(jsonData.flag == 1){
							alert('데이터가 들어가지 않음 다시 시도해 주십시오.');
						} else{
							alert('오류');
						}
					},
					error: function(err) {
						alert('에러' + err.status);
					}
				});
			};
			
			const cmtReplyModify = function(cmtContent, cSeq){
				//alert('실행');
				$.ajax({
					type: 'post',
					url: '/board/cmtReplyModify_ok.do',
					data: {
						"cmtContent": cmtContent,
						"cSeq": cSeq,
					},
					async:false,
					dataType: 'json',
					success: function(jsonData){
						console.log(jsonData);
						if(jsonData.flag == 0){
							alert('정상처리');
							location.reload();
						} else if(jsonData.flag == 1){
							alert('데이터가 들어가지 않음 다시 시도해 주십시오.');
						} else{
							alert('오류');
						}
					},
					error: function(err) {
						alert('에러' + err.status);
					}
				});
			};
			
			const cmtReplyDelete = function(cSeq, password, productSeq){
				//alert('실행');
				$.ajax({
					type: 'post',
					url: '/board/cmtReplyDelete_ok.do',
					data: {
						"cSeq": cSeq,
						"password" : password,
						"productSeq" : productSeq
					},
					async:false,
					dataType: 'json',
					success: function(jsonData){
						console.log(jsonData);
						if(jsonData.flag == 0){
							alert('정상처리');
							location.reload();
						} else if(jsonData.flag == 1){
							alert('데이터가 들어가지 않음 다시 시도해 주십시오.');
						} else if(jsonData.flag == 2){
							alert('비밀번호가 틀렸습니다.');
						} else{
							alert('오류');
						}
					},
					error: function(err) {
						alert('에러' + err.status);
					}
				});
			};
			
			
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
		<div id="cmtTest"></div>
	</body>
</html>
