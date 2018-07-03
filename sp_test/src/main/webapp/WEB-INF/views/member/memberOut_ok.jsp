<%@page import="com.herbmall.member.model.MemberService"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="service" class="com.herbmall.member.model.MemberService" 
	scope="session"></jsp:useBean>    
<%
	//회원탈퇴
	//post
	request.setCharacterEncoding("utf-8");
	String pwd =request.getParameter("pwd");
	String userid=(String)session.getAttribute("userid");
	
	String msg="sql error", url="/member/memberOut.jsp";
	try{
		int result=service.loginCheck(userid, pwd);
		if(result==MemberService.LOGIN_OK){
			int cnt=service.withdrawMember(userid);
			if(cnt>0){
				//회원탈퇴 - 세션 제거 
				session.invalidate();
				
				//쿠키 제거
				Cookie ck = new Cookie("ck_userid", userid);
				ck.setPath("/");
				ck.setMaxAge(0);
				response.addCookie(ck);
				
				msg="회원탈퇴 처리되었습니다";
				url="/index.jsp";
			}else{
				msg="회원탈퇴 처리 실패!";
			}
		}else if(result==MemberService.PWD_DISAGREE){
			msg="비밀번호가 일치하지 않습니다";
		}else{
			msg="비밀번호 체크 실패!";
		}
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	request.setAttribute("msg", msg);
	request.setAttribute("url", url);	
%>
<jsp:forward page="../common/message.jsp"></jsp:forward>
