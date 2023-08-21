<%@page import="com.CompanyDao"%>
<%@page import="edu.LectureBean"%>
<%@page import="edu.LectureDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../mainHead.jsp" %>

<%
	int lecno = Integer.parseInt(request.getParameter("lecno"));
	System.out.println("lecno: "+lecno);
	
	LectureDao ldao = LectureDao.getInstance();
	LectureBean lb = ldao.getLecturebyNo(lecno);
	
	String dept = cdao.getDeptbyCode(lb.getCode());
%>

  <main id="main" class="main">

    <div class="pagetitle">
      <h1>수강 신청</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item" style="margin-top: 10px; margin-left: 5px;">
            <a href="lectureList.jsp">강의 목록 보기</a>
          </li>
        </ol>
      </nav>
    </div><!-- End Page Title -->

    <section class="section">
      <div class="row">
        <div class="col-lg-4">

          <div class="card">
            <img src="<%=conPath %>/intranet/view/lectureimg/<%=lb.getThumbnail() %>" class="card-img-top">
            <div class="card-body">
              <div class="text-center">
                <button type="button" class="btn btn-primary" style="margin-top: 10px;" onClick="location.href='registerCheck.jsp?lecno=<%=lb.getLecno() %>'">
                <i class="bi bi-patch-check"></i>&nbsp;&nbsp;수강 신청
                </button>
              </div>
            </div>
          </div>

        </div>

        <div class="col-lg-8">

          <div class="card">
            <div class="card-body">
              <h5 class="card-title"><b><%=lb.getTitle() %></b></h5>
              
              <div>
              	<label class="col-sm-2 col-form-label" style="color: #777;"><b>소요시간</b></label>
              	<p style="color: #4154f1; display: inline;"><%=lb.getLectime() %>분</p>
              </div>
              <div>
              	<label class="col-sm-2 col-form-label" style="color: #777;"><b>추천 대상</b></label>
              	<p style="color: #4154f1; display: inline;"><%=dept %></p>
              </div>
              <div>
              	<label class="col-sm-2 col-form-label" style="color: #777;"><b>내용</b></label>
              	<p style="color: #012970; margin-bottom:5px;"><%=lb.getContents() %></p>
              </div>
              
            </div>
          </div>

        </div>
      </div>
    </section>

  </main><!-- End #main -->

<%@include file="../mainFoot.jsp" %>