<%@page import="attd.DayoffDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- attdRecord => overRecordProc.jsp -->
<%
	request.setCharacterEncoding("UTF-8");
	String sid = (String)session.getAttribute("sid");
%>

<jsp:useBean id="db" class="attd.DayoffBean"/>
<jsp:setProperty property="*" name="db"/>

<%
	String msg, url;

	double remain = db.getRemain();
	double off = db.getOff();
	remain = remain - off;
	if(remain<0){
		msg = "사용 가능한 연차일이 부족합니다";
	}else{
		DayoffDao ddao = DayoffDao.getInstance();
		int cnt = ddao.recordDayoffbyId(sid, db);
		
		if(cnt==1){
			msg = "연차 등록이 완료되었습니다";
		}else{
			msg = "insert 실패";
		}
	}
%>

<script type="text/javascript">
	alert('<%=msg%>');
	location.href="attdRecord.jsp";
</script>