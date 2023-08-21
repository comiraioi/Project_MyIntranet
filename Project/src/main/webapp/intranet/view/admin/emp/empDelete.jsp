<%@page import="com.EmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- empList.jsp(체크박스 체크+삭제 클릭) => empDelete.jsp -->

<%
	EmpDao edao = EmpDao.getInstance();

	String[] num = request.getParameterValues("rowchk");
	for(int i=0;i<num.length;i++){
   		System.out.println(num[i]);
   	}
	
   	int cnt = edao.deleteEmp(num);
   	
   	String msg; 
   	if(cnt > 0){
   		msg = "선택하신 사원의 계정이 삭제되었습니다";
   	}else{
		msg = "delete 실패";
	}
%>

<script type="text/javascript">
	alert("<%=msg%>");
	location.href="<%="empList.jsp"%>";
</script>