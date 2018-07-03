<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/top.jsp" %>
<%
	//쿠키에서 아이디 읽어오기
	String ckUserid="";
	Cookie[] ckArr =request.getCookies();
	if(ckArr!=null){
		for(int i=0;i<ckArr.length;i++){
			if(ckArr[i].getName().equals("ck_userid")){
				ckUserid=ckArr[i].getValue();
				break;
			}			
		}//for
	}
%>

<script type="text/javascript">
	$(document).ready(function(){
		$('form[name=frmLogin]').submit(function(){
			var bool=true;
			
			$('.valid').each(function(idx, item){
				if($(this).val().length<1){
					alert($(this).prev().text()+"를 입력하세요");
					$(this).focus();
					bool=false;
					return false;
				}
			});
			
			return bool;
		});	
	});
</script>
<article class="simpleForm">
	<form name="frmLogin" method="post" action="login_ok.jsp">
		<fieldset>
			<legend>로그인</legend>
			<div>
				<label for="userid" class="label">아이디</label>
				<input type="text" name="userid" class="valid" 
					value="<%=ckUserid%>">
			</div>
			<div>
				<label for="pwd" class="label">비밀번호</label>
				<input type="password" name="pwd" class="valid">
			</div>
			<div class="align_center">
				<input type="submit" value="로그인">
				<input type="checkbox" name="saveId" id="saveId" 
					<%if(ckUserid!=null && !ckUserid.isEmpty()){ %>
						checked="checked"
					<%} %>
					>
				<label for="saveId">아이디 저장하기</label>
			</div>
		</fieldset>
	</form>

</article>

<%@ include file="../inc/bottom.jsp" %>







