<%@page import="com.EmpBean"%>
<%@page import="com.EmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String sid = (String)session.getAttribute("sid");

	EmpDao edao = EmpDao.getInstance();
	EmpBean user = edao.getUserProfile(sid); 

	String oripw = request.getParameter("oripw");
	System.out.println("oripw: " + oripw);
	
	boolean result = edao.searchMatchPw(oripw);
	
	System.out.println("result: "+result);
	
	if(result==false){
		System.out.println("비밀번호 불일치");
		out.print("NO");
	}else if(result==true){
		System.out.println("비밀번호 일치");
		out.print("YES");
	}
%>