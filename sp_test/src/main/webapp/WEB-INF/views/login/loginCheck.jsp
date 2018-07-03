<%@page import="oracle.net.aso.l"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그인이 필요한 페이지에서 사용
	//로그인이 안된 경우 에러 처리
	String l_userid=(String)session.getAttribute("userid");
	
	if(l_userid==null || l_userid.isEmpty()){ %>
		<script type="text/javascript">
			alert("먼저 로그인하세요");
			location.href="<%=request.getContextPath()%>/login/login.jsp";
		</script>
		
<%		return;
	}
%>



