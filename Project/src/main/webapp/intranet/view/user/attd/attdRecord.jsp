<%@page import="attd.DayoffBean"%>
<%@page import="attd.DayoffDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.CompanyBean"%>
<%@page import="com.CompanyDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="attd.OverBean"%>
<%@page import="attd.OverDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript">
	window.onload = function() {
		today = new Date();
		today = today.toISOString().slice(0, 10);
		
		odate = document.getElementById("odate");
		odate.value = today;
		odate.max = today;
		
		
		fdate = document.getElementById("fdate");
		fdate.value = today;
		fdate.min = today;
	}
</script>

<%@include file="../../mainHead.jsp" %>

<!-- attdRecord.jsp -->
<%
	ArrayList<CompanyBean> lists = cdao.getAllDept();
	String dept = cdao.getDeptbyCode(user.getCode());
	
	OverDao odao = OverDao.getInstance();
	OverBean obRec = odao.getRecentOverbyId(sid);
	ArrayList<OverBean> olists = odao.getallOverbyId(sid);
	
	DayoffDao ddao = DayoffDao.getInstance();
	DayoffBean dbRec = ddao.getRecentOffbyId(sid);
	ArrayList<DayoffBean> dlists = ddao.getallOffbyId(sid);
	
	SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy");
    Date now = new Date();
    String year = sdf1.format(now);
