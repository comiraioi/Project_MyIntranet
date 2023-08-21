<%@page import="edu.LectureBean"%>
<%@page import="edu.LectureDao"%>
<%@page import="edu.RegisterBean"%>
<%@page import="java.util.Vector"%>
<%@page import="edu.RegisterDao"%>
<%@page import="com.CompanyBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.CompanyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="../../mainHead.jsp" %>

<!-- mainHead.jsp(사내교육참여도) => eduChart.jsp -->
<%
	RegisterDao rdao = RegisterDao.getInstance();
	Vector<RegisterBean> lists = rdao.getAllRegister();
%>

  <main id="main" class="main">

    <div class="pagetitle">
      <h1>사내 교육 참여도</h1>
      <nav>
        <ol class="breadcrumb" style="margin-top: 5px;">
          <li class="breadcrumb-item">Admin</li>
          <li class="breadcrumb-item">사원 관리</li>
          <li class="breadcrumb-item active">사내 교육 참여도</li>
        </ol>
      </nav>
    </div><!-- End Page Title -->

    <section class="section">
      <div class="row">
      <%if(lists.size()==0){}else{ %>
        <div class="col-lg-7">
          <!-- Pie Chart -->
          <div class="card">
            <div class="card-body">
              <h5 class="card-title"><b>부서별 교육 참여도</b></h5>
              <canvas id="pieChart" style="max-height: 400px; display: block; box-sizing: border-box; height: 400px; width: 767px;" width="1534" height="800"></canvas>
              <script>
                document.addEventListener("DOMContentLoaded", () => {
                  new Chart(document.querySelector('#pieChart'), {
                    type: 'pie',
                    data: {
                      labels: [
                     <% for(int i=1; i<clists.size(); i++){ %>
                        '<%=clists.get(i).getDept() %>',
                     <% } %>
                      ],
                      datasets: [{
                        label: '수강 횟수',
                        data: [
                          <% int num = 0;
                            for(int i=1; i<clists.size(); i++){ 
                          		num = rdao.getRegiNumbyCode(clists.get(i).getCode()); %>
                          		<%=num%>,
                          <%} %>
                        ],
                        backgroundColor: [
                          'rgb(255, 99, 132)',
                          'rgb(54, 162, 235)',
                          'rgb(255, 205, 86)',
                          'rgb(75, 192, 192)',
                          'rgb(201, 203, 207)'
                        ],
                        hoverOffset: 4
                      }]
                    }
                  });
                });
              </script>
            </div>
          </div>
          <!-- End Pie CHart -->
        </div>
      <%} %>
        
        <div class="col-lg-12">
          <!-- 전체 사원 수강이력 Table -->
          <div class="card">
            <div class="card-body">
              <h5 class="card-title">Participation</h5>
              <p>전체 사원의 강의 수강 이력입니다.</p>
                <div class="datable-top">
                </div>
                <div class="datatable-container">
                <table class="table datatable datatable-table">
                  <thead>
                    <tr style="background-color: #eceefe">
                      <th scope="col" style="width: 20%; padding-left: 5%">#</th>
                      <th scope="col" style="width: 25%;">사원 이름</th>
                      <th scope="col" style="width: 20%;">부서</th>
                      <th scope="col" style="width: 35%;">강의명</th>
                    </tr>
                  </thead>
                  <tbody id="listall">
                    <% if(lists.size() == 0){ %>
                	    <tr><td colspan="4" style="text-align:center">사내 교육을 이수한 사원이 없습니다</td></tr>
                     <% }
                      int count = 0;
                      for(RegisterBean rb : lists){ 
               		 	
               		    LectureDao ldao = LectureDao.getInstance();
						LectureBean lb = ldao.getLecturebyNo(rb.getLecno()); 
						
               		 	EmpBean eb = edao.getUserProfile(rb.getId());
               		 	
               		 	String dept = cdao.getDeptbyCode(eb.getCode());
					%>
                       <tr>
                         <td style="padding-left: 5%"><%=rb.getRegino() %></a></td>
                         <td><%=eb.getName() %></td>
                         <td><%=dept%></td>
                         <td><%=lb.getTitle() %></td>
                       </tr>
                    <%}%>
                  </tbody>
                </table>
                </div>
              <div class="datatable-bottom" style="float:right;">
			  </div>
              <!-- End 부서 Table -->
            </div>
          </div>
        </div>
      </div>
    </section>

  </main><!-- End #main -->

<%@include file="../../mainFoot.jsp" %>