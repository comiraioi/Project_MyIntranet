<%@page import="com.EmpBean"%>
<%@page import="com.EmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="eb" class="com.EmpBean"/>
<jsp:setProperty property="*" name="eb"/>

<%
	String sid = (String)session.getAttribute("sid");

	String pw = request.getParameter("pw");
	System.out.println("new pw: " + pw);
	
	EmpDao edao = EmpDao.getInstance();
	int cnt = edao.updatePw(pw,sid);
	
	String msg ="",url="";
	
	if(cnt>0){
		msg = "비밀번호가 변경되었습니다";
		url = "myProfile.jsp";
	}else{ %>
	<script type="text/javascript">
		alert("비밀번호 변경 실패");
		history.go(-1);
	</script>
<% } %>

<script type="text/javascript">
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>