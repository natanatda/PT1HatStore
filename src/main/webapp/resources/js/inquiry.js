/**
 * 
 */

 function chkinquiry(){
    var inquiry = eval("document.writeform");
     if(!inquiry.category.value){
       alert("문의 유형을 선택해주세요");
       return false;
    }
    if(inquiry.subject.value.length < 2){
       alert("제목 2글자 이상 입력하세요");
       return false;
    }
    if(inquiry.content.value.length < 10){
       alert("내용 10글자 이상 입력하세요");
       return false;
    }
 }
 
  function chkinquiry2(){
    var inquiry = eval("document.writeform");
    if(inquiry.subject.value.length < 8){
       alert("제목 8글자 이상 입력하세요");
       return false;
    }
    if(inquiry.content.value.length < 10){
       alert("내용 10글자 이상 입력하세요");
       return false;
    }
 }