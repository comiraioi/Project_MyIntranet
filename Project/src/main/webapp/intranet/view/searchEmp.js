/**
 * 
 */
 
function searchCheck(form){
	
	var chatkey = $('input[name=chatkey]').val();
	
	if(chatkey==""){
		alert('조회할 사원의 이름을 입력하세요');
		chatkey.focus();
		return;
	}
	
	form.submit();
	
}//searchCheck
