<%@page import="edu.RegisterBean"%>
<%@page import="java.util.Vector"%>
<%@page import="edu.RegisterDao"%>
<%@page import="com.CompanyBean"%>
<%@page import="com.CompanyDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="edu.LectureDao"%>
<%@page import="edu.LectureBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../mainHead.jsp" %>

  <main id="main" class="main">

    <div class="pagetitle">
      <h1>교육 신청</h1>
      <nav>
        <ol class="breadcrumb" style="margin-top: 5px;">
          <li class="breadcrumb-item">User</li>
          <li class="breadcrumb-item">사내 교육</li>
          <li class="breadcrumb-item active">수강 신청</li>
        </ol>
      </nav>
    </div><!-- End Page Title -->

<%
	LectureDao ldao = LectureDao.getInstance();
	ArrayList<LectureBean> lists = ldao.getAllLecture();
	
	RegisterDao rdao = RegisterDao.getInstance();
	Vector<RegisterBean> rlists = rdao.getRegiLecbyId(sid);
%>
  <div class="card"><div class="card-body pt-3">
  <h5 class="card-title" style="margin-left: 5px; margin-bottom: 0;"><b>부서별 추천 강의</b></h5>
  <!-- Bordered Tabs -->
  <ul class="nav nav-tabs" role="tablist">
    <li class="nav-item" role="presentation">
      <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#all" aria-selected="true" role="tab">전체보기</button>
    </li>
  <%for(int i=1; i<clists.size(); i++){ %>
    <li class="nav-item" role="presentation">
      <button class="nav-link" data-bs-toggle="tab" data-bs-target="#<%=clists.get(i).getCode() %>" aria-selected="false" tabindex="-1" role="tab"><%=clists.get(i).getDept() %></button>
    </li>
  <%} %>
  </ul><br>
  
  <div class="tab-content pt-2">
  
  	<!-- Tab Content #all -->
    <div class="tab-pane fade show active" id="all">
    <section class="section">
      <div class="row">
    <%if(lists.size()==0){
		out.println("현재 진행중인 강의가 없습니다");
	  }
	  for(LectureBean lb : lists){%>
        <div class="col-lg-4"><div class="card"><div class="card-body">
          <h5 class="card-title">
            <a href="<%=conPath %>/intranet/view/lecture/lectureRegist.jsp?lecno=<%=lb.getLecno() %>">
              <b style="color: #012970; font-size: 13pt;"><%=lb.getTitle() %></b>
              <%for(RegisterBean rb : rlists){ if(rb.getLecno()==lb.getLecno()){ %><i class="bi bi-patch-check-fill"></i><%}} %>
            </a>
          </h5>
          <!-- Slides only carousel -->
          <div id="carouselExampleSlidesOnly" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner">
              <div class="carousel-item active">
                <a href="<%=conPath %>/intranet/view/lecture/lectureRegist.jsp?lecno=<%=lb.getLecno() %>">
                  <img src="<%=conPath %>/intranet/view/lectureimg/<%=lb.getThumbnail() %>" class="d-block w-100" alt="...">
                </a>
              </div>
            </div>
          </div>
          <!-- End Slides only carousel-->
        </div></div></div>
  <% } %>
      </div>
    </section>
    </div>
    <!-- End Tab Content #all -->
    
    <%
    String ccode = "";
    for(int p=1; p<clists.size(); p++){
      ccode = clists.get(p).getCode();
      ArrayList<LectureBean> llists = ldao.getLlistbyCode(ccode);
      for(int q=0; q<llists.size(); q++){ %>
        <!-- Tab Content #부서별 -->
        <div class="tab-pane fade" id="<%=ccode%>">
        <section class="section">
          <div class="row">
          <%if(llists.size()==0){
			  out.println("현재 진행중인 강의가 없습니다");
	  		}
          for(int r=0; r<llists.size(); r++){ %>
	  	  <div class="col-lg-4"><div class="card"><div class="card-body">
            <h5 class="card-title">
              <a href="<%=conPath %>/intranet/view/lecture/lectureRegist.jsp?lecno=<%=llists.get(r).getLecno() %>">
                <b style="color: #012970; font-size: 13pt;"><%=llists.get(r).getTitle() %></b>
                <%for(RegisterBean rb : rlists){ if(rb.getLecno()==llists.get(r).getLecno()){ %><i class="bi bi-patch-check-fill"></i><%}} %>
              </a>
            </h5>
            <!-- Slides only carousel -->
            <div id="carouselExampleSlidesOnly" class="carousel slide" data-bs-ride="carousel">
              <div class="carousel-inner">
                <div class="carousel-item active">
                  <a href="<%=conPath %>/intranet/view/lecture/lectureRegist.jsp?lecno=<%=llists.get(r).getLecno() %>">
                    <img src="<%=conPath %>/intranet/view/lectureimg/<%=llists.get(r).getThumbnail() %>" class="d-block w-100" alt="...">
                  </a>
                </div>
              </div>
            </div>
            <!-- End Slides only carousel-->
          </div></div></div>
        <%} %>
          </div>
        </section>
        </div>
        <!-- End Content #부서별 -->
<% }}%>
    
  
  </div>
  </div></div>

  </main><!-- End #main -->

<%@include file="../mainFoot.jsp" %>