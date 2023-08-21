<%@page import="com.CompanyBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.CompanyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="../../mainHead.jsp" %>

<!-- deptList.jsp(code) => deptUpdate.jsp  -->
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript" src="deptCheckbox.js"></script>
<script type="text/javascript" src="duplication.js"></script>

<%
	ArrayList<CompanyBean> lists = cdao.getAllDept();

	int deptno = Integer.parseInt(request.getParameter("deptno"));
	String code = cdao.getCodebyDeptno(deptno);
	String dept = cdao.getDeptbyCode(code);
%>

  <main id="main" class="main">

    <div class="pagetitle">
      <h1>조직 관리</h1>
      <nav>
        <ol class="breadcrumb" style="margin-top: 5px;">
          <li class="breadcrumb-item"><a href="<%=conPath %>/intranet/view/main.jsp">Home</a></li>
          <li class="breadcrumb-item">Admin</li>
          <li class="breadcrumb-item active">조직 관리</li>
        </ol>
      </nav>
    </div><!-- End Page Title -->

<section class="section">
      <div class="row">
        <div class="col-lg-6">
          <div class="card">
            <div class="card-body">
              <h5 class="card-title">Departments</h5>
              <p style="display:inline">우리 회사의 조직도입니다.</p>
              <form name="deptlist" action="deptDelete.jsp" method="post">
                <div class="datable-top"  style="float:right; margin-bottom: 10px;">
              	  <button type="button" class="btn btn-primary btn-sm" onClick="location.href='deptInsert.jsp'">추가</button>&nbsp;&nbsp;
              	  <button type="button" class="btn btn-warning btn-sm" onClick="checkDel()">삭제</button>
                </div>
                <!-- 부서 Table -->
                <div class="datatable-container">
                  <table class="table datatable datatable-table">
                    <thead>
                      <tr style="background-color: #eceefe">
                        <th scope="col" style="width: 15%; padding-left: 5%;">
                          <input type="checkbox" id="allcheck" name="allcheck" onClick="allCheck(this)">
                        </th>
                        <th scope="col" style="width: 27%;">부서 코드</th>
                        <th scope="col" style="width: 27%;">부서명</th>
                        <th scope="col" style="width: 21%;">사원수</th>
                      </tr>
                    </thead>
                    <tbody>
                    <%
                      if(lists.size() == 0){
                	      out.println("");
                      }
                    int count = 0, empcnt=0, total=0, deptcnt=0;
                    int nodcnt = edao.cntEmpbyCode("nod");
                      for(CompanyBean cb : lists){ 
               		    count++; %>
                       <tr>
                         <td style="padding-left: 5%;"> 
                           <input type="checkbox" name="rowchk" value="<%=cb.getDeptno()%>">
                         </td>
                         <td><a href="deptUpdate.jsp?deptno=<%=cb.getDeptno()%>"><%=cb.getCode() %></a></td>
                         <td><%=cb.getDept() %></td>
                         <td style="padding-left: 3%;">
                     	    <% empcnt = edao.cntEmpbyCode(cb.getCode()); 
                     	       total += empcnt; %>
                     	    <b><%=empcnt %></b>명
                         </td>
                       </tr>
                    <%} %>
                    </tbody>
                  </table>
                </div>
                </form>
              <div class="datatable-bottom" style="float:right;">
    			<div class="datatable-info">
    			  <p style="float:right; margin-bottom: 5px;">전체 부서 수: <b><%=count %></b></p><br>
    			  <p style="float:right;"> 부서 내 사원 수: <b><%deptcnt=total-nodcnt;%><%=deptcnt %></b>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;전체 사원 수: <B><%=total %></B></p>
    			</div>
    			<nav class="datatable-pagination"><ul class="datatable-pagination-list"></ul></nav>
			  </div>
              <!-- End 부서 Table -->
            </div>
          </div>
        </div>
        
        <div class="col-lg-6">
          <div class="card">
            <div class="card-body">
              <h5 class="card-title">Update Department</h5>
              <!-- Update Form -->
              <form action="deptUpdateProc.jsp" method="post" onSubmit="return writeSave()">
                <input type="hidden" name="deptno" value="<%=deptno%>">
                <div class="row mb-3">
                  <label class="col-sm-3 col-form-label">부서 코드</label>
                  <div class="col-sm-5">
                    <input type="text" class="form-control" name="code" value="<%=code %>" style="margin-bottom: 5px;" onkeydown="keyd()">
                    <input type="button" class="btn btn-secondary btn-sm" value="중복체크" onClick="codeCheck()">
                    &nbsp;<span id="msg" class="invalid-feedback"></span>
                  </div>
                </div>
                <div class="row mb-3">
                  <label for="inputEmail" class="col-sm-3 col-form-label">부서명</label>
                  <div class="col-sm-5">
                    <input type="text" class="form-control" name="dept" value="<%=dept%>">
                  </div>
                </div>
				<br>
                <div style="text-align: center">
                  <button type="submit" class="btn btn-primary">수정하기</button>
                </div>
              </form><!-- End Update Form -->
            </div>
          </div>
        </div>
        
      </div>
    </section>

  </main><!-- End #main -->

<%@include file="../../mainFoot.jsp" %>