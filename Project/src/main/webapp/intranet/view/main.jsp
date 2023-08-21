<%@page import="board.NoticeBean"%>
<%@page import="board.NoticeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="mainHead.jsp" %>

  <main id="main" class="main">

    <div class="pagetitle">
      <h1>Home</h1>
    </div><!-- End Page Title -->

    <section class="section dashboard">
      <div class="row">

        <!-- Left side columns -->
        <div class="col-lg-12">
          <div class="row">

            <!-- 공지사항 -->
            <div class="col-12">
              <div class="card recent-sales overflow-auto">

                <div class="filter">
                  <a class="icon" href="#" data-bs-toggle="dropdown"><i class="bi bi-three-dots"></i></a>
                  <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
                    <li class="dropdown-header text-start">
                      <h6>Filter</h6>
                    </li>

                    <li><a class="dropdown-item" href="#">Today</a></li>
                    <li><a class="dropdown-item" href="#">This Month</a></li>
                    <li><a class="dropdown-item" href="#">This Year</a></li>
                  </ul>
                </div>

				<%
					NoticeDao ndao = NoticeDao.getInstance();
					ArrayList<NoticeBean> lists = ndao.getAllNotice();
				%>
                <div class="card-body">
                  <h5 class="card-title">Notice <span>| 전체 공지사항</span></h5>

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
            			  <td><a href="<%=conPath %>/intranet/view/board/noticeView.jsp?seqno=<%=nb.getSeqno()%>"><b style="color:#012970;"><%=nb.getSubject() %></b></a></td>
            			  <td><%=eb.getName() %></td>
            			  <td><%=regdate %></td>
          			  </tr>
     			  <% } %>
        			  </tbody>
      			  </table>
      			  </div>
      			  <!-- End 전체 공지 Table-->

                </div>
              </div>
            </div><!-- End 공지사항 -->

          </div>
        </div><!-- End Left side columns -->

      </div>
    </section>

  </main><!-- End #main -->

<%@include file="mainFoot.jsp" %>