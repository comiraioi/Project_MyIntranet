/**
 * script.js
 */

var use;
var isCheck = false;
 
function writeSave(){	//가입하기 클릭
	
	if($('input[name=name]').val() == ""){
		alert("이름을 입력하세요");
		$('input[name=name]').focus();
		return false;
	}
	
	code = $('#code').val();
	if(!code){
		alert("부서를 선택하세요");
		$('#code').focus();
		return false;
	}
	
	if($('input[name=email]').val()==""){
		alert('이메일을 입력하세요');
		$('input[name=email]').focus();
		return false;
	}
	if(use == "duplicate"){
		$('input[name=email]').select();
		return false;
	}else if(isCheck == false){
		alert('이메일 중복체크는 필수입니다');
		return false;
	}
	
	if($('input[name=pw]').val()==""){
		alert("비밀번호를 입력하세요");
		$('input[name=pw]').focus();
		return false;
	}
	
	if($('input[name=pwconfirm]').val() == ""){
		alert('비밀번호 확인을 입력하세요');
		$('input[name=pwconfirm]').focus();
		return false;
	}
	if(pwsame == "mismatch"){
		alert("비밀번호가 일치하지 않습니다");
		return false;
	}
}//writeSave()

function emailCheck(){	//중복체크 버튼 클릭
	isCheck = true;
	$.ajax({
		url : "emailProc.jsp",
		data : ({ inputemail : $('input[name=email]').val() }),
			success : function(data){
				if($('input[name=email]').val()==""){
					$("#msg").html('이메일 입력').show();
					$('input[name=email]').focus();
				}
				else if($.trim(data) == "NO"){
					$("#msg").html('중복 이메일').show();
					$('input[name=email]').select();
					use = "duplicate";
				}
				else if($.trim(data) == "YES"){
					$("#msg").html('<font color=blue>사용 가능<font>').show();
					use = "available";
				}
			}
	});//ajax
}//emailCheck

function keyd(){	//이메일 입력에 키보드가 눌렸을때
	$('#msg').css('display','none');
	use = "";
	isCheck = false;
}

function pwCheck(){
	//조건: 영문,숫자,특수문자 포함 7~15자
	pw = $('input[name=pw]').val();
	var num = pw.search(/[0-9]/g);
 	var eng = pw.search(/[a-zA-Z]/ig);
 	var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
 	
	if(pw.length<7||pw.length>15){
		alert('7~15자로 입력하세요');
		$('input[name=password]').focus();
		return false;
	}else if(pw.search(/\s/) != -1){
		alert('공백 없이 입력하세요');
		$('input[name=password]').focus();
		return false;
	}else if(num < 0 || eng < 0 || spe < 0 ){
		alert('영문, 숫자, 특수문자 조합으로 입력하세요');
		$('input[name=password]').focus();
		return false;
	}
}//pwCheck

function pw2Check(){
	if($('input[name=pw]').val() == $('input[name=pwconfirm]').val()){
		pwsame = "match";
	}else{
		pwsame = "mismatch";
	}
}//pw2Check









