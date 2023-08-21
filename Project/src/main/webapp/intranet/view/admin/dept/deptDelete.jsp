<%@page import="com.CompanyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- deptList.jsp(체크박스 체크+삭제 클릭) => deptDelete.jsp -->

<%
	CompanyDao cdao = CompanyDao.getInstance();

	String[] num = request.getParameterValues("rowchk");
	for(int i=0;i<num.length;i++){
   		System.out.println(num[i]);
   	}
	
   	int cnt = cdao.deleteDept(num);
   	
   	String msg; 
   	if(cnt > 0){
   		msg = "선택하신 부서가 삭제되었습니다";
   	}else{
		msg = "delete 실패";
	}
%>

<script type="text/javascript">
	alert("<%=msg%>");
	location.href="<%="deptList.jsp"%>";
</script>