%>
  <main id="main" class="main">

    <div class="pagetitle">
      <h1>근태관리</h1>
      <nav>
        <ol class="breadcrumb" style="margin-top: 5px;">
          <li class="breadcrumb-item">User</li>
          <li class="breadcrumb-item active">근태관리</li>
        </ol>
      </nav>
    </div><!-- End Page Title -->

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
                  <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#attd-overview">Overview</button>
                </li>
				<% if(user.getId().equals("admin")){}else{ %>
                <li class="nav-item">
                  <button class="nav-link" data-bs-toggle="tab" data-bs-target="#overtime-record">초과근무</button>
                </li>
                <li class="nav-item">
                  <button class="nav-link" data-bs-toggle="tab" data-bs-target="#dayoff-record">연차사용</button>
                </li>
                <%} %>
              </ul>
              <div class="tab-content pt-2">
                <div class="tab-pane fade show active profile-overview" id="attd-overview">
                  <h5 class="card-title">Log</h5>
                  <div class="row">
                    <div class="col-lg-3 col-md-4 label ">최근 로그인 시간</div>
                    <div class="col-lg-9 col-md-8"><%=curlog %></div>
                  </div>
                  <div class="row">
                    <div class="col-lg-3 col-md-4 label ">마지막 접속 시간</div>
                    <div class="col-lg-9 col-md-8"><%=lastlog %></div>
                  </div>
				<% if(user.getId().equals("admin")){}else{ %>
                  <h5 class="card-title">Record</h5>
                  <div class="row">
                    <div class="col-lg-3 col-md-4 label ">초과근무</div>
                    <div class="col-lg-9 col-md-8">총 <%=obRec.getCumul() %>시간</div>
                  </div>
                  <div class="row">
                    <div class="col-lg-3 col-md-4 label">잔여 연차</div>
                    <div class="col-lg-9 col-md-8">
                      <%=dbRec.getRemain() %>일
                    </div>
                  </div>
                <%} %>
                </div>

				<!-- Overtime Form -->
                <div class="tab-pane fade profile-edit pt-3" id="overtime-record">
                  <form action="overRecordProc.jsp" method="post">
 					<div class="row mb-3">
                      <label class="col-md-4 col-lg-3 col-form-label">초과 근무 날짜</label>
                      <div class="col-md-8 col-lg-3">
                        <input name="odate" id="odate" type="date" class="form-control" value="" min="<%=year%>-01-01" max="">
                      </div>
                    </div>
 					<div class="row mb-3">
                      <label class="col-md-4 col-lg-3 col-form-label">초과 근무 시간</label>
                      <div class="col-md-8 col-lg-6">
                        <select class="form-select" name="hour" onChange="">
                          <option value="" hidden>초과근무 시간을 선택하세요</option>
                          <%for(int i=1; i<=6; i++){ %>
                          <option value="<%=i%>"><%=i %>시간</option>
                          <%} %>
                        </select>
                      </div>
                    </div>
                    <div class="row mb-3">
                      <label class="col-md-4 col-lg-3 col-form-label">사유</label>
                      <div class="col-md-8 col-lg-9">
                        <textarea name="otst" class="form-control" style="height: 100px"></textarea>
                      </div>
                    </div>
					<input type="hidden" name="cumul" value="<%=obRec.getCumul()%>">
                    <div class="text-center">
                      <button type="submit" class="btn btn-primary">등록하기</button>
                    </div>
                  </form>
                </div>
                <!-- End Overtime Form -->

                <div class="tab-pane fade profile-edit pt-3" id="dayoff-record">
                  <!-- DayOff Form -->
                  <form action="dayoffRecordProc.jsp" method="post">
                    <div class="row mb-3">
                      <label class="col-md-4 col-lg-3 col-form-label">잔여 연차일</label>
                      <div class="col-md-8 col-lg-3">
                        <input class="form-control" type="hidden" name="remain" value="<%=dbRec.getRemain() %>">
                        <p style="margin-top:5px;"><b><%=dbRec.getRemain() %></b>일</p>
                      </div>
                    </div>
                    <div class="row mb-3">
                      <label class="col-md-4 col-lg-3 col-form-label">연차 시작 날짜</label>
                      <div class="col-md-8 col-lg-3">
                        <input name="fdate" id="fdate" type="date" class="form-control" value="" min="" max="<%=year%>-12-31">
                      </div>
                    </div>
 					<div class="row mb-3">
                      <label class="col-md-4 col-lg-3 col-form-label">연차 사용</label>
                      <div class="col-md-8 col-lg-6">
                        <select class="form-select" name="off">
                          <option value="" hidden>사용할 연차일수를 선택하세요</option>
                          <%for(double j=0.5; j<=3.0; j+=0.5){ %>
                          <option value="<%=j%>"><%=j %>일</option>
                          <%} %>
                        </select>
                      </div>
                    </div>
                    <div class="row mb-3">
                      <label class="col-md-4 col-lg-3 col-form-label">사유</label>
                      <div class="col-md-8 col-lg-9">
                        <textarea name="dost" class="form-control" style="height: 100px"></textarea>
                      </div>
                    </div>
                    <div class="text-center">
                      <button type="submit" class="btn btn-primary">등록하기</button>
                    </div>
                  </form><!-- End DayOff Form -->
                </div>
              </div><!-- End Bordered Tabs -->
            </div>
          </div>
        </div>

		<!-- 초과근무 기록 Table -->
        <div class="col-lg-12">
          <div class="card">
            <div class="card-body">
              <h5 class="card-title"><b>초과 근무</b></h5>
              <p><%=name %>님의 <%=year %>년 초과근무 기록입니다.</p>
                <div class="datable-top">
                </div>
                <div class="datatable-container">
                <table class="table datatable datatable-table">
                  <thead>
                    <tr style="background-color: #eceefe">
                      <th scope="col" style="width: 25%; padding-left: 5%">날짜</th>
                      <th scope="col" style="width: 20%;">초과근무</th>
                      <th scope="col" style="width: 35%;">사유</th>
                      <th scope="col" style="width: 20%;">누적 시간</th>
                    </tr>
                  </thead>
                  <tbody id="listall">
                    <% if(olists.size() == 1){ %>
                	    <tr><td colspan="3" style="text-align:center">초과근무 기록이 없습니다</td></tr>
                    <% }
                      for(OverBean ob : olists){
                    	String str = ob.getOdate();
                   		String odate = str.substring(0, 10);
					 %>
                       <tr>
                         <td style="padding-left: 5%"><%=odate %></td>
                         <td><%=ob.getHour() %>시간</td>
                         <td><%=ob.getOtst()%></td>
                         <td><%=ob.getCumul()%>시간</td>
                       </tr>
                    <%}%>
                  </tbody>
                </table>
                </div>
              <div class="datatable-bottom" style="float:right;">
			  </div>
            </div>
          </div>
        </div>
        <!-- End 초과근무 기록 Table -->
        
		<!-- 연차 기록 Table -->
        <div class="col-lg-12">
          <div class="card">
            <div class="card-body">
              <h5 class="card-title"><b>연차</b></h5>
              <p><%=name %>님의 <%=year %>년 연차 사용 기록입니다.</p>
                <div class="datable-top">
                </div>
                <div class="datatable-container">
                <table class="table datatable datatable-table">
                  <thead>
                    <tr style="background-color: #eceefe">
                      <th scope="col" style="width: 25%; padding-left: 5%">날짜</th>
                      <th scope="col" style="width: 20%;">연차일수</th>
                      <th scope="col" style="width: 35%;">사유</th>
                      <th scope="col" style="width: 20%;">잔여 연차일</th>
                    </tr>
                  </thead>
                  <tbody id="listall">
                    <% if(dlists.size() == 0){ %>
                	    <tr><td colspan="4" style="text-align:center">연차 사용 기록이 없습니다</td></tr>
                    <% }
                      for(DayoffBean db : dlists){
                    	String str = db.getFdate();
                   		String fdate = str.substring(0, 10);
					 %>
                       <tr>
                         <td style="padding-left: 5%"><%=fdate %></td>
                         <td><%=db.getOff() %>일</td>
                         <td><%=db.getDost()%></td>
                         <td><%=db.getRemain()%>일</td>
                       </tr>
                    <%}%>
                  </tbody>
                </table>
                </div>
              <div class="datatable-bottom" style="float:right;">
			  </div>
            </div>
          </div>
        </div>
        <!-- End 연차 기록 Table -->
        
      </div>
    </section>
 
  </main><!-- End #main -->

<%@include file="../../mainFoot.jsp" %>