<%@page import="com.EmpBean"%>
<%@page import="com.EmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 회원가입 클릭 (register.jsp) => registerProc.jsp -->
<%
	request.setCharacterEncoding("utf-8");
	EmpDao edao = EmpDao.getInstance();
%>
 
<jsp:useBean id="eb" class="com.EmpBean"/>
<jsp:setProperty property="*" name="eb"/>

<%
	int cnt = edao.insertEmp(eb);
	System.out.println("insertEmp:"+cnt);

	String msg="", url="";
	if(cnt == 1){
		EmpBean user = edao.getIdbyPwEmail(eb);
		String userid = user.getId(); %>
		<script type="text/javascript">
			alert("회원가입 성공");
			alert("회원님의 인트라넷 아이디는 <%=userid %> 입니다");
			location.href="<%=request.getContextPath()+"/intranet/account/login.jsp"%>"
		</script>	
<%	}else{
		msg = "회원가입 실패";
		url = "register.jsp";
	} %>
	
<script type="text/javascript">
	alert("<%=msg %>");
	location.href="<%=url%>";
</script>
