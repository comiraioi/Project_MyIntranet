<%@page import="com.CompanyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- deptUpdate.jsp(submit) => deptUpdateProc.jsp -->

<%
	request.setCharacterEncoding("UTF-8"); 
	CompanyDao cdao = CompanyDao.getInstance();
%>

<jsp:useBean id="cb" class="com.CompanyBean"/>
<jsp:setProperty property="*" name="cb"/>

<%
	int cnt = cdao.updateDept(cb);
	String msg,url;
	
	if(cnt>0){
		msg = "부서 정보가 수정되었습니다";
		url = "deptList.jsp";
	}else{
		msg = "update 실패";
		url = "deptUpdate.jsp?deptno="+cb.getDeptno();
	}
%>

<script type="text/javascript">
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>