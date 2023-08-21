<%@page import="com.CompanyBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.CompanyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String conPath = request.getContextPath(); %>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Pages / Register - NiceAdmin Bootstrap Template</title>
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

  <main>
    <div class="container">

      <section class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
        <div class="container">
          <div class="row justify-content-center">
            <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">

              <div class="d-flex justify-content-center py-4">
                <a href="<%=conPath %>/intranet/view/main.jsp" class="logo d-flex align-items-center w-auto">
                  <img src="<%=conPath %>/intranet/view/assets/img/logo.png" alt="">
                  <span class="d-none d-lg-block">NiceAdmin</span>
                </a>
              </div><!-- End Logo -->

              <div class="card mb-3">

                <div class="card-body">

                  <div class="pt-4 pb-2">
                    <h5 class="card-title text-center pb-0 fs-4">Create an Account</h5>
                    <p class="text-center small">Enter your personal details to create account</p>
                  </div>

				  <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
				  <script type="text/javascript" src="<%=request.getContextPath()%>/intranet/account/registerVal.js"></script>
                  <form class="row g-3 needs-validation" action="registerProc.jsp" method="post" onSubmit="return writeSave()">
                    <div class="col-12">
                      <label for="yourName" class="form-label">Your Name</label>
                      <input type="text" name="name" class="form-control" id="yourName" required>
                    </div>
					
					<div class="col-12">
					  <label for="yourDept" class="form-label">Your Dept</label>
					  <%
					  	CompanyDao cdao = CompanyDao.getInstance(); 
						ArrayList<CompanyBean> lists = cdao.getAllDept();
					  %>
                      <select class="form-select" style="padding: 10px;" name="code" id="code" required>
                      	<option value="" selected disabled>부서를 선택하세요</option>
                      	<% if(lists.size() == 0){ %>
                    	    <option value="">부서가 존재하지 않습니다</option>
                        <% } 
                           for(CompanyBean cb : lists){ %>
                        	<option value="<%=cb.getCode()%>"><%=cb.getDept() %></option>
                        <% } %>
                      </select>
                     </div>
					
                    <div class="col-12">
                      <label for="yourEmail" class="form-label">
                      	Your Email &nbsp;
                      	<span class="invalid-feedback" id="msg"></span> &nbsp;
                        <input class="btn btn-primary" type="button" value="중복체크" onClick="emailCheck()"/>
                      </label>
                      <input type="email" name="email" class="form-control" id="yourEmail" onkeydown="keyd()" required>
                    </div>

                    <div class="col-12">
                      <label for="yourPassword" class="form-label">Password &nbsp;<font size=2px;>(영문,숫자,특수문자 포함 7~15자)</font></label>
                      <input type="password" name="pw" class="form-control" id="yourPassword" onBlur="return pwCheck()" required>
                    </div>
                    
                    <div class="col-12">
                      <label for="yourPassword" class="form-label">Password Confirm &nbsp;</label>
                      <input type="password" name="pwconfirm" class="form-control" onKeyUp="pw2Check()" required>
                    </div>

                    <div class="col-12">
                      <div class="form-check">
                        <input class="form-check-input" name="terms" type="checkbox" value="" id="acceptTerms" required>
                        <label class="form-check-label" for="acceptTerms">I agree and accept the 
                        	<a href="<%=conPath %>/intranet/policy/service.jsp">terms and conditions</a>
                        </label>
                      </div>
                    </div>
                    <div class="col-12">
                      <button class="btn btn-primary w-100" type="submit">Create Account</button>
                    </div>
                    <div class="col-12">
                      <p class="small mb-0">이미 계정이 있으신가요? &nbsp; <a href="login.jsp">로그인</a></p>
                    </div>
                  </form>

                </div>
              </div>

              <div class="credits">
                <!-- All the links in the footer should remain intact. -->
                <!-- You can delete the links only if you purchased the pro version. -->
                <!-- Licensing information: https://bootstrapmade.com/license/ -->
                <!-- Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/ -->
                Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
              </div>

            </div>
          </div>
        </div>

      </section>

    </div>
  </main><!-- End #main -->

  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <!-- Vendor JS Files -->
  <script src="<%=conPath %>/intranet/view/assets/vendor/apexcharts/apexcharts.min.js"></script>
  <script src="<%=conPath %>/intranet/view/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="<%=conPath %>/intranet/view/assets/vendor/chart.js/chart.umd.js"></script>
  <script src="<%=conPath %>/intranet/view/assets/vendor/echarts/echarts.min.js"></script>
  <script src="<%=conPath %>/intranet/view/assets/vendor/quill/quill.min.js"></script>
  <script src="<%=conPath %>/intranet/view/assets/vendor/simple-datatables/simple-datatables.js"></script>
  <script src="<%=conPath %>/intranet/view/assets/vendor/tinymce/tinymce.min.js"></script>
  <script src="<%=conPath %>/intranet/view/assets/vendor/php-email-form/validate.js"></script>

  <!-- Template Main JS File -->
  <script src="<%=conPath %>/intranet/view/assets/js/main.js"></script>

</body>

</html>