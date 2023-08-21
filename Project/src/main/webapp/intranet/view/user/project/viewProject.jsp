<%@page import="work.ProjectBean"%>
<%@page import="work.ProjectDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../../mainHead.jsp" %>

<%
	int prono = Integer.parseInt(request.getParameter("prono"));
	System.out.println("prono: "+prono);
	
	ProjectDao pdao = ProjectDao.getInstance();
	ProjectBean pb = pdao.getProjectbyNo(prono);
	
	EmpBean manager = edao.getUserProfile(pb.getId());
	
	String dept = cdao.getDeptbyCode(pb.getCode());
%>

<main id="main" class="main">

    <div class="pagetitle">
      <h1>프로젝트 상세보기</h1>
      <nav>
        <ol class="breadcrumb" style="margin-top: 5px;">
          <li class="breadcrumb-item" style="margin-top: 10px; margin-left: 5px;">
            <a href="projectList.jsp?code=<%=pb.getCode()%>"><%=dept %> 프로젝트 목록</a>
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
                  <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#project-todo">Content</button>
                </li>

				<% if(user.getId().equals(pb.getId())){ %>
                <li class="nav-item">
                  <button class="nav-link" data-bs-toggle="tab" data-bs-target="#project-edit">Edit</button>
                </li>
				<%} %>

              </ul>
              <div class="tab-content pt-2">

                <div class="tab-pane fade show active profile-overview" id="project-todo">
                  <h5 class="card-title"><b><%=pb.getPname() %></b></h5>
                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">담당자</div>
                    <div class="col-lg-9 col-md-8"><%=manager.getName() %></div>
                  </div>
                  <div class="row">
                    <div class="col-lg-3 col-md-4 label ">업무</div>
                    <div class="col-lg-9 col-md-8">
                    <%
                      String tdlist = pb.getTodo();
                  	  String todo[] = tdlist.split("-");
                  	  for(int i=1; i<todo.length; i++){
                    %>
                      <p style="margin-bottom: 10px;"><i class="bi bi-check"></i>&nbsp;<b><%=todo[i] %></b></p>
                    <%} %>
                    </div>
                  </div>
                  <div class="row">
                    <div class="col-lg-3 col-md-4 label ">진행도</div>
                    <div class="col-lg-9 col-md-8">
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

                <div class="tab-pane fade profile-edit pt-3" id="project-edit">
                  <!-- Edit Form -->
                  <form action="projectUpdateProc.jsp?prono=<%=prono %>" method="post">
                    <div class="row mb-3">
                      <label class="col-md-4 col-lg-3 col-form-label">프로젝트명</label>
                      <div class="col-md-8 col-lg-3">
                        <input class="form-control" type="text" name="pname" value="<%=pb.getPname() %>">
                      </div>
                    </div>
                    
                    <div class="row mb-3">
                      <label class="col-md-4 col-lg-3 col-form-label">담당자</label>
                      <div class="col-md-8 col-lg-4">
                        <select class="form-select" name="id">
                      	  <option selected="" hidden><%=dept %> 사원명을 선택하세요</option>
                      	  <% ArrayList<EmpBean> lists = edao.getEmpbyCode(pb.getCode());
                      	     for(EmpBean eb : lists){ %>
                          	   <option value="<%=eb.getId() %>" <%if(eb.getId().equals(sid)){ %>selected<%} %>>
                          	     <%=eb.getName() %>
                          	   </option>
                           <%} %>
                        </select>
                      </div>
                    </div>
                  
                    <div class="row mb-3">
                      <label class="col-md-4 col-lg-3 col-form-label">업무</label>
                      <div class="col-md-8 col-lg-9">
                        <textarea name="todo" class="form-control" style="height: 100px"><%=pb.getTodo() %></textarea>
                      </div>
                    </div>
                    
 					<div class="row mb-3">
                      <label class="col-md-4 col-lg-3 col-form-label">진행도</label>
                      <div class="col-md-8 col-lg-6">
                      	<label><%=pb.getProgress() %>%</label>
                        <input type="range" name="progress" class="form-range" min="0" max="100" step="25" value="<%=pb.getProgress()%>">
                      </div>
                    </div>
                    

                    <div class="text-center">
                      <button type="submit" class="btn btn-primary">수정하기</button>
                    </div>
                  </form>
                  <!-- End Edit Form -->

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