<%@page import="edu.LectureBean"%>
<%@page import="edu.LectureDao"%>
<%@page import="edu.RegisterBean"%>
<%@page import="java.util.Vector"%>
<%@page import="edu.RegisterDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../mainHead.jsp" %>

<%
	RegisterDao rdao = RegisterDao.getInstance();
	Vector<RegisterBean> lists = rdao.getRegiLecbyId(sid);
%>

  <main id="main" class="main">

    <div class="pagetitle">
      <h1>수강 이력</h1>
      <nav>
        <ol class="breadcrumb" style="margin-top: 5px;">
          <li class="breadcrumb-item">User</li>
          <li class="breadcrumb-item">사내 교육</li>
          <li class="breadcrumb-item active">수강 이력</li>
        </ol>
      </nav>
    </div><!-- End Page Title -->

    <section class="section">
      <div class="row">
        <div class="col-lg-12">

          <div class="card">
            <div class="card-body">
              <h5 class="card-title">History</h5>
              <p><%=name %>님이 수강하신 사내 교육 이력입니다</p>
              <div class="datatable-container">
              	<table class="table datatable datatable-table">
              	  <thead>
              	    <tr style="background-color: #eceefe">
              	      <th scope="col" style="width: 30%; padding-left: 5%;">#</th>
              	      <th scope="col" style="width: 40%;">강의명</th>
              	      <th scope="col" style="width: 30%;">강의 시간</th>
              	    </tr>
              	  </thead>
              	  <tbody>
              	  <% int count=0, time=0, hour=0, min=0;
              	  	if(lists.size()==0){ %>
              	  		<tr><td colspan="3" align="center">수강하신 강의가 없습니다.</td></tr>
              	  <% }else{
              	  	for(RegisterBean rb : lists){
              	  		count++; 
              	  		LectureDao ldao = LectureDao.getInstance();
						LectureBean lb = ldao.getLecturebyNo(rb.getLecno());			%>
              	  		<tr>
              	  			<td style="padding-left: 5%;"><%=count %></td>
              	  			<td><a href="lectureRegist.jsp?lecno=<%=lb.getLecno()%>"><%=lb.getTitle() %></a></td>
              	  			<td><%=lb.getLectime() %>분</td>
              	  		</tr>
              	  <%	time += lb.getLectime();
              			hour=time/60;
              			min=time-(hour*60);
              	     }//for
              	  }//if~else
              	  %>
              	  </tbody>
              	</table>
              </div>
              <div class="datatable-bottom" style="float:right;">
                <div class="datatable-info">
                  <p style="float:right; margin-bottom: 5px;">수강한 강의 수: <b><%=count %>개</b></p><br>
                  <p style="float:right; margin-bottom: 5px;">전체 수강 시간: <b><%=hour %>시간&nbsp;<%=min %>분</b></p>
                </div>
              </div>
            </div>
          </div>

        </div>

      </div>
    </section>

  </main><!-- End #main -->

<%@include file="../mainFoot.jsp" %>