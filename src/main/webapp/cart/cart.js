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