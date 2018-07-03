<%@page import="com.herbmall.member.model.MemberVO"%>
<%@page import="com.herbmall.member.model.MemberService"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="service" class="com.herbmall.member.model.MemberService" 
	scope="session"></jsp:useBean>    
<%
	//회원정보 수정
	request.setCharacterEncoding("utf-8");
	String pwd= request.getParameter("pwd");
	String zipcode= request.getParameter("zipcode");
	String address= request.getParameter("address");
	String addressDetail= request.getParameter("addressDetail");
	String hp1= request.getParameter("hp1");
	String hp2= request.getParameter("hp2");
	String hp3= request.getParameter("hp3");
	String email1= request.getParameter("email1");
	String email2= request.getParameter("email2");
	String email3= request.getParameter("email3");
	
	String userid=(String)session.getAttribute("userid");
	
	String hp="", email="";
	if(hp2!=null && !hp2.isEmpty() && hp3!=null && !hp3.isEmpty()){
		hp=hp1+"-"+hp2+"-"+hp3;	
	}
	
	if(email1!=null && !email1.isEmpty()){
		if(email2.equals("etc")){
			if(email3!=null && !email3.isEmpty()){
				email=email1+"@"+email3;
			}
		}else{
			email=email1+"@"+email2;
		}
	}
	
	String msg="sql error!", url="/member/memberEdit.jsp";
	try{
		int result=service.loginCheck(userid, pwd);
		if(result==MemberService.LOGIN_OK){
			MemberVO vo = new MemberVO();
			vo.setAddress(address);
			vo.setAddressDetail(addressDetail);
			vo.setEmail(email);
			vo.setHp(hp);
			vo.setPwd(pwd);
			vo.setUserid(userid);
			vo.setZipcode(zipcode);
			int cnt = service.updateMember(vo);
			if(cnt>0){
				msg="회원정보 수정되었습니다.";
			}else{
				msg="회원정보 수정 실패!";
			}
		}else if(result==MemberService.PWD_DISAGREE){
			msg="비밀번호가 일치하지 않습니다.";
		}else{
			msg="비밀번호 체크 실패";			
		}
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	request.setAttribute("msg", msg);
	request.setAttribute("url", url);	
%>
<jsp:forward page="../common/message.jsp"></jsp:forward>

