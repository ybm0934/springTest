<%@page import="com.herbmall.member.model.MemberVO"%>
<%@page import="com.herbmall.member.model.MemberService"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="service" class="com.herbmall.member.model.MemberService" 
	scope="session"></jsp:useBean>    
<%
	//post
	//로그인 처리 후 세션에 아이디 저장, 체크되었으면 쿠키에 아이디 저장
	request.setCharacterEncoding("utf-8");
	String userid =request.getParameter("userid");
	String pwd =request.getParameter("pwd");
	String saveId =request.getParameter("saveId");
	
	int result=0;
	String msg="sql error!", url="/login/login.jsp";
	try{
		result=service.loginCheck(userid, pwd);
		if(result==MemberService.LOGIN_OK){
			//로그인 성공
			MemberVO vo =service.selectByUserid(userid);
			
			//[1] session에 아이디 저장
			session.setAttribute("userid", userid);
			session.setAttribute("userName", vo.getName());
			
			//[2] 체크되었으면 쿠키에 아이디 저장
			Cookie ck = new Cookie("ck_userid", userid);
			ck.setPath("/");
			
			if(saveId!=null){
				ck.setMaxAge(1000*24*60*60);  //쿠키 유효기간 - 1000일
				response.addCookie(ck);
			}else{  //체크가 되지 않았으면 기존 쿠키 삭제
				ck.setMaxAge(0);  //쿠키삭제
				response.addCookie(ck);
			}
			msg=vo.getName()+"님! 로그인되었습니다.";
			url="/index.jsp";
		}else if(result==MemberService.PWD_DISAGREE){
			msg="비밀번호가 일치하지 않습니다.";		
		}else if(result==MemberService.ID_NONE){
			msg="아이디가 존재하지 않습니다.";		
		}else{
			msg="로그인 처리 실패.";		
		}
	}catch(SQLException e){
		e.printStackTrace();
	}
		
	request.setAttribute("msg", msg);
	request.setAttribute("url", url);	
%>
<jsp:forward page="../common/message.jsp"></jsp:forward>




