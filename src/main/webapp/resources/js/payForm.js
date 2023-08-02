/**
 * 
 */

   function checkIt() {
        var userinput = eval("document.userinput");
     
       
        if(!userinput.usertel.value) {
            alert("전화번호를 입력하세요. 하이픈을 제외하고 작성해주세요.");
            return false;
        }    
        if(!userinput.usercode.value) {
            alert("이메일을 입력하세요. @가 포함되어야합니다.");
            return false;
        }
     
    }