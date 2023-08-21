<%@page import="work.ProjectBean"%>
<%@page import="work.ProjectDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../../mainHead.jsp" %>

<%
	ProjectDao pdao = ProjectDao.getInstance();
	ArrayList<ProjectBean> plists = pdao.getUserProject(sid);
	System.out.println("plists.size(): "+plists.size());
	
	String dept = cdao.getDeptbyCode(user.getCode());
%>

  <main id="main" class="main">

  <div class="pagetitle">
      <h1><%=name %>님의 프로젝트</h1>
      <nav>
        <ol class="breadcrumb" style="margin-top: 5px;">
          <li class="breadcrumb-item active"><a href="projectList.jsp?code=<%=user.getCode()%>"><%=dept %> 프로젝트 목록</a></li>
        </ol>
      </nav>
   </div><!-- End Page Title -->

  <div class="card"><div class="card-body pt-3">
  <h5 class="card-title" style="margin-left: 5px; margin-bottom: 0;"><b>진행중인 프로젝트</b></h5>
  <button type="button" class="btn btn-primary" onClick="location.href='insertProject.jsp?code=<%=user.getCode() %>'"><i class="bi bi-folder-plus"></i>&nbsp;&nbsp;프로젝트 추가</button>
  <br><br>
    <section class="section">
      <div class="row">
      <%for(ProjectBean pb : plists){ %>
        <div class="col-lg-6">
          <div class="card">
            <div class="card-body">
              <h5 class="card-title">
                <a href="viewProject.jsp?prono=<%=pb.getProno() %>">
                  <b><%=pb.getPname() %></b>
                </a>
              </h5>
              <%
              	EmpBean manager = edao.getUserProfile(pb.getId());
              %>
              <div style="margin-bottom: 10px">
              	<label class="col-sm-2 col-form-label"><b>담당자</b></label>
              	<p style="display: inline;"><%=manager.getName() %></p>
              </div>
              <div>
                <b>진행도</b>
                <div class="progress" style="margin-top: 5px;">
                  <%if(pb.getProgress()==0){ %>
                  <div class="progress-bar" role="progressbar" style="width: 0%" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                  <%}else{ %>
                  <div class="progress-bar" role="progressbar" style="width: <%=pb.getProgress()%>%" aria-valuenow="<%=pb.getProgress()%>" aria-valuemin="0" aria-valuemax="100"><%=pb.getProgress()%>%</div>
                  <%} %>
                </div>
              </div>
            </div>
          </div>
        </div>
      <%} %>
        
      </div>
    </section>
  </div></div>
  </main><!-- End #main -->

<%@include file="../../mainFoot.jsp" %>