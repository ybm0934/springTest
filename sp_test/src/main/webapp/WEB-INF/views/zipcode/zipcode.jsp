<%@page import="com.herbmall.common.PagingVO"%>
<%@page import="com.herbmall.zipcode.model.ZipcodeVO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.zipcode.model.ZipcodeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String dong=request.getParameter("dong");
	
	List<ZipcodeVO> list=null;
	PagingVO pageVo=null;
	int currentPage=1;
	if(dong!=null && !dong.isEmpty()){
		ZipcodeDAO dao = new ZipcodeDAO();
		try{
			list=dao.selectZipcode(dong);
		}catch(SQLException e){
			e.printStackTrace();
		}
		
		String sCurPage=request.getParameter("currentPage");
		if(sCurPage!=null && !sCurPage.isEmpty()){
			currentPage=Integer.parseInt(sCurPage);
		}
		int totalRecord=list.size();
		int pageSize=12;
		int blockSize=10;
		pageVo=new PagingVO(currentPage,totalRecord,pageSize, blockSize);
	}else{
		dong="";
	}
%>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>우편번호 찾기 - 허브몰</title>
<link href="../css/mainstyle.css" rel="stylesheet" type="text/css">
<style type="text/css">
	.divPage{
		width:470px;
		text-align: center;
		margin-top: 10px;
	}
</style>
<script type="text/javascript" 
	src="<%=request.getContextPath()%>/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$('form[name=frmZip]').submit(function(){
			if($('#dong').val()==''){
				alert("지역명을 입력하세요");
				$('#dong').focus();
				return false;
			}
		});
	});

	function setZipcode(zipcode, address){
		opener.frm1.zipcode.value=zipcode;
		opener.frm1.address.value=address;
		
		self.close();
	}
</script>
</head>
<body>
	<h1>우편번호 검색</h1>
	<p>찾고 싶으신 주소의 동(읍, 면)을 입력하세요</p>
	<form name="frmZip" method="post" action="zipcode.jsp">
		<label for="dong">지역명</label>
		<input type="text" name="dong" id="dong" value='<%=dong %>'>
		<input type="submit" value="찾기">		
	</form>
	<br>
	<%if(list!=null){ %>
		<table class="box2" style="width:470px" 
	summary="우편번호 검색 결과에 관한 표로써, 우편번호, 주소에 대한 정보를 제공합니다.">
			<colgroup>
				<col style="width:20%">
				<col style="width:80%">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">우편번호</th>
					<th scope="col">주소</th>
				</tr>
			</thead>
			<tbody>
				<%if(list.isEmpty()){ %>
					<tr>
						<td colspan="2" style="text-align: center">
							해당하는 데이터가 없습니다.</td>
					</tr>
				<%}else{ %>
					<!-- 반복시작 -->					
					<%
					int curPos=pageVo.getCurPos();
					int num=pageVo.getNum();
							
					for(int i=0;i<pageVo.getPageSize();i++){ 
						if(num--<1) break;
						ZipcodeVO vo = list.get(curPos++);
						
						String address=vo.getSido()+" "+ vo.getGugun()+" "
								+vo.getDong() +" ";
						String bunji=vo.getStartbunji();
						if(vo.getEndbunji()!=null && !vo.getEndbunji().isEmpty()){
							bunji+=" ~ "  +vo.getEndbunji();
						}
					%>
						<tr>
							<td><%=vo.getZipcode() %></td>
							<td>
							<a href="#" 
					onclick="setZipcode('<%=vo.getZipcode()%>','<%=address%>')">
								<%=address %> <%=bunji %>
							</a>
							</td>							
						</tr>					
					<%}//for %>
					<!-- 반복끝 -->
				<%}//if %>
			</tbody>
		</table>
		
		<div class="divPage">
			<!-- 페이지 번호 추가 -->		
			<!-- 이전 블럭으로 이동 -->
			<%if(pageVo.getFirstPage()>1){ %>
				<a href="zipcode.jsp?currentPage=<%=pageVo.getFirstPage()-1%>&dong=<%=dong%>">
					<img alt="이전 블럭으로 이동" src="../images/first.JPG">
				</a>	
			<%} %>					
			
			<!-- [1][2][3][4][5][6][7][8][9][10] -->
			<%
				for(int i=pageVo.getFirstPage();i<=pageVo.getLastPage();i++){
					if(i > pageVo.getTotalPage()) break;
					
					if(i==currentPage){   	%>
						<span style="color: blue;font-weight: bold;font-size:1.0em">
							<%=i %></span>
			<%		}else{ %>		
						<a href="zipcode.jsp?currentPage=<%=i %>&dong=<%=dong%>">
							[<%=i %>]</a>
			<%  	}//if
				}//for  %>
				
			<!-- 다음 블럭으로 이동 -->
			<%if(pageVo.getLastPage()<pageVo.getTotalPage()){ %>
				<a href="zipcode.jsp?currentPage=<%=pageVo.getLastPage()+1%>&dong=<%=dong%>">
					<img alt="다음 블럭으로 이동" src="../images/last.JPG">
				</a>	
			<%} %>		
			<!--  페이지 번호 끝 -->
		</div>
	<%}//if %>		
</body>
</html>









