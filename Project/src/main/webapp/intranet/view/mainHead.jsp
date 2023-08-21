<%@page import="com.CompanyBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.CompanyDao"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.commons.collections.bag.SynchronizedSortedBag"%>
<%@page import="com.EmpBean"%>
<%@page import="com.EmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- mainHead.jsp -->
<%
	request.setCharacterEncoding("UTF-8");
	String conPath = request.getContextPath();

	/* loginProc.jsp (sid 세션설정) */
	String sid = (String)session.getAttribute("sid");
	
	/* 세션 설정한 id로 사원 정보 가져오기 */
	EmpDao edao = EmpDao.getInstance();
	EmpBean user = edao.getUserProfile(sid); 
	String name = user.getName();
	String auth = user.getAuthority();
	
	System.out.println(sid+"/"+name+"/"+auth);
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	//최근 접속 시간
	Date curdate = new Date();
	curdate.setTime(session.getCreationTime());
	String curlog = sdf.format(curdate);
	//마지막 접속 시간
	Date lastdate = new Date();
	lastdate.setTime(session.getLastAccessedTime());
	String lastlog = sdf.format(lastdate);
	
	int cnt = edao.updateLog(curlog,lastlog,sid);
	if(cnt==1){
		System.out.println("로그 업데이트 성공");
	}else{
		System.out.println("로그 업데이트 실패");
	}
	
	CompanyDao cdao = CompanyDao.getInstance();
	ArrayList<CompanyBean> clists = cdao.getAllDept();
%>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Dashboard - NiceAdmin Bootstrap Template</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="<%=conPath %>/intranet/view/assets/img/favicon.png" rel="icon">
  <link href="<%=conPath %>/intranet/view/assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.gstatic.com" rel="preconnect">
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="<%=conPath %>/intranet/view/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="<%=conPath %>/intranet/view/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="<%=conPath %>/intranet/view/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="<%=conPath %>/intranet/view/assets/vendor/quill/quill.snow.css" rel="stylesheet">
  <link href="<%=conPath %>/intranet/view/assets/vendor/quill/quill.bubble.css" rel="stylesheet">
  <link href="<%=conPath %>/intranet/view/assets/vendor/remixicon/remixicon.css" rel="stylesheet">
  <link href="<%=conPath %>/intranet/view/assets/vendor/simple-datatables/style.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="<%=conPath %>/intranet/view/assets/css/style.css" rel="stylesheet">

  <!-- =======================================================
  * Template Name: NiceAdmin
  * Updated: Mar 09 2023 with Bootstrap v5.2.3
  * Template URL: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
</head>

