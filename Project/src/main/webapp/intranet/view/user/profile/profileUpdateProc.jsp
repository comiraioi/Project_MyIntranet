<%@page import="com.EmpDao"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Edit Profile(수정하기) => profileUpdateProc.jsp -->
<%
	String configFolder = config.getServletContext().getRealPath("/intranet/view/userimg/");
	int maxSize = 1024*1024*5;
	String encoding = "UTF-8";
	
	MultipartRequest mr = null;
	String msg =""; 
	
	try{
		mr = new MultipartRequest(request,configFolder,maxSize,encoding,new DefaultFileRenamePolicy());
		
		String previmage = mr.getParameter("previmage");	//기존 이미지명
		String image = mr.getFilesystemName("image");	//update에서 새로 업로드한 이미지 파일
		
		String img = null;
		if(previmage == null){	//기존 이미지가 없고
			if(image != null){	//새로 업로드한 이미지가 있으면
				 img = image;
			}
		}else{	//기존 이미지가 있고
			if(image == null){	//새로 업로드한 이미지가 없으면
				img = previmage;
			}else{	//새로 업로드한 이미지가 있으면
				img = image;
			
				File delFile = new File(configFolder,previmage);
				delFile.delete();
			}
		}
		
		String sid = (String)session.getAttribute("sid");
		EmpDao edao = EmpDao.getInstance();
		int cnt = edao.updateProfile(mr,img,sid);
		
		if(cnt==1){
			msg = "프로필 수정을 완료했습니다";
		}else{
			msg = "프로필 수정 실패";
		}
	}catch(Exception e){
		
	}
%>

<script type="text/javascript">
	alert("<%=msg%>");
	location.href="myProfile.jsp";
</script>