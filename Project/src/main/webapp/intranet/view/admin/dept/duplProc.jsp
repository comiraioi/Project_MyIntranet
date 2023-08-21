<%@page import="com.CompanyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String code = request.getParameter("code");
	System.out.println("입력한 코드: " + code);
	
	CompanyDao cdao = CompanyDao.getInstance();
	boolean result = cdao.searchCode(code);
	
	int deptno = 0;
	String oricode = "";
	if(request.getParameter("deptno")!=null){
		deptno = Integer.parseInt(request.getParameter("deptno"));
		System.out.println("부서번호: "+deptno);
		
		oricode = cdao.getCodebyDeptno(deptno);
		System.out.println("기존 코드: " + oricode);
	}
	
	
	if(result==false && !code.equals(oricode)){
		System.out.println("중복 코드");
		out.print("NO");
	}else if(result==false && code.equals(oricode)){
		System.out.println("기존 코드");
		out.print("ORI");
	}else if(result==true){
		System.out.println("사용 가능한 코드");
		out.print("YES");
	}
%>