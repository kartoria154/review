<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0">
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<title>로그인 페이지</title>
		<link rel="stylesheet" type="text/css" href="../../css/board_write.css">
		<script type="text/javascript">
			window.onload = function() {
				document.getElementById('loginBtn').onclick = function(){
					if(document.loginForm.id.value.trim() == '') {
						alert('ID를 입력하십시오.')
						return false;
					}
					if(document.loginForm.password.value.trim() == '') {
						alert('비밀번호를 입력하십시오.')
						return false;
					}
					document.loginForm.submit();
				};
			}
		</script>
	</head>
	<body>
		<div class="contents1"> 
			<div class="con_title"> 
				<p style="margin: 0px; text-align: right">
					<img style="vertical-align: middle" alt="" src="../../images/home_icon.gif" /> &gt; 커뮤니티 &gt; <strong>여행지리뷰</strong>
				</p>
			</div> 
			<form action="/login_ok.do" method="post" name="loginForm">
				<div class="contents_sub">
					<div class="board_write">
						<table>
							<tr>
								<th>이메일</th>
								<td colspan="3"><input type="text" name="id" value="" class="board_view_input" /></td>
							</tr>
							<tr>
								<th>비밀번호</th>
								<td colspan="3"><input type="password" name="password" value="" class="board_view_input_mail"/></td>
							</tr>
						</table>
					</div>
		
					<div class="btn_area">
						<div class="align_left">			
							<input type="button" value="목록" class="btn_list btn_txt02" style="cursor: pointer;" onclick="location.href='board_list1.jsp'" />
						</div>
						<div class="align_right">	
							<input type="button" value="ID찾기" class="btn_list btn_txt02" style="cursor: pointer;" onclick="location.href='member/memberJoin.do'" />		
							<input type="button" value="PW찾기" class="btn_list btn_txt02" style="cursor: pointer;" onclick="location.href='member/memberJoin.do'" />		
							<input type="button" value="회원가입" class="btn_list btn_txt02" style="cursor: pointer;" onclick="location.href='member/joinMember.do'" />		
							<input type="button" id="loginBtn" value="로그인" class="btn_write btn_txt01" style="cursor: pointer;" />					
						</div>	
					</div>
				</div>
			</form>
		</div>
	</body>
</html>
