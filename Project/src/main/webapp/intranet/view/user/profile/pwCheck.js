/**
 * script.js
 */

var use, pwsame, pwval;
var isCheck = false;
 
function pwSave(){	//비밀번호 변경 클릭

	if($('input[name=oripw]').val()==""){
		alert('현재 비밀번호를 입력하세요');
		$('input[name=oripw]').focus();
		return false;
	}
	if(use == "mismatch"){
		$('input[name=oripw]').select();
		return false;
	}else if(isCheck == false){
		alert('현재 비밀번호 확인은 필수입니다');
		return false;
	}
	
	if($('input[name=pw]').val()==""){
		alert("새로운 비밀번호를 입력하세요");
		$('input[name=pw]').focus();
		return false;
	}
	
	if($('input[name=pwconfirm]').val() == ""){
		alert('새로운 비밀번호 확인을 입력하세요');
		$('input[name=pwconfirm]').focus();
		return false;
	}
	if(pwsame == "notsame"){
		alert("새로운 비밀번호가 일치하지 않습니다");
		return false;
	}
	
}//pwSave()

function pwMatch(){	//기본 비밀번호 확인 버튼 클릭
	isCheck = true;
	$.ajax({
		url : "pwMatch.jsp",
		data : ({ oripw : $('input[name=oripw]').val() }),
			success : function(data){
				if($('input[name=oripw]').val()==""){
					$("#pwmsg").html('현재 비밀번호 입력').show();
					$('input[name=oripw]').focus();
				}
				else if($.trim(data) == "NO"){
					$("#pwmsg").html('비밀번호가 틀렸습니다').show();
					$('input[name=oripw]').select();
					use = "mismatch";
				}
				else if($.trim(data) == "YES"){
					$("#pwmsg").html('<font color=blue>비밀번호 확인됨</font>').show();
					$('input[name=oripw]').select();
					use = "match";
				}
			}
	});//ajax
}//pwCheck

function pwkeyd(){	//oripw 입력에 키보드가 눌렸을때
	$('#pwmsg').css('display','none');
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
	if(($('input[name=pw]').val()).equals($('input[name=pwconfirm]').val())){
		pwsame = "same";
	}else{
		pwsame = "notsame";
	}
}//pw2Check









