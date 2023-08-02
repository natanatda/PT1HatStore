/**
 * 
 */

 function o_changechk(){
	 var chk = document.o_change; // form이름
	 var chk_change = 0; // radio 버튼 갯수를 체크하기 위한 변수
	 for(i = 0; i < chk.elements.length; i++){  // form 안에 요소만큼 반복문 동작
		 if((chk.elements[i].name=="change") && (chk.elements[i].checked))
		 			// change라는 이름의 요소가 선택되었으면
		 chk_change++; // radio버튼 갯수 +1
	 }
	 if(chk_change == 0){ // 선택 안 했을 때 동작하는 조건문
		 alert("사유를 선택해 주세요.");
		 return false;
	 }
	 return true;
 }