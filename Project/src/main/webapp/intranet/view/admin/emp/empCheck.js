/**
 * 
 */
 
function allCheck(obj){	//obj=allcheck
	var rchk = document.getElementsByName('rowchk');	//rowchk들을 배열 변수에 담음
		
	if(obj.checked){ //allcheck 체크했으면
		for(i=0; i<rchk.length; i++){
			rchk[i].checked = true;	//rowchk들을 checked 상태로
		}
	}else{ //allcheck 체크 해제했으면
		for(i=0; i<rchk.length; i++){
			rchk[i].checked = false;	//rowchk들을 checked 상태 해제
		}
	}
}//allCheck

	
function checkDel(){ //삭제 버튼 클릭
	flag = false;
	var rchk = document.getElementsByName('rowchk');
		
	for(i=0; i<rchk.length; i++){
		if(rchk[i].checked){
			flag = true;
		}
	}
		
	if(flag==false){
		alert("삭제할 폼의 체크박스를 선택하세요");
		return;
	}
		
	document.emplist.submit();
	
}//checkDel

function searchCheck(form){
	
	var keyword = $('input[name=keyword]').val();
	
	if(keyword==""){
		alert('조회할 사원의 이름을 입력하세요');
		keyword.focus();
	}
	
	form.submit();
	
}//searchCheck

function deptCheck(){
	document.seldept.submit();
}


