/**
 * script.js
 */

var use;
var isCheck = false;
 
function writeSave(){	//submit 클릭
	if($('input[name=email').val()==""){
		alert('이메일을 입력하세요');
		$('input[name=email').focus();
		return false;
	}
	if(use == "duplicate"){
		$('input[name=email]').select();
		return false;
	}else if(isCheck == false){
		alert('이메일 중복검사는 필수입니다');
		return false;
	}
	
}//writeSave()

function emailCheck(){	//코드 중복체크 버튼 클릭
	isCheck = true;
	$.ajax({
		url : "duplProc.jsp",
		data : ({ email : $('input[name=email]').val() }),
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
				else if($.trim(data) == "ORI"){
					$("#msg").html('<font color=blue>이메일 미변경</font>').show();
					use = "available";
				}
				else if($.trim(data) == "YES"){
					$("#msg").html('<font color=blue>사용 가능</font>').show();
					use = "available";
				}
			}
	});//ajax
}//emailCheck

function keyd(){	//email 입력에 키보드가 눌렸을때
	$('#msg').css('display','none');
	use = "";
	isCheck = false;
}


