<%@page import="com.CompanyBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.CompanyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="../../mainHead.jsp" %>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript" src="empCheck.js"></script>

<%
	String keyword = request.getParameter("keyword");
	String code = request.getParameter("code");
	//System.out.println("부서코드: "+code+"/검색: "+keyword);
	
	ArrayList<EmpBean> lists = edao.searchEmp(code, keyword);
	//System.out.println("조회된 사원 수: "+lists.size());

	ArrayList<EmpBean> elists = edao.getAllEmp();

	String cdept = cdao.getDeptbyCode(code);
%>

  <main id="main" class="main">

    <div class="pagetitle">
      <h1>사원 목록</h1>
      <nav>
        <ol class="breadcrumb" style="margin-top: 5px;">
          <li class="breadcrumb-item"><a href="<%=conPath %>/intranet/view/main.jsp">Home</a></li>
          <li class="breadcrumb-item">Admin</li>
          <li class="breadcrumb-item">사원 관리</li>
          <li class="breadcrumb-item active">사원 목록</li>
        </ol>
      </nav>
    </div><!-- End Page Title -->

    <section class="section">
      <div class="row">
        <div class="col-lg-12">
          <div class="card">
            <div class="card-body">
              <h5 class="card-title">Users</h5>
              <p><%if(code==null || code==""){ %>인트라넷 회원 <%}else if(code.equals("nod")){%>미발령 사원 <%}else{ %><b><%=cdept %></b> 사원 <%} %>목록입니다.</p>
              <form name="search" method="post" style="float:right; margin-bottom: 10px;">
                <input name="keyword" class="datatable-input" placeholder="사원명으로 검색" style="width: 150px">
                <button type="button" class="btn btn-secondary btn-sm" onClick="searchCheck(form)" style="margin-bottom: 5px;">
                  <i class="bi bi-search"></i>
                </button>
              </form>
              
              <form name="seldept" style="float:right; margin-bottom: 10px;">
                <select class="datatable-selector" id="selDept" name="code" onChange="deptCheck()">
                <% if(clists.size() == 0){ %>
                     <option value="">부서가 존재하지 않습니다</option>
                <% } %>
                   <option value="" hidden <%if(code==null){ %>selected<%} %>>부서별 보기</option>
                   <option value="" <%if(code==""){ %>selected<%} %>>전체</option>
                <% for(CompanyBean cb : clists){ %>
                  	  <option value="<%=cb.getCode()%>" <%if(code==null){}else if(code.equals(cb.getCode())){ %>selected<%} %>>
                  	    <%=cb.getDept() %>
                  	  </option>
                <% } %>
                </select>
                &nbsp;&nbsp;
              </form>
              
              <form name="emplist" action="empDelete.jsp" method="post">
                <div class="datable-top">
                  <div style="float:left;">
              	    <button type="button" class="btn btn-warning btn-sm" onClick="checkDel()">삭제</button>
                  </div>
                </div>
                
                <div class="datatable-container">
                <!-- 전체 사원 Table -->
                <table class="table datatable datatable-table">
                  <thead>
                    <tr style="background-color: #eceefe">
                      <th scope="col" style="width: 5%;">
                        <input type="checkbox" id="allcheck" name="allcheck" onClick="allCheck(this)">
                      </th>
                      <th scope="col">아이디</th>
                      <th scope="col">이름</th>
                      <th scope="col">부서</th>
                      <th scope="col">직급</th>
                      <th scope="col">이메일</th>
                      <th scope="col">연봉</th>
                      <th scope="col">권한</th>
                    </tr>
                  </thead>
                  <tbody id="listall">
                    <% if(lists.size() == 0){ %>
                	    <tr><td colspan="8" style="text-align: center">해당 부서에 검색 결과가 없습니다.</td></tr>
                    <% }
                      String dept = "";
                      for(EmpBean eb : lists){ 
                    	dept = cdao.getDeptbyCode(eb.getCode());
                    	//System.out.println("code: "+eb.getCode()+"/dept: "+dept); %>
                       <tr>
                         <td style="width: 5%;"> 
                           <input type="checkbox" name="rowchk" value="<%=eb.getEmpno()%>">
                         </td>
                         <td>
                         	<%if(eb.getId().equals("admin")){ %><%=eb.getId() %><%}
                         	else{ %>
                         	<a href="empProfile.jsp?id=<%=eb.getId()%>" style="width: 15%;"><%=eb.getId() %></a>
                         	<%} %>
                         </td>
                         <td style="width: 15%;"><%=eb.getName() %></td>
                         <td style="width: 15%;"><%if(dept.equals("미발령")){}else{%><%=dept%><% }%></td>
                         <td style="width: 10%;"><%if(eb.getPosition()==null){}else{%><%=eb.getPosition()%><% }%></td>
                         <td style="width: 20%;"><%if(eb.getEmail()==null){}else{%><%=eb.getEmail()%><% }%></td>
                         <td style="width: 10%;"><%if(eb.getSalary()==0){}else{%><%=eb.getSalary()%><% }%></td>
                         <td style="width: 10%; padding-right: 0"><%=eb.getAuthority() %></td>
                       </tr>
                    <%}%>
                  </tbody>
                </table>
                </div>
                <!-- End 사원 Table -->
                
                </form>
              <div class="datatable-bottom" style="float:right;">
    			<div class="datatable-info">
    			  <p style="float:right;">
    			  <%if(code==null || code==""){ %>
    			    전체 회원 수: <b><%=lists.size() %></b>
    			  <%}else{%>
    			    <%=dept %> 사원 수: <b><%=lists.size() %></b>
    			  <%} %>
    			  </p>
    			</div>
    			<nav class="datatable-pagination"><ul class="datatable-pagination-list"></ul></nav>
			  </div>
			  
            </div>
          </div>
        </div>
      </div>
    </section>

  </main><!-- End #main -->

<%@include file="../../mainFoot.jsp" %>