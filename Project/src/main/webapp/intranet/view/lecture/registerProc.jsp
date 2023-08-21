<%@page import="edu.RegisterBean"%>
<%@page import="java.util.Vector"%>
<%@page import="edu.RegisterDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- registerCheck.jsp(확인,lecno) => registerProc.jsp -->

<%
	int lecno = Integer.parseInt(request.getParameter("lecno"));
	String sid = (String)session.getAttribute("sid");

	RegisterDao rdao = RegisterDao.getInstance();
	Vector<RegisterBean> lists = rdao.getRegiLecbyId(sid);
	
	String msg="", url="";
	boolean flag = true;
	for(RegisterBean rb : lists){
		if(rb.getLecno()==lecno){
			flag = false;
			break;
		}
	}
	
	if(flag==false){
		msg = "이미 수강한 강의입니다";
	}else{
		int cnt = rdao.registerLecture(lecno,sid);
		if(cnt>0){
			msg = "수강신청을 완료했습니다";
		}else{
			msg = "수강신청 실패";
		}
	}
%>

<script type="text/javascript">
	alert('<%=msg%>');
	location.href="lectureList.jsp";
</script>