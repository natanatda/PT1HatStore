/**
 * 브랜드 입점 신청서 및 수정
 */

 
 function checkInput(){
	 var userinput=document.userinput;
	 
	 //브랜드명
	 const brandInput = document.getElementsByName("brand")[0];
	 if(!userinput.brand.value){
		alert("브랜드명을 입력하세요.");
		brandInput.focus();
		return false;
	 }
	 
	 //대표자 이름
	 if(!userinput.representative.value){
		alert("대표자를 입력하세요.");
		return false;
	 }
	 
	 //사업자 등록번호
	 if (!userinput.bnumber.value) {
		 alert("사업자등록번호를 입력하세요.");
		 return false;
	 } else if (userinput.bnumber.value.replace(/-/g, "").length !== 10) {
		 alert("사업자등록번호를 올바르게 입력하세요.");
		 return false;
	 }
	 
	 //업종
	 if(!userinput.sectors.value){
		alert("업종을 입력하세요.");
		return false;
	 }
	 
	 //소재지
	 if(!userinput.blocation.value){
		alert("소재지를 입력하세요.");
		return false;
	 }
	 
	 //파일 첨부
	 var file = document.querySelector('input[name="bsave"]').files[0];
	 if (!file) {
		 alert("파일을 첨부해 주세요");
		 return false;
	 }
	 
	 return true;
 }
 
 
 //사업자 등록번호
 const autoHyphen = (target) => {
	 target.value = target.value
	 .replace(/[^0-9]/g, '') //숫자 아닌거 입력하면 삭제
	 .replace(/^(\d{3})(\d{2})(\d{5})$/g, `$1-$2-$3`);
}




