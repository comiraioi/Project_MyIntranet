<%@page import="board.NoticeBean"%>
<%@page import="board.NoticeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../mainHead.jsp" %>

  <main id="main" class="main">

    <div class="pagetitle">
      <h1>공지사항</h1>
      <nav>
        <ol class="breadcrumb" style="margin-top: 5px;">
          <li class="breadcrumb-item" style="font-weight: normal;">우리 회사의 다양한 소식들을 알려드립니다.</li>
        </ol>
      </nav>
    </div><!-- End Page Title -->

<%
	NoticeDao ndao = NoticeDao.getInstance();
	ArrayList<NoticeBean> lists = ndao.getAllNotice();
	//System.out.println("전체 공지 갯수: "+lists.size());
%>
  <div class="card"><div class="card-body pt-3">
  <h5 class="card-title" style="margin-left: 5px; margin-bottom: 0;"><b>부서별 공지사항</b></h5>
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
      <!-- 전체 공지 Table -->
      <div class="datatable-container" style="margin:auto; width: 95%;">
      <table class="table datatable datatable-table">
        <thead>
          <tr style="background-color: #e2e3e5">
            <th scope="col" style="width: 15%; padding-left: 5%">부서</th>
            <th scope="col" style="width: 53%;">제목</th>
            <th scope="col" style="width: 15%;">작성자</th>
            <th scope="col" style="width: 17%;">작성일</th>
          </tr>
        </thead>
        <tbody>
     <% if(lists.size()==0){%>
		  <tr><td colspan="4" style="text-align: center;">공지사항이 없습니다.</td></tr>
	 <% }
	    for(NoticeBean nb : lists){
	      String dept = cdao.getDeptbyCode(nb.getCode());
		  EmpBean eb = edao.getUserProfile(nb.getId());
		  String str = nb.getRegdate();
     	  String regdate = str.substring(0, 10);
	 %>
          <tr <%if(nb.getImpor()==1){ %>style="background-color: #fff3cd"<%} %>>
            <td style="padding-left: 5%"><%if(dept.equals("미발령")){%>전체<%}else{%><%=dept %><%} %></td>
            <td><a href="noticeView.jsp?seqno=<%=nb.getSeqno()%>"><b style="color:#012970;"><%=nb.getSubject() %></b></a></td>
            <td><%=eb.getName() %></td>
            <td><%=regdate %></td>
          </tr>
     <% } %>
        </tbody>
      </table>
      </div>
      <!-- End 전체 공지 Table-->
      </div>
    </section>
    </div>
    <!-- End Tab Content #all -->
    
    <%
    String ccode = "";
    for(int p=1; p<clists.size(); p++){
      ccode = clists.get(p).getCode();
      ArrayList<NoticeBean> nlists = ndao.getNoticebyCode(ccode);
      String dept = cdao.getDeptbyCode(ccode);
      for(int q=0; q<lists.size(); q++){ %>
        <!-- Tab Content #부서별 -->
        <div class="tab-pane fade" id="<%=ccode%>">
        <section class="section">
          <div class="row">
            <div class="datatable-container" style="margin:auto; width: 95%;">
          	<table class="table datatable datatable-table">
          	  <thead><tr style="background-color: #eee">
          	    <th scope="col" style="width: 15%; padding-left: 5%">부서</th>
                <th scope="col" style="width: 53%;">제목</th>
                <th scope="col" style="width: 15%;">작성자</th>
                <th scope="col" style="width: 17%;">작성일</th>
          	  </tr></thead>
          	  <tbody>
            <%if(nlists.size()==0){ %>
			  <tr><td colspan="4" style="text-align: center;"><%=dept%> 공지사항이 없습니다.</td></tr>
	  	    <%}
              for(int r=0; r<nlists.size(); r++){ 
            	String ddept = cdao.getDeptbyCode(nlists.get(r).getCode());
           	    EmpBean eb = edao.getUserProfile(nlists.get(r).getId());
        	    String str = nlists.get(r).getRegdate();
        	    String regdate = str.substring(0, 10); %>
                <tr <%if(nlists.get(r).getImpor()==1){ %>style="background-color: #fff3cd"<%} %>>
                  <td style="padding-left: 5%"><%=ddept %></td>
                  <td><a href="noticeView.jsp?seqno=<%=nlists.get(r).getSeqno()%>"><b style="color:#012970;"><%=nlists.get(r).getSubject() %></b></a></td>
                  <td><%=eb.getName() %></td>
                  <td><%=regdate %></td>
                </tr>
            <%} %>
              </tbody>
            </table>
          	</div>
         
    	</div>
    	</section>
    	</div>
        <!-- End Content #부서별 -->
     <% } } %>
    
  
  </div>
  </div></div>

  </main><!-- End #main -->

<%@include file="../mainFoot.jsp" %>