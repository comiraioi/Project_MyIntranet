/**
 * script.js
 */

var use;
var isCheck = false;
 
function writeSave(){	//가입하기 클릭
	
	if($('input[name=id]').val() == ""){
		alert("아이디를 입력하세요.");
		$('input[name=id]').focus();
		return false;
	}
	
	if($('input[name=email]').val()==""){
		alert('이메일을 입력하세요');
		$('input[name=email]').focus();
		return false;
	}
	
	if($('input[name=pw]').val()==""){
		alert("비밀번호를 입력하세요");
		$('input[name=pw]').focus();
		return false;
	}
	
}//writeSave()