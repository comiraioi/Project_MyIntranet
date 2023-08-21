<%@page import="com.CompanyBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.CompanyDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../../mainHead.jsp" %>

<!-- myProfile.jsp -->
<%
	ArrayList<CompanyBean> lists = cdao.getAllDept();
	String dept = cdao.getDeptbyCode(user.getCode());
%>

<main id="main" class="main">

    <div class="pagetitle">
      <h1>Profile</h1>
      <nav>
        <ol class="breadcrumb" style="margin-top: 5px;">
          <li class="breadcrumb-item">User</li>
          <li class="breadcrumb-item">myPage</li>
          <li class="breadcrumb-item active">Profile</li>
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

              <img src="<%=conPath %>/intranet/view/userimg/<%=user.getImage() %>" alt="Profile" class="rounded-circle">
              <h2><%=user.getName() %></h2>
              <h3><%if(user.getPosition()==null){}else{%><%=user.getPosition() %><%} %></h3>
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

				<% if(user.getId().equals("admin")){}else{ %>
                <li class="nav-item">
                  <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-edit">Edit Profile</button>
                </li>
				<%} %>

                <li class="nav-item">
                  <button class="nav-link" data-bs-toggle="tab" data-bs-target="#profile-change-password">Change Password</button>
                </li>
                

              </ul>
              <div class="tab-content pt-2">

                <div class="tab-pane fade show active profile-overview" id="profile-overview">
                  <h5 class="card-title">About</h5>
                  <p class="small fst-italic">안녕하세요. <%if(dept.equals("미발령")){}else{ out.print(dept); } if(user.getPosition()==null){}else{%> <%=user.getPosition() %><%} %> <%=user.getName() %> 입니다.</p>

				<% if(user.getId().equals("admin")){}else{ %>
                  <h5 class="card-title">Profile Details</h5>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label ">이름</div>
                    <div class="col-lg-9 col-md-8"><%=user.getName() %></div>
                  </div>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">부서</div>
                    <div class="col-lg-9 col-md-8"><%=dept %></div>
                  </div>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">직급</div>
                    <div class="col-lg-9 col-md-8"><%if(user.getPosition()==null){}else{%><%=user.getPosition() %><%} %></div>
                  </div>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">생년월일</div>
                    <div class="col-lg-9 col-md-8"><%if(user.getBirth()==null){out.print("");}else{%><%=user.getBirth() %><%} %></div>
                  </div>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">이메일</div>
                    <div class="col-lg-9 col-md-8"><%if(user.getEmail()==null){out.print("");}else{%><%=user.getEmail() %><%} %></div>
                  </div>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">연봉</div>
                    <div class="col-lg-9 col-md-8"><%=user.getSalary() %></div>
                  </div>

                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">계정 정보</div>
                    <div class="col-lg-9 col-md-8"><% if(auth.equals("user")){%>일반<%}else{ %>관리자<%} %></div>
                  </div>
				<%} %>

                </div>

                <div class="tab-pane fade profile-edit pt-3" id="profile-edit">

                  <!-- Profile Edit Form -->
                  <form action="profileUpdateProc.jsp" method="post" enctype="multipart/form-data">
                  	<input type="hidden" name="empno" value="<%=user.getEmpno()%>">
                    <div class="row mb-3">
                      <label for="profileImage" class="col-md-4 col-lg-3 col-form-label">Profile Image</label>
                      <div class="col-md-8 col-lg-9">
                        <img src="<%=conPath %>/intranet/view/userimg/<%=user.getImage() %>" alt="Profile">
                        <div class="pt-2">
                          <input type="text" name="previmage" value="<%=user.getImage()%>" disabled><br>	<!-- 기존 이미지 -->
						  <input type="file" name="image" style="margin-top: 5px;">	<!-- 새로 업로드하는 이미지 -->
                        </div>
                      </div>
                    </div>

					<div class="row mb-3">
                      <label class="col-md-4 col-lg-3 col-form-label">아이디</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="id" type="text" class="form-control" value="<%=sid%>" disabled>
                        <input type="hidden" name="pw" value="<%=user.getPw()%>">
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label class="col-md-4 col-lg-3 col-form-label">이름</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="name" type="text" class="form-control" value="<%=user.getName()%>" required>
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label class="col-md-4 col-lg-3 col-form-label">부서</label>
                      <div class="col-md-8 col-lg-9">
                      	<input type="hidden" name="code" value="<%=user.getCode()%>">
                        <input name="dept" type="text" class="form-control" value="<%=dept%>" disabled>
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label class="col-md-4 col-lg-3 col-form-label">직급</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="position" type="text" class="form-control" value="<%=user.getPosition()%>" disabled>
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label class="col-md-4 col-lg-3 col-form-label">생년월일</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="birth" type="date" class="form-control" value="<%=user.getBirth() %>">
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label class="col-md-4 col-lg-3 col-form-label">이메일</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="email" type="email" class="form-control" value="<%=user.getEmail() %>" onkeydown="keyd()" required>
                        <button type="button" class="btn btn-secondary btn-sm" onClick="emailCheck()" style="margin-top: 5px">중복검사</button>
                        <span class="invalid-feedback" id="msg"></span>
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label class="col-md-4 col-lg-3 col-form-label">연봉</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="salary" type="text" class="form-control" value="<%=user.getSalary() %>" disabled>
                      </div>
                    </div>
                    
                    <div class="row mb-3">
                      <label class="col-md-4 col-lg-3 col-form-label">계정 정보</label>
                      <div class="col-md-8 col-lg-9">
                        <input class="form-check-input" type="radio" name="authority" value="admin" <%if(user.getAuthority().equals("admin")){%>checked<%}%> disabled>
                    	<label class="form-check-label" for="gridRadios1">관리자</label>&nbsp;&nbsp;&nbsp;
                    	<input class="form-check-input" type="radio" name="authority" value="user" <%if(user.getAuthority().equals("user")){%>checked<%}%> disabled>
                    	<label class="form-check-label" for="gridRadios1">일반 사용자</label>
                      </div>
                    </div>

                    <div class="text-center">
                      <button type="submit" class="btn btn-primary">수정하기</button>
                    </div>
                  </form><!-- End Profile Edit Form -->

                </div>


                <div class="tab-pane fade pt-3" id="profile-change-password">
                  <!-- Change Password Form -->
                  <form action="pwChangeProc.jsp" method="post" onSubmit="return pwSave()">

                    <div class="row mb-3">
                      <label class="col-md-4 col-lg-3 col-form-label">현재 비밀번호</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="oripw" type="password" class="form-control" style="width: 200px; display:inline;" onkeydown="pwkeyd()" required>&nbsp;&nbsp;
                        <button type="button" class="btn btn-secondary btn-sm" onClick="pwMatch()">확인</button>&nbsp;
                        <span class="invalid-feedback" id="pwmsg"></span>
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label class="col-md-4 col-lg-3 col-form-label">새로운 비빌번호</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="pw" type="text" class="form-control" style="width: 200px; display:inline;" onBlur="return pwCheck()" required>
                      </div>
                    </div>

                    <div class="row mb-3">
                      <label class="col-md-4 col-lg-3 col-form-label">새로운 비밀번호 확인</label>
                      <div class="col-md-8 col-lg-9">
                        <input name="pwconfirm" type="text" class="form-control" style="width: 200px;" onKeyUp="pw2Check()" required>
                      </div>
                    </div>

                    <div class="text-center">
                      <button type="submit" class="btn btn-primary">비밀번호 변경</button>
                    </div>
                  </form><!-- End Change Password Form -->

                </div>

              </div><!-- End Bordered Tabs -->

            </div>
          </div>

        </div>
      </div>
    </section>

  </main><!-- End #main -->

<%@include file="../../mainFoot.jsp" %>