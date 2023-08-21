<%@page import="com.EmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String inputemail = request.getParameter("inputemail");
	System.out.println("inputemail: " + inputemail);
	
	EmpDao edao = EmpDao.getInstance();
	boolean result = edao.searchEmail(inputemail); 
	
	System.out.println("result: "+result);
	
	if(result==false){
		System.out.println("중복 이메일");
		out.print("NO");
	} else{
		System.out.println("사용 가능한 이메일");
		out.print("YES");
	}

%>