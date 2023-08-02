/**
 * 
 */

	function checkSelectAll()  {
		  // 전체 체크박스
		  const checkboxes 
		    = document.querySelectorAll('input[name="mycap"]');
		  // 선택된 체크박스
		  const checked 
		    = document.querySelectorAll('input[name="mycap"]:checked');
		  // select all 체크박스
		  const selectAll 
		    = document.querySelector('input[name="selectall"]');
		  
		  if(checkboxes.length === checked.length)  {
		    selectAll.checked = true;
		  }else {
		    selectAll.checked = false;
		  }
 
		}
		// name 이 mycap인 checkbox 모두 선택
		function selectAll(selectAll)  {
		  const checkboxes 
		     = document.getElementsByName('mycap');
		  checkboxes.forEach((checkbox) => {
		    checkbox.checked = selectAll.checked
		  })
		} 
		
	function chkCart(form){ // form을 매개변수로 사용
		var chkbox = document.getElementsByName("mycap"); 
		// 체크박스에 mycap이라는 이름의 요소들 대입
		
		var num = 0;
		// 체크 했는지 확인을 위한 변수
		
		for(i = 0; i < chkbox.length; i++){ // 대입한 체크박스 길이만큼 반복
			if(chkbox[i].checked){ // 체크된 체크박스가 있으면 num +1
				num++;
			} 
		}
		if(!num){ // 없으면 경고문 출력
			alert("상품을 선택해주세요.");
			return false; // submit하지 않음
		}
	}
	