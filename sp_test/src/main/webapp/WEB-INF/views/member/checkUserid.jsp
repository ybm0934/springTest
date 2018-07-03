<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.member.model.MemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String userid =request.getParameter("userid");
	
	int result=0;
	if(userid!=null && !userid.isEmpty()){
		MemberService service = new MemberService();
		try{
			result=service.checkId(userid);
		}catch(SQLException e){
			e.printStackTrace();
		}
	}
%>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>아이디 중복 검사</title>
<link href="../css/mainstyle.css" rel="stylesheet" type="text/css">
<script type="text/javascript" 
	src="<%=request.getContextPath()%>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$('form[name=frmDup]').submit(function(){
			if($('#userid').val()==''){
				alert("아이디를 입력하세요");
				$('#userid').focus();
				return false;
			}
		});
		
		//사용하기
		$('#btUse').click(function(){
			//opener.frm1.userid.value=$('#userid').val();
			//opener.frm1.chkId.value='Y';
			
			$(opener.document).find("#userid").val($('#userid').val());
			$(opener.document).find("#chkId").val('Y');
			$(opener.document).find("#userid").attr('readonly','readonly');
			
			self.close();
		});
	});
</script>
</head>
<body>
	<h1>아이디 중복검사</h1>
	<form name="frmDup" method="post" action="checkUserid.jsp">
		<label for="userid">아이디</label>
		<input type="text" name="userid" id="userid" value="<%=userid%>" >
		<input type="submit" value="아이디 확인">
		
		<%if(result==MemberService.EXIST_ID){ %>
			<p>이미 등록된 아이디입니다. 다른 아이디를 입력하세요.</p>
		<%}else if(result==MemberService.AVAILABLE_ID){ %>
			<input type="button" id="btUse" value="사용하기">
			<p>사용가능한 아이디입니다. [사용하기]버튼을 클릭하세요.</p>
		<%} %>
	</form>	
</body>
</html>