<body>
  <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/intranet/view/assets/js/main.js"></script>
  <script type="text/javascript" src="searchEmp.js"></script>
  
  <!-- ======= Header ======= -->
  <header id="header" class="header fixed-top d-flex align-items-center">

    <div class="d-flex align-items-center justify-content-between">
      <a href="<%=conPath %>/intranet/view/main.jsp" class="logo d-flex align-items-center">
        <img src="<%=conPath %>/intranet/view/assets/img/logo.png" alt="">&nbsp;
        <span class="d-none d-lg-block">my Intranet</span>
      </a>
      <i class="bi bi-list toggle-sidebar-btn"></i>
    </div><!-- End Logo -->

    <nav class="header-nav ms-auto">
      <ul class="d-flex align-items-center">
		
		<!-- 상단 알림창 -->
        <li class="nav-item dropdown">
          <a class="nav-link nav-icon" href="#" data-bs-toggle="dropdown">
            <i class="bi bi-bell"></i>
            <span class="badge bg-primary badge-number">4</span>
          </a><!-- End Notification Icon -->
          <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow notifications">
            <li class="dropdown-header">
              You have 4 new notifications
              <a href="#"><span class="badge rounded-pill bg-primary p-2 ms-2">View all</span></a>
            </li>
            <li><hr class="dropdown-divider"></li>
            <li class="notification-item">
              <i class="bi bi-exclamation-circle text-warning"></i>
              <div><h4>경고</h4><p>경고 알림</p><p>30 min. ago</p></div>
            </li>
            <li><hr class="dropdown-divider"></li>
            <li class="notification-item">
              <i class="bi bi-x-circle text-danger"></i>
              <div><h4>위험</h4><p>위험 알림</p><p>1 hr. ago</p></div>
            </li>
            <li><hr class="dropdown-divider"></li>
            <li class="notification-item">
              <i class="bi bi-check-circle text-success"></i>
              <div><h4>성공</h4><p>성공 알림</p><p>2 hrs. ago</p></div>
            </li>
            <li><hr class="dropdown-divider"></li>
            <li class="notification-item">
              <i class="bi bi-info-circle text-primary"></i>
              <div><h4>인포</h4><p>인포 알림</p><p>4 hrs. ago</p></div>
            </li>
            <li><hr class="dropdown-divider"></li>
            <li class="dropdown-footer"><a href="#">Show all notifications</a></li>
          </ul><!-- End Notification Dropdown Items -->
		</li>
		<!-- End 상단 알림창 -->

		<!-- 상단 채팅창 -->
        <li class="nav-item dropdown">
          <a class="nav-link nav-icon" href="#" data-bs-toggle="dropdown" area-expended="true">
            <i class="bi bi-chat-left-text"></i>
            <span class="badge bg-success badge-number">1</span>
          </a><!-- End Messages Icon -->
          <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow messages" style="width:350px">
            <li class="dropdown-header">
              <b style="color: #012970; float: left; font-size: 13pt;">사내 메신저</b>
              <a href="#"><span class="badge rounded-pill bg-primary p-2 ms-2" style="float: right;">새 채팅</span></a>
            </li><br>
            <li><hr class="dropdown-divider"></li><br>
            <li class="search-bar">
              <form class="search-form d-flex align-items-center" method="POST" action="#">
                <input type="text" name="chatkey" placeholder="사원 이름 검색" title="Enter search keyword">
                <button type="button" title="Search" onClick="searchCheck(form)">
                  <i class="bi bi-search"></i>
                </button>
              </form>
            </li><br>
            <li><hr class="dropdown-divider"></li>
        <%
        	String chatkey = null;
            chatkey = request.getParameter("chatkey");
            System.out.println("chatkey: "+chatkey);
        	ArrayList<EmpBean> chatlists = edao.searchEmpChat(chatkey);
            if(chatkey != null && chatlists.size()==0){ %>
              <li class="message-item"><div style="text-align:center;">검색결과가 없습니다</div></li>
              <li><hr class="dropdown-divider"></li>
         <%   chatkey = null;
            }
            if(chatkey != null && chatlists != null){ 
              for(EmpBean eb : chatlists){%>
                <li class="message-item">
                 <a href="#">
                  <img src="<%=conPath %>/intranet/view/userimg/<%=eb.getImage() %>" alt="" class="rounded-circle">
                  <div>
                    <h4><%=eb.getName() %></h4>
                    <p><%=eb.getEmail() %></p>
                  </div>
                 </a>
                </li>
                <li><hr class="dropdown-divider"></li>
           <%}
            chatkey = null;
          }%>
            <li class="dropdown-footer">
              <a href="#">Show all messages</a>
            </li>
          </ul>
        </li>
        <!-- End 상단 채팅창 -->

            

        <li class="nav-item dropdown pe-3">

          <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown">
            <img src="<%=conPath %>/intranet/view/userimg/<%=user.getImage() %>" alt="Profile" class="rounded-circle">
            <span class="d-none d-md-block dropdown-toggle ps-2"><%=name %>님</span>
          </a><!-- End Profile Iamge Icon -->

          <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
            <li class="dropdown-header">
              <h6><%=name %></h6>
              <span><%if(user.getPosition()==null){}else{%><%=user.getPosition() %><%} %></span>
            </li>
            <li>
              <hr class="dropdown-divider">
            </li>

            <li>
              <a class="dropdown-item d-flex align-items-center" href="<%=conPath %>/intranet/view/user/profile/myProfile.jsp">
                <i class="bi bi-person"></i>
                <span>My Profile</span>
              </a>
            </li>
            <li>
              <hr class="dropdown-divider">
            </li>

            <li>
              <a class="dropdown-item d-flex align-items-center" href="users-profile.html">
                <i class="bi bi-gear"></i>
                <span>Account Settings</span>
              </a>
            </li>
            <li>
              <hr class="dropdown-divider">
            </li>

            <li>
              <a class="dropdown-item d-flex align-items-center" href="pages-faq.html">
                <i class="bi bi-question-circle"></i>
                <span>Need Help?</span>
              </a>
            </li>
            <li>
              <hr class="dropdown-divider">
            </li>

            <li>
              <a class="dropdown-item d-flex align-items-center" href="<%=conPath %>/intranet/account/logoutProc.jsp">
                <i class="bi bi-box-arrow-right"></i>
                <span>Logout</span>
              </a>
            </li>

          </ul><!-- End Profile Dropdown Items -->
        </li><!-- End Profile Nav -->

      </ul>
    </nav><!-- End Icons Navigation -->

  </header><!-- End Header -->

  <!-- ======= Sidebar ======= -->
  <aside id="sidebar" class="sidebar">

    <ul class="sidebar-nav" id="sidebar-nav">

      <li class="nav-item">
        <a class="nav-link " href="<%=conPath%>/intranet/view/main.jsp">
          <i class="bi bi-house-door-fill"></i>
          <span>Home</span>
        </a>
      </li><!-- End Home Nav -->
      
      <li class="nav-item">
        <a class="nav-link collapsed" href="<%=conPath%>/intranet/view/board/notice.jsp">
          <i class="bi bi-megaphone"></i>
          <span>공지사항</span>
        </a>
      </li><!-- End 공지사항 Nav -->
      
