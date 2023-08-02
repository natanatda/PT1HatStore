/**
 * 
 */

function checkIt() {
   var userinput = eval("document.userinput");
   const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/; //이메일

   if (!userinput.store_pw.value) {
      alert("비밀번호를 입력하세요. 4~12글자입니다. ");
      return false;
   }


   if (!userinput.store_name.value) {
      alert(" 이름을 입력하세요");
      return false;
   }

   if (!userinput.store_tel.value) {
      alert("전화번호를 입력하세요.");
      return false;
   }else if(userinput.store_tel.value.length<11){
      alert("전화번호를 올바르게 입력하세요.");
      return false;
   }


   if (!userinput.store_email.value) {
      alert("이메일을 입력하세요.");
      return false;
   } else if (!emailRegex.test(userinput.store_email.value)) {
      alert("올바른 이메일 형식이 아닙니다.");
      return false;
   }

}

//전화 번호
const autoHyphen = (target) => {
   target.value = target.value
      .replace(/[^0-9]/g, '') //숫자 아닌거 입력하면 삭제
      .replace(/^(\d{2,3})(\d{3,4})(\d{4})$/g, `$1-$2-$3`);
}


// 아이디 중복 여부를 판단
function openConfirmId(userinput) {   //여기 대입되는게 this.form 폼태그임. 위에 하고 있는것처럼 도큐맨트 점 인풋 점 막 이케 해도되는데 여기선 그렇게 안한거임. 
   // 아이디를 입력했는지 검사
   if (userinput.store_id.value == "") {
      alert("아이디를 입력하세요");
      return;
   }
   // url과 사용자 입력 id를 조합합니다.
   url = "confirmId.jsp?store_id=" + userinput.store_id.value;  //?뒤쪽으로는 주소가 아니라 겟방식으로 보내고 있는 파라미터임. 지금은 사용자가 입력간 값을... 

   // 새로운 윈도우를 엽니다.
   open(url, "confirm", "toolbar=no, location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=300, height=200");  //새 창 나오는게 open함수임. 
}