<%@page import="work.ProjectBean"%>
<%@page import="work.ProjectDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../../mainHead.jsp" %>

<% 
	String code = request.getParameter("code");
	System.out.println("code: "+code);
	
	String dept = cdao.getDeptbyCode(code);
	
	ArrayList<EmpBean> lists = edao.getEmpbyCode(code);
	System.out.println("lists.size: "+lists.size());
%>

<main id="main" class="main">

    <div class="pagetitle">
      <h1>새 프로젝트</h1>
      <nav>
        <ol class="breadcrumb" style="margin-top: 5px;">
          <li class="breadcrumb-item" style="margin-top: 10px; margin-left: 5px;">
            <a href="projectList.jsp?code=<%=code%>"><%=dept %> 프로젝트 목록 보기</a>
          </li>
        </ol>
      </nav>
    </div><!-- End Page Title -->

   <section class="section profile">
      <div class="row">
        <div class="col-xl-12">

          <div class="card">
            <div class="card-body pt-3">
              <!-- Bordered Tabs -->
              <ul class="nav nav-tabs nav-tabs-bordered">
				<li class="nav-item">
                  <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#project-insert">New Project</button>
                </li>
              </ul>
              <div class="tab-content pt-2">

                <div class="tab-pane fade show active profile-edit pt-3" id="project-insert">
                  <!-- Insert Form -->
                  <form action="projectInsertProc.jsp" method="post">
                  <input class="form-control" type="hidden" name="code" value="<%=code%>">
                    <div class="row mb-3">
                      <label class="col-md-4 col-lg-3 col-form-label">프로젝트명</label>
                      <div class="col-md-8 col-lg-3">
                        <input class="form-control" type="text" name="pname">
                      </div>
                    </div>
                    
                    <div class="row mb-3">
                      <label class="col-md-6 col-lg-3 col-form-label">담당자</label>
                      <div class="col-md-8 col-lg-3">
                        <input class="form-control" type="hidden" name="id" value="<%=sid%>">
                        <input class="form-control" type="text" value="<%=name%>" disabled>
                      </div>
                    </div>
                  
                    <div class="row mb-3">
                      <label class="col-md-4 col-lg-3 col-form-label">업무</label>
                      <div class="col-md-8 col-lg-9">
                        <textarea name="todo" class="form-control" style="height: 100px"></textarea>
                      </div>
                    </div>
                    
 					<div class="row mb-3">
                      <label class="col-md-4 col-lg-3 col-form-label">진행도</label>
                      <div class="col-md-8 col-lg-6">
                        <input type="range" name="progress" class="form-range" min="0" max="100" step="25">
                      </div>
                    </div>
                    

                    <div class="text-center">
                      <button type="submit" class="btn btn-primary">추가하기</button>
                    </div>
                  </form>
                  <!-- End Insert Form -->

                </div>

              </div><!-- End Bordered Tabs -->

            </div>
          </div>

        </div>
      </div>
    </section>
 
  </main>
<!-- End #main -->

<%@include file="../../mainFoot.jsp" %>