<!-- 관리자 계정만 접근 가능 -->
<% if(auth.equals("admin")){ %>
      <li class="nav-heading">Admin</li>
      
      <li class="nav-item">
        <a class="nav-link collapsed" href="<%=conPath %>/intranet/view/admin/dept/deptList.jsp">
          <i class="bi bi-diagram-3"></i>
          <span>조직 관리</span>
        </a>
      </li><!-- End 조직 관리 Page Nav -->
      
      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#manage-nav" data-bs-toggle="collapse" href="#">
          <i class="bi bi-people"></i><span>사원 관리</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="manage-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
          <li>
            <a href="<%=conPath %>/intranet/view/admin/emp/empList.jsp">
              <i class="bi bi-list"></i><span>사원 목록</span>
            </a>
          </li>
          <li>
            <a href="<%=conPath %>/intranet/view/admin/emp/eduChart.jsp">
              <i class="bi bi-list"></i><span>사내 교육 참여도</span>
            </a>
          </li>
        </ul>
      </li><!-- End Manage Nav -->
<% } %>
      <!-- End Admin -->
      
      <!-- 모든 사용자 접근 가능 -->
      <li class="nav-heading">User</li>
      
      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#mypage-nav" data-bs-toggle="collapse" href="#">
          <i class="bi bi-person-circle"></i><span>마이페이지</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="mypage-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
          <li>
            <a href="<%=conPath %>/intranet/view/user/profile/myProfile.jsp">
              <i class="bi bi-list"></i><span>프로필</span>
            </a>
          </li>
          
          <li>
            <a href="<%=conPath %>/intranet/view/user/project/myProject.jsp">
              <i class="bi bi-list"></i><span>담당 프로젝트</span>
            </a>
          </li>
        </ul>
      </li><!-- End Mypage Nav -->
      
      <li class="nav-item">
        <a class="nav-link collapsed" href="<%=conPath %>/intranet/view/user/attd/attdRecord.jsp">
          <i class="bi bi-journal-bookmark-fill"></i>
          <span>근태 관리</span>
        </a>
      </li>
      <!-- End Attd Nav -->
      
      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#edu-nav" data-bs-toggle="collapse" href="#">
          <i class="bi bi-book"></i><span>사내 교육</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="edu-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
          <li>
            <a href="<%=conPath %>/intranet/view/lecture/lectureList.jsp">
              <i class="bi bi-list"></i><span>수강 신청</span>
            </a>
          </li>
          <li>
            <a href="<%=conPath %>/intranet/view/lecture/registerList.jsp">
              <i class="bi bi-list"></i><span>수강 이력</span>
            </a>
          </li>
        </ul>
      </li><!-- End Edu Nav -->
      <!-- End User -->
      
      <li class="nav-heading">Project</li>
      
      <li class="nav-item">
        <a class="nav-link collapsed" data-bs-target="#department-nav" data-bs-toggle="collapse" href="#">
          <i class="bi bi-folder-fill"></i><span>프로젝트</span><i class="bi bi-chevron-down ms-auto"></i>
        </a>
        <ul id="department-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
          <li>
            <a href="<%=conPath %>/intranet/view/user/project/allProject.jsp">
              <i class="bi bi-list"></i><span>전체 보기</span>
            </a>
          </li>
        <%for(int i=1; i<clists.size(); i++){ %>
          <li>
            <a href="<%=conPath %>/intranet/view/user/project/projectList.jsp?code=<%=clists.get(i).getCode()%>">
              <i class="bi bi-list"></i><span><%=clists.get(i).getDept() %></span>
            </a>
          </li>
        <%} %>
        </ul>
      </li><!-- End Department Nav -->
      <!-- End Project -->

      <li class="nav-heading">ETC</li>

      <li class="nav-item">
        <a class="nav-link collapsed" href="<%=conPath %>/intranet/account/logoutProc.jsp">
          <i class="bi bi-box-arrow-in-right"></i>
          <span>Logout</span>
        </a>
      </li><!-- End Logout Page Nav -->


    </ul>

  </aside><!-- End Sidebar-->
 