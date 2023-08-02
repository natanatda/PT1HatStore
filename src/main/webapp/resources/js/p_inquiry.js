/**
 * 
 */
function chkp_inquiry(){
	var p_inquiry = eval("document.writeform");
	if(p_inquiry.subject.value == "" || p_inquiry.subject.value == null){
		alert("제목을 선택해 주세요");
		return false;
	}
	if(p_inquiry.content.value.length < 10){
		alert("내용 10글자 이상 입력해주세요");
		return false;
	}
}