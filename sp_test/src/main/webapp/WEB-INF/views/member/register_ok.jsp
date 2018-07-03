<%@page import="com.herbmall.member.model.MemberVO"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="vo" class="com.herbmall.member.model.MemberVO" scope="page"></jsp:useBean>
<jsp:useBean id="service" class="com.herbmall.member.model.MemberService" scope="session"></jsp:useBean>

<%
	//register2.jsp => post
	//post
	request.setCharacterEncoding("utf-8");
	String name=request.getParameter("name");
	String userid=request.getParameter("userid");
	String pwd=request.getParameter("pwd");
	String email1=request.getParameter("email1");
	String email2=request.getParameter("email2");
	String email3=request.getParameter("email3");
	String hp1=request.getParameter("hp1");
	String hp2=request.getParameter("hp2");
	String hp3=request.getParameter("hp3");
	String zipcode=request.getParameter("zipcode");
	String address=request.getParameter("address");
	String addressDetail=request.getParameter("addressDetail");
	
	String hp="";
	String email="";
	if(hp2!=null && !hp2.isEmpty() && hp3!=null && !hp3.isEmpty()){
		hp=hp1+"-"+hp2+"-"+hp3;
	}
	
	if(email1!=null && !email1.isEmpty()){
		if(email2.equals("etc")){  //직접입력인 경우-email3와 연결
			if(email3!=null && !email3.isEmpty()){
				email=email1+"@"+email3;
			}
		}else{
			email=email1+"@"+email2;
		}
	}
	
	vo.setAddress(address);
	vo.setAddressDetail(addressDetail);
	vo.setEmail(email);
	vo.setHp(hp);
	vo.setName(name);
	vo.setPwd(pwd);
	vo.setUserid(userid);
	vo.setZipcode(zipcode);
	
	String msg="sql error!", url="/member/register.jsp";
	try{
		int cnt=service.insertMember(vo);
		if(cnt>0){
			msg="회원가입되었습니다.";
			url="/index.jsp";
		}else{
			msg="회원가입 실패!";			
		}
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	request.setAttribute("msg", msg);
	request.setAttribute("url", url);	
%>
<jsp:forward page="../common/message.jsp"></jsp:forward>