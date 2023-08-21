<%@page import="attd.OverDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- attdRecord => overRecordProc.jsp -->
<%
	request.setCharacterEncoding("UTF-8");
	String sid = (String)session.getAttribute("sid");
%>

<jsp:useBean id="ob" class="attd.OverBean"/>
<jsp:setProperty property="*" name="ob"/>

<%
	OverDao odao = OverDao.getInstance();
	int cnt = odao.recordOvertbyId(sid, ob);
	 
	String msg, url;
	
	if(cnt==1){
		msg = "초과 근무 등록이 완료되었습니다";
	}else{
		msg = "insert 실패";
	}
%>

<script type="text/javascript">
	alert('<%=msg%>');
	location.href="attdRecord.jsp";
</script>