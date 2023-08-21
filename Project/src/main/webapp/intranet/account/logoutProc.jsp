<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- mainHead.jsp(Logout 클릭) => logout.jsp -->

<%
	String conPath = request.getContextPath();

	/* 모든 세션 설정 해제 */
	session.invalidate();
%>

<script type="text/javascript">
	alert("로그아웃 되었습니다");
	location.href="login.jsp";
</script>