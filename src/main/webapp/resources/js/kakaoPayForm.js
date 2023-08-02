/**
 * 
 */

 
 function checkIt() {
        var userinput = eval("document.userinput");
        if(!userinput.username.value) {
            alert("name을 입력하세요");
            return false;
        }
        
        if(!userinput.usertel.value ) {
            alert("전화번호를 입력하세요 ");
            return false;
        }
      
       
        if(!userinput.useraddress.value) {
            alert("주소를 입력하세요");
            return false;
        }
        
    }
       