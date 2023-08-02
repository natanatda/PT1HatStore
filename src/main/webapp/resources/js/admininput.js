/**
 * 
 */
  function checkIt() {
        var userinput = eval("document.userinput");
        if(!userinput.admin_id.value) {
            alert("ID를 입력하세요");
            return false;
        }
        if(!userinput.admin_pw.value ) {
            alert("비밀번호를 입력하세요 ");
            return false;
        }
    }
function checkIt2() {
   var admininput = eval("document.admininput");
   
   if (admininput.pw.value.length < 4 || admininput.pw.value.length > 12) {
      alert("비밀번호를 입력하세요. 4~12글자입니다. ");
      return false;
   }
}