/**
 * 
 */
function checkIt() {
	var replyinput = document.replyinput;
	if (replyinput.content.value.length < 10) {
		alert("내용을 10글자 이상 입력하세요");
		return false;
	}
	if (replyinput.subject.value < 2) {
		alert("제목 2글자 이상 입력하세요");
		return false;
	}
}
