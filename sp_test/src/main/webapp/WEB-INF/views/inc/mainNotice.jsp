<%@page import="java.util.List"%>
<%@page import="com.herbmall.board.model.BoardVO"%>
<%@page import="com.herbmall.board.model.BoardService"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	BoardService service = new BoardService();
	List<BoardVO> list=null;
	try{
		list=service.mainNotice();
	}catch(SQLException e){
		e.printStackTrace();
	}
%>    
<style type="text/css">
	.divNotice{
		width:310px;
	}
	.divNotice span{
		margin:0 0 0 160px;
	}
	.img1{
		width:310px;
		height: 6px;
	}
	.divNotice table{
		width: 300px;
	}
</style>

<div class="divNotice">
	<div>
		<img src="<%=request.getContextPath() %>/images/notice2.JPG" 
			alt="공지사항 이미지">
		<span>
			<a href="<%=request.getContextPath()%>/board/list.jsp">
				<img src="<%=request.getContextPath() %>/images/more.JPG" 
					alt="more">
			</a>
		</span>	
	</div>
	<div>
		<img src="<%=request.getContextPath() %>/images/Line.JPG" class="img1">
	</div>
	<div>
		<table>
			<!-- 반복시작 -->
			<%for(BoardVO vo : list){ %>
				<tr>
					<td>
						<img src="<%=request.getContextPath()%>/images/dot.JPG">
						<a href
		="<%=request.getContextPath()%>/board/detail.jsp?no=<%=vo.getNo()%>">
							<%=vo.getTitle() %>
						</a>
					</td>
				</tr>
			<%} %>
			<!-- 반복 끝 -->
		</table>
	</div>
</div>





