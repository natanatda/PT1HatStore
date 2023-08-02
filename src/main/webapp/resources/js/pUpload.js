/**
 * 상품 등록 및 수정
 */


function checkInput(){
	 var userinput=document.userinput;
	 
	 //카테고리
	 if(!userinput.category.value){
		alert("카테고리를 선택하세요.");
		return false;
	 }
	 
	 //상품명
	 if(!userinput.pname.value){
		alert("상품명을 입력하세요.");
		return false;
	 }
	 
	 //브랜드명
	 if (!userinput.brandNo.value) {
		 alert("브랜드를 선택하세요.");
		 return false;
	 }
	 
	 //색상
	 var regex1 = /^[a-zA-Z가-힣]+$/; // 영어 대소문자와 한글만 허용
	 if(!userinput.color.value){
		alert("색상을 입력하세요.");
		return false;
	 }else if(!regex1.test(userinput.color.value)){
		 alert("색상은 한글 또는 영어만 가능합니다.");
		return false;
	 }
	 
	 //사이즈
	 var regex2 = /^[a-zA-Z0-9]+$/; // 영어 대소문자, 한글, 숫자만 허용
	 if(!userinput.psize.value){
		alert("사이즈를 입력하세요.");
		return false;
	 }else if(!regex2.test(userinput.psize.value)){
		 alert("사이즈는 영어, 숫자만 가능합니다.");
		return false;
	 }
	 
	 //재고
	 var regex3 = /^[0-9]+$/; // 숫자만 허용
	 if (!userinput.stock.value) {
		 alert("재고를 입력하세요.");
		 return false;
	 }else if(userinput.stock.value<=0){
		 alert("재고는 0개 이상이어야 등록 가능합니다.");
		return false;
	}
	
	//가격
	 if (!userinput.price.value) {
		 alert("가격을 입력하세요.");
		 return false;
	 }else if(userinput.price.value<=0){
		 alert("가격은 0원 이상이어야 등록 가능합니다.");
		return false;
	 }
	 
	 //상품 이미지
	 var file = document.querySelector('input[name="save"]').files[0];
	 if (!file) {
		 alert("파일을 첨부해 주세요");
		 return false;
	 }
	 
	 //상품 설명
	 if(!userinput.pdetail.value){
		alert("상품설명을 입력하세요.");
		return false;
	 }else if(userinput.pdetail.value.length < 10){
		alert("상품설명은 최소 10글자 이상입니다.");
		return false;
	 }
	 
	 //판매 여부
	 if(!userinput.onsale.value){
		alert("판매 여부를 설정하세요. (Y 선택 시 상품 등록과 동시에 판매페이지에 노출되므로 주의하세요.)");
		return false;
	 }
	 return true;
 }