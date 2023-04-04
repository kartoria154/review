<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0">
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		<title>회원가입</title>
		<link rel="stylesheet" type="text/css" href="../../css/board_write.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script src="https://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
			/* 중복 체크 확인 */
			var id_check_num = 0;
			/* 중복 검사 후 변경했는지 확인 */
			var id_value = "";
			/* 비밀번호 확인 */
			var pw_check_num = 0;
			
			var password_rule_num = 0;
			window.onload = function() {
				/* document : 현재 문서를 의미함. 작성되고 있는 문서를 뜻함. */
				document.getElementById('joinBtn').onclick = function(){
					console.log("실행확인")
					if( document.joinForm.info.checked == false ) {		/* 개인정보 제공 동의 */
						alert( '동의하셔야 합니다.' );
						return false;
					}
					if(document.joinForm.id.value.trim() == '') {		/* id값이 입력되었는지 확인 */
						alert('ID를 입력하십시오.')
						return false;
					}
					if(id_check_num != 1 || id_value == document.joinForm.id.value.trim()){	/* id중복검사 여부와 검사 후 변경했는지 판단 */
						alert('ID 중복검사를 하십시오.')
						return false;
					}
					if(document.joinForm.password.value.trim() == '') {	/* 비일번호 입력 확인 */
						alert('비밀번호를 입력하십시오.')
						return false;
					}
					if(password_rule_num != 1) {	/* 비일번호 입력 형식 확인 */
						alert('비밀번호를 형식에 맞게 다시 입력하십시오.')
						return false;
					}
					if(document.joinForm.password_check.value.trim() == '') {	/* 비일번호 재확인 입력 확인 */
						alert('비밀번호 확인을 하십시오.')
						return false;
					}
					if(pw_check_num != 1){								/* 비일번호 재확인 일치 확인 */
						alert('비밀번호가 일치하지 않습니다.')
						return false;
					}
					if(document.joinForm.userName.value.trim() == '') {	/* 이름 입력 확인 */
						alert('이름을 입력하십시오.')
						return false;
					}
					document.joinForm.submit();
					
					
				};
				document.getElementById('id_check').onclick = function(){
					/* console.log("중복검사 호출");
					console.log("아이디 입력 값 : " + joinForm.id.value); */
					var reg = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
					if(document.joinForm.id.value.trim() == '') {
						alert('ID를 입력하십시오.')
						return false;
					} else if (reg.test(document.joinForm.id.value.trim())){
						alert('이메일 형식에 맞게 입력하십시오.')
						return false;
					} else {
						$.ajax({
							type :"post",/* 전송 방식 */
							url :"/member/id_check.do", /* 컨트롤러 사용할 때. 내가 보낼 데이터의 주소. */
							data : {"id" : joinForm.id.value},
							async:false,
							dataType : "text",	/* text, xml, html, script, json, jsonp 가능 */
							//정상적인 통신을 했다면 function은 백엔드 단에서 데이터를 처리.
							success : function(data){	
								//console.log(data);
								if(data == "1"){
									alert("이 아이디는 사용 가능합니다.");
									id_check_num = 1;
									id_value = document.joinForm.id.value.trim();
								}else{	//ajax가 제대로 안됐을 때 .
									alert("이 아이디는 사용  불가능합니다.");
									id_check_num = 0;
								}
							},
							error : function(){
								alert("아이디 중복 확인 ajax 실행 실패");
							}
						});
					};
				}
				
				document.getElementById('password').onkeyup = function() {
					//var reg = /^[A-Za-z0-9`~!@#\$%\^&\*\(\)\{\}\[\]\-_=\+\\|;:'"<>,\./\?]{8,20}$/;
					var reg = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,15}$/;
					var password = document.getElementById('password').value;
					var password_rule = document.getElementById('password_rule');				//확인 메세지
					var correctColor = "#00ff00";	//맞았을 때 출력되는 색깔.
					var wrongColor ="#ff0000";	//틀렸을 때 출력되는 색깔
					//console.log(password.search(/\s/) != -1);
					if (reg.test(password)) {
						password_rule.style.color = correctColor;
						password_rule.innerHTML ="사용 가능한 비밀번호 입니다.";
						password_rule_num = 1;
					} else{
						password_rule.style.color = wrongColor;
						password_rule.innerHTML = "형식에 맞지 않습니다. 영문자, 숫자, 특수문자가 하나 이상씩 포함하고 8자 이상 입력하여야 합니다."; 
						password_rule_num = 0;
					}
				};
				
				document.getElementById('password_check').onkeyup = function() {
					/* 비밀번호, 비밀번호 확인 입력창에 입력된 값을 비교해서 같다면 비밀번호 일치, 그렇지 않으면 불일치 라는 텍스트 출력.*/
					
					var password = document.getElementById('password');					//비밀번호 
					var passwordConfirm = document.getElementById('password_check');	//비밀번호 확인 값
					var confrimMsg = document.getElementById('confirmMsg');				//확인 메세지
					var correctColor = "#00ff00";	//맞았을 때 출력되는 색깔.
					var wrongColor ="#ff0000";	//틀렸을 때 출력되는 색깔
					if(password.value == password_check.value){//password 변수의 값과 passwordConfirm 변수의 값과 동일하다.
						confirmMsg.style.color = correctColor;/* span 태그의 ID(confirmMsg) 사용  */
						confirmMsg.innerHTML ="비밀번호 일치";/* innerHTML : HTML 내부에 추가적인 내용을 넣을 때 사용하는 것. */
						pw_check_num = 1;
					}else{
						confirmMsg.style.color = wrongColor;
						confirmMsg.innerHTML ="비밀번호 불일치";
						pw_check_num = 0;
					}
				}
			};
		</script>
	</head>
	<body>
		<!-- 상단 디자인 -->
		<div class="contents1"> 
			<div class="con_title"> 
				<p style="margin: 0px; text-align: right">
					<img style="vertical-align: middle" alt="" src="../../images/home_icon.gif" /> &gt; <strong>회원가입</strong>
				</p>
			</div> 
			<form action="./joinMember_ok.do" method="post" name="joinForm">
				<div class="contents_sub">
				<!--게시판-->
					<div class="board_write">
						<table>
							<tr>
								<th class="top">ID</th>
								<td class="top" colspan="3">
									<input type="text" name="id" value="" class="board_view_input_mail" />
									<input type="button" id="id_check" value="중복체크" class="btn_list btn_txt02" style="cursor: pointer;"/>
								</td>
							</tr>
							<tr>
								<th>비밀번호</th>
								<td colspan="3">
									<input type="password" name="password" id="password" value="" class="board_view_input" /><br/>
									<span id="password_rule"></span>
								</td>
							</tr>
							<tr>
								<th>비밀번호 확인</th>
								<td colspan="3">
									<input type="password" name="password_check" id="password_check" value="" class="board_view_input"/>
									<span id ="confirmMsg"></span>
								</td>
							</tr>
							<tr>
								<th>이름</th>
								<td colspan="3"><input type="text" name="userName" value="" class="board_view_input_mail"/></td>
							</tr>
							<tr>
								<th>닉네임</th>
									<td colspan="3"><input type="text" name="userNick" value="" class="board_view_input_mail"/>
									<div style="font-size: 1px">※입력하지 않으면 고객님의 이름으로 대체됩니다.</div>
									<!-- <blockquote style="font-size: 1px">※입력하지 않으면 고객님의 이름으로 대체됩니다.</blockquote> -->
								</td>
							</tr>
						</table>
						<table>	
							<tr>
								<br />
								<td style="text-align:left;border:1px solid #e0e0e0;background-color:f9f9f9;padding:5px">
									<div style="padding-top:7px;padding-bottom:5px;font-weight:bold;padding-left:7px;font-family: Gulim,Tahoma,verdana;">※ 개인정보 수집 및 이용에 관한 안내</div>
									<div style="padding-left:10px;">
										<div style="width:97%;height:95px;font-size:11px;letter-spacing: -0.1em;border:1px solid #c5c5c5;background-color:#fff;padding-left:14px;padding-top:7px;"> 
											 1. 수집 개인정보 항목 : 이용자명, 메일 주소 <br />
											 2. 개인정보의 수집 및 이용목적 : 제휴신청에 따른 본인확인 및 원활한 의사소통 경로 확보 <br />
											 3. 개인정보의 이용기간 : 모든 검토가 완료된 후 3개월간 이용자의 조회를 위하여 보관하며, 이후 해당정보를 지체 없이 파기합니다. <br />
											 4. 그 밖의 사항은 개인정보취급방침을 준수합니다.
										</div>
									</div>
									<div style="padding-top:7px;padding-left:5px;padding-bottom:7px;font-family: Gulim,Tahoma,verdana;">
										<input type="checkbox" name="info" value="1" class="input_radio"> 개인정보 수집 및 이용에 대해 동의합니다.
									</div>
								</td>
							</tr>
						</table>
					</div>
					<div class="btn_area">
						<div class="align_left">			
							<input type="button" value="홈" class="btn_list btn_txt02" style="cursor: pointer;" onclick="location.href='/board/list.do'" />
						</div>
						<div class="align_right">			
							<input type="button" value="가입하기" id="joinBtn" class="btn_write btn_txt01" style="cursor: pointer;" />					
						</div>	
					</div>
				</div>
			</form>
		</div>
	</body>
</html>
