<%@page import="board.NoticeBean"%>
<%@page import="board.NoticeDao"%>
<%@page import="com.CompanyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../mainHead.jsp" %>

<%
	int seqno = Integer.parseInt(request.getParameter("seqno"));
	System.out.println("seqno: "+seqno);
	
	NoticeDao ndao = NoticeDao.getInstance();
	NoticeBean nb = ndao.getNoticebyNo(seqno);
	
	String dept = cdao.getDeptbyCode(nb.getCode()); 
	EmpBean eb = edao.getUserProfile(nb.getId());
	
	String str = nb.getRegdate();
	String regdate = str.substring(0, 10);
	
	String constr = nb.getContent();
	String[] content = constr.split("\\.");
%>

  <main id="main" class="main">

    <div class="pagetitle">
      <h1>공지사항</h1>
      <nav>
        <ol class="breadcrumb">
          <li class="breadcrumb-item" style="margin-top: 10px; margin-left: 5px;">
            <a href="notice.jsp"><%=dept %></a>
          </li>
        </ol>
      </nav>
    </div><!-- End Page Title -->

    <section class="section">
      <div class="row">

        <div class="col-lg-12">

          <div class="card">
            <div class="card-body">
              <h5 class="card-title"><b><%=nb.getSubject() %></b></h5>
              
              <div>
              	<label class="col-sm-2 col-form-label" style="color: #777;"><b>작성자</b></label>
              	<p style="color: #4154f1; display: inline;"><%=eb.getName() %></p>
              </div>
              <div>
              	<label class="col-sm-2 col-form-label" style="color: #777;"><b>작성일</b></label>
              	<p style="color: #4154f1; display: inline;"><%=regdate %></p>
              </div>
              <div>
              	<label class="col-sm-2 col-form-label" style="color: #777;"><b>내용</b></label>
              	<p style="color: #012970;">
              	<%for(int i=0; i<content.length; i++){ %>
              	  <%=content[i] %><br>
              	<%} %>
              	</p>
              </div>
              
            </div>
          </div>

        </div>
      </div>
    </section>

  </main><!-- End #main -->

<%@include file="../mainFoot.jsp" %>