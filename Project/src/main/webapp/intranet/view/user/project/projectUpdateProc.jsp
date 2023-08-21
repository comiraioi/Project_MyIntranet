<%@page import="work.ProjectDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- viewProject.jsp => projectUpdateProc.jsp -->
<%
	request.setCharacterEncoding("UTF-8"); 
	int prono = Integer.parseInt(request.getParameter("prono"));
	System.out.println("prono: "+prono);
	
	ProjectDao pdao = ProjectDao.getInstance();
%>

<jsp:useBean id="pb" class="work.ProjectBean"/>
<jsp:setProperty property="*" name="pb"/>

<%
	int cnt = pdao.updateProject(prono, pb);
  
	String msg, url;
	if(cnt==1){
		msg = "프로젝트가 수정되었습니다";
	}else{
		msg = "update 실패";
	}
%>

<script type="text/javascript">
	alert("<%=msg%>");
	location.href="viewProject.jsp?prono=<%=pb.getProno() %>";
</script>