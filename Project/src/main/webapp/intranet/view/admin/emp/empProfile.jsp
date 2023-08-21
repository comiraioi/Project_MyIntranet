<%@page import="com.CompanyBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.CompanyDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../../mainHead.jsp" %>

<!-- empProfile.jsp -->
<%
	String id = request.getParameter("id");
	System.out.println("id: "+id);
	EmpBean eb = edao.getUserProfile(id);
	
	String dept = cdao.getDeptbyCode(eb.getCode());
%>
  <main id="main" class="main">

    <div class="pagetitle">
      <h1>Profile</h1>
      <nav>
        <ol class="breadcrumb" style="margin-top: 5px;">
          <li class="breadcrumb-item"><a href="empList.jsp">돌아가기</a></li>
        </ol> 
      </nav>
    </div><!-- End Page Title -->

	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
	<script type="text/javascript" src="duplication.js"></script>
	<script type="text/javascript" src="pwCheck.js"></script>
	
    <section class="section profile">
      <div class="row">
        <div class="col-xl-4">

          <div class="card">
            <div class="card-body profile-card pt-4 d-flex flex-column align-items-center">

              <img src="<%=conPath %>/intranet/view/userimg/<%=eb.getImage() %>" alt="Profile" class="rounded-circle">
              <h2><%=eb.getName() %></h2>
              <h3><%if(eb.getPosition()==null){}else{%><%=eb.getPosition() %><%} %></h3>
              <div class="social-links mt-2">
                <a href="https://twitter.com/?lang=ko" class="twitter"><i class="bi bi-twitter"></i></a>
                <a href="https://ko-kr.facebook.com/" class="facebook"><i class="bi bi-facebook"></i></a>
                <a href="https://www.instagram.com" class="instagram"><i class="bi bi-instagram"></i></a>
              </div>
            </div>
          </div>

        </div>

        <div class="col-xl-8">

          <div class="card">
            <div class="card-body pt-3">
              <!-- Bordered Tabs -->
              <ul class="nav nav-tabs nav-tabs-bordered">

                <li class="nav-item">
                  <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#profile-overview">Overview</button>
                </li>
                
                <li class="nav-item">
                  <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-edit">Edit Profile</button>
                </li>

              </ul>
              <div class="tab-content pt-2">

                <div class="tab-pane fade show active profile-overview" id="profile-overview">
                  <h5 class="card-title">About</h5>
                  <p class="small fst-italic">안녕하세요. <%if(dept.equals("미발령")){}else{ out.print(dept); } if(eb.getPosition()==null){}else{%> <%=eb.getPosition() %><%} %> <%=eb.getName() %> 입니다.</p>

                  <h5 class="card-title">Profile Details</h5>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label ">이름</div>
                    <div class="col-lg-9 col-md-8"><%=eb.getName() %></div>
                  </div>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">부서</div>
                    <div class="col-lg-9 col-md-8"><%=dept %></div>
                  </div>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">직급</div>
                    <div class="col-lg-9 col-md-8"><%if(eb.getPosition()==null){}else{%><%=eb.getPosition() %><%} %></div>
                  </div>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">생년월일</div>
                    <div class="col-lg-9 col-md-8"><%if(eb.getBirth()==null){out.print("");}else{%><%=eb.getBirth() %><%} %></div>
                  </div>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">이메일</div>
                    <div class="col-lg-9 col-md-8"><%if(eb.getEmail()==null){out.print("");}else{%><%=eb.getEmail() %><%} %></div>
                  </div>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">연봉</div>
                    <div class="col-lg-9 col-md-8"><%=eb.getSalary() %></div>
                  </div>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">계정 정보</div>
                    <div class="col-lg-9 col-md-8"><% if(eb.getAuthority().equals("user")){%>일반<%}else{ %>관리자<%} %></div>
                  </div>
				
                </div>
                
                <div class="tab-pane fade profile-edit pt-3" id="profile-edit">

                  <!-- Profile Edit Form -->
                  <form action="empUpdateProc.jsp?id=<%=eb.getId() %>" method="post">
                  	<input type="hidden" name="empno" value="<%=eb.getEmpno()%>">
                    
                    <div class="row mb-3">
                      <label class="col-md-4 col-lg-3 col-form-label">직급</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="position" type="text" class="form-control" value="<%=eb.getPosition()%>">
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label class="col-md-4 col-lg-3 col-form-label">연봉</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="salary" type="text" class="form-control" value="<%=eb.getSalary() %>">
                      </div>
                    </div>
                    
                    <div class="row mb-3">
                      <label class="col-md-4 col-lg-3 col-form-label">계정 정보</label>
                      <div class="col-md-8 col-lg-9">
                        <input class="form-check-input" type="radio" name="authority" value="admin" <%if(eb.getAuthority().equals("admin")){%>checked<%}%>>
                    	<label class="form-check-label" for="gridRadios1">관리자</label>&nbsp;&nbsp;&nbsp;
                    	<input class="form-check-input" type="radio" name="authority" value="user" <%if(eb.getAuthority().equals("user")){%>checked<%}%>>
                    	<label class="form-check-label" for="gridRadios1">일반 사용자</label>
                      </div>
                    </div>

                    <div class="text-center">
                      <button type="submit" class="btn btn-primary">수정하기</button>
                    </div>
                  </form><!-- End Profile Edit Form -->

                </div>

              </div><!-- End Bordered Tabs -->

            </div>
          </div>

        </div>
      </div>
    </section>

  </main><!-- End #main -->

<%@include file="../../mainFoot.jsp" %>