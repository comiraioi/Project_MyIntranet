<%@page import="com.EmpBean"%>
<%@page import="com.EmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- loginbyEmail.jsp => loginbyEmailProc.jsp -->

<% 
	request.setCharacterEncoding("UTF-8");
	
	String email = request.getParameter("email");
	String pw = request.getParameter("pw");
	
	EmpDao edao = EmpDao.getInstance();
	EmpBean user = edao.getUserAccountbyEmail(email,pw);
	 
	String viewPage = null;
	String conPath = request.getContextPath();
	
	if(user != null){
		String userid = user.getId();		//userid: 입력한 id
		String auth = user.getAuthority();	//auth: 접근 권한
		String name = user.getName();		//name: 사원 이름
		
		/* 세션 설정 */
		session.setAttribute("sid", userid);
		session.setAttribute("sauth", auth);
		session.setAttribute("sname", name);
		
		//인트라넷 메인페이지
		viewPage = conPath+"/intranet/view/main.jsp";
	}else{
		viewPage = conPath+"/intranet/account/login.jsp"; %>
		<script type="text/javascript">
			alert("존재하지 않는 회원입니다.");
		</script>
<%	} %>

<script type="text/javascript">
	location.href="<%=viewPage%>";
</script>