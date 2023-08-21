<%@page import="com.EmpBean"%>
<%@page import="com.EmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- findPw.jsp => findPwProc.jsp -->
 
<%
	request.setCharacterEncoding("UTF-8");
	EmpDao edao = EmpDao.getInstance();
%>

<jsp:useBean id="eb" class="com.EmpBean"/>
<jsp:setProperty property="*" name="eb"/>

<%
	EmpBean user = edao.getPwbyIdEmail(eb);

	String userpw, msg="", url="";
	if(user != null){
		userpw = user.getPw(); %>
		<script type="text/javascript">
			alert("회원님의 인트라넷 비밀번호는 <%=userpw %> 입니다");
			location.href="<%=request.getContextPath()+"/intranet/account/login.jsp"%>"
		</script>	
<%	}else{
		msg = "존재하지 않는 회원입니다";
		url = "findPw.jsp";
	} %>

<script type="text/javascript">
	alert("<%=msg %>");
	location.href="<%=url%>";
</script>
