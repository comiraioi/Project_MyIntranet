<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- lectureRegist.jsp(수강신청,lecno) => registerCheck.jsp -->

<% int lecno = Integer.parseInt(request.getParameter("lecno")); %>

<script type="text/javascript">
	alert("해당 강의를 신청하시겠습니까?");
	location.href="registerProc.jsp?lecno=<%=lecno %>";
</script>
