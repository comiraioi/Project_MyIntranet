/**
 * script.js
 */

var use;
var isCheck = false;
 
function writeSave(){	//submit 클릭
	if($('input[name=code]').val()==""){
		alert('코드를 입력하세요');
		$('input[name=code]').focus();
		return false;
	}
	if(use == "duplicate"){
		$('input[name=code]').select();
		return false;
	}else if(isCheck == false){
		alert('코드 중복검사는 필수입니다');
		return false;
	}
}//writeSave()

function codeCheck(){	//코드 중복체크 버튼 클릭
	var deptno = $('input[name=deptno]').val();
	var code = $('input[name=code]').val();
	var allData = {"deptno":deptno, "code":code};
	
	isCheck = true;
	$.ajax({
		url : "duplProc.jsp",
		data : allData,
			success : function(data){
				if($('input[name=code]').val()==""){
					$("#msg").html('코드를 입력하세요').show();
					$('input[name=code]').focus();
				}
				else if($.trim(data) == "NO"){
					$("#msg").html('중복 코드입니다').show();
					$('input[name=code]').select();
					use = "duplicate";
				}else if($.trim(data) == "ORI"){
					$("#msg").html('<font color=blue>코드 미변경</font>').show();
					use = "available";
				}else if($.trim(data) == "YES"){
					$("#msg").html('<font color=blue>사용 가능한 코드<font>').show();
					use = "available";
				}
			}
	});//ajax
}//codeCheck

function keyd(){	//code 입력에 키보드가 눌렸을때
	$('#msg').css('display','none');
	use = "";
	isCheck = false;
}


