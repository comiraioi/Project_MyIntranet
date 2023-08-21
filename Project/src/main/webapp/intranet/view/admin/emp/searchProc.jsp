<%@page import="com.EmpBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.EmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String keyword = request.getParameter("keyword");
	System.out.println("keyword: "+keyword);

	EmpDao edao = EmpDao.getInstance();
	ArrayList<EmpBean> search = edao.searchEmp(keyword);
	
	int size = search.size();
	
	if(size==0){
		System.out.println("해당 사원 없음");
		out.print("NO");
	} else{
		System.out.println("조회 성공");
		out.print("FOUND");
	}
%>