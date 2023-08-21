<%@page import="work.ProjectDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- insertProject.jsp => projectInsertProc.jsp -->
<%
	request.setCharacterEncoding("UTF-8"); 
	ProjectDao pdao = ProjectDao.getInstance();
%>

<jsp:useBean id="pb" class="work.ProjectBean"/>
<jsp:setProperty property="*" name="pb"/>

<%
	int cnt = pdao.insertProject(pb);
 
	String msg, url;
	
	if(cnt==1){
		msg = "새로운 프로젝트가 생성되었습니다";
	}else{
		msg = "insert 실패";
	}
%>

<script type="text/javascript">
	alert("<%=msg%>");
	location.href="projectList.jsp?code=<%=pb.getCode() %>";
</script>