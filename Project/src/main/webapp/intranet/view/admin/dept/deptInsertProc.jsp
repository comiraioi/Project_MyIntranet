<%@page import="com.CompanyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- deptInsert.jsp(submit) => deptInsertProc.jsp -->
<%
	request.setCharacterEncoding("UTF-8"); 
	CompanyDao cdao = CompanyDao.getInstance();
%>

<jsp:useBean id="cb" class="com.CompanyBean"/>
<jsp:setProperty property="*" name="cb"/>

<%
	int cnt = cdao.insertDept(cb);

	String msg, url;
	
	if(cnt==1){
		msg = "부서가 추가되었습니다";
		url = "deptList.jsp";
	}else{
		msg = "insert 실패";
		url = "deptInsert.jsp";
	}
%>

<script type="text/javascript">
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>