/**
 * 
 */
function checkIt() {
	var boardinput = eval("document.boardinput");
	if (boardinput.subject.value.length < 2) {
		alert("제목을 2글자 이상 입력하세요");
		return false;
	}
	if (!boardinput.category.value) {
		alert("게시할 카테고리를 선택해주세요.");
		return false;
	}
	if (boardinput.content.value.length < 10) {
		alert("내용을 10글자 이상 입력하세요");
		return false;
	}
}