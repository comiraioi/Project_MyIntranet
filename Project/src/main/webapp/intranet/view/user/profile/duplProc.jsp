<%@page import="com.EmpBean"%>
<%@page import="com.EmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String sid = (String)session.getAttribute("sid");

	EmpDao edao = EmpDao.getInstance();
	EmpBean user = edao.getUserProfile(sid); 

	String email = request.getParameter("email");
	System.out.println("email: " + email);
	
	boolean result = edao.searchEmail(email);
	
	System.out.println("result: "+result);
	
	if(result==false && !email.equals(user.getEmail())){
		System.out.println("중복 이메일");
		out.print("NO");
	}else if(result==false && email.equals(user.getEmail())){
		System.out.println("기존 이메일");
		out.print("ORI");
	}else if(result==true){
		System.out.println("사용 가능한 이메일");
		out.print("YES");
	}
%>