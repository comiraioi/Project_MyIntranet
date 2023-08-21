<%@page import="com.EmpDao"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- Edit Profile(수정하기) => empUpdateProc.jsp -->

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="eb" class="com.EmpBean"/>
<jsp:setProperty property="*" name="eb"/>

<%
	String id = request.getParameter("id");
	System.out.println("수정할 사원 id: "+id);
	
	EmpDao edao = EmpDao.getInstance();
	int cnt = edao.updateEmp(id,eb);

	String msg = "";
	if (cnt == 1) {
		msg = "사원 정보 수정을 완료했습니다";
	} else {
		msg = "수정 실패";
	}
%>

<script type="text/javascript">
	alert("<%=msg%>");
	location.href="empProfile.jsp?id=<%=id %>";
</script>