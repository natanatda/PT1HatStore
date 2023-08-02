/**
 *  adminMs.jsp의 메시지보내기 유효성 검사
 */
function message(){
	var messageinput = eval("document.messageinput");
		if(!messageinput.store_id.value){
			alert("수신자를 입력해주세요");
		    return false;
		}
		if(!messageinput.brandno.value) {
		    alert("브랜드 번호를 입력해주세요");
		    return false;
		}
		if(messageinput.subject.value.length < 2) {
		    alert("제목을 2글자 이상 입력하세요");
		    return false;
		}
		if(messageinput.content.value.length < 10) {
		    alert("내용 10글자 이상 입력하세요");
		    return false;
		}
}