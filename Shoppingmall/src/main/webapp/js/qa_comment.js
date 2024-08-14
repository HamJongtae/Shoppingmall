$(function(){
	let rowCount = 10;
	let currentPage;
	let count;

	/* ====================================
	 * 댓글 등록 및 수정 공통
	 * ====================================*/
	//textarea에 내용 입력 시 글자 수 체크
	$(document).on('keyup','textarea', function(){
		//입력한 글자수 구함
		let inputLength = $(this).val().length;
		
		if(inputLength > 300){//300자를 넘어선 경우
			$(this).val($(this).val().substring(0,300));	
		}else{//300자 이하인 경우
			let remain = 300 - inputLength;
			remain += '/300';
			if($(this).attr('id') == 're_content'){
				//등록폼 글자수
				$('#re_first .letter-count').text(remain);
			}else{
				//수정폼 글자수
				$('#mre_first .letter-count').text(remain);
			}
		}
	});
	
	/* ====================================
	 * 댓글 등록
	 * ====================================*/
	//댓글 등록
	$('#re_form').submit(function(event){
		if($('#re_content').val().trim()==''){
			alert('내용을 입력하세요');
			$('#re_content').val('').focus();
			return false;
		}
		//form 이하의 태그에 입력한 데이터를 모두 읽어서 쿼리 스트링으로 반환
		let form_data = $(this).serialize();
		
		//서버와 통신
		$.ajax({
			url: 'writeQa_Comment.do',
			type: 'post',
			data: form_data,
			dataType: 'json',
			success: function(param){
				if(param.result == 'logout'){
					alert('로그인해야 작성할 수 있습니다.')
				}else if(param.result == 'success'){
					alert('답변이 등록되었습니다.')
					//폼 초기화
					initForm();
					//댓글 작성이 성공하면 새로 삽입한 글을 포함해서 첫 번째 페이지의 게시글 목록을 다시 호출함
					selectList(1);
					$('#answer').hide();
					$('#re_form').hide();
				}else{
					alert('댓글 등록 오류');
				}
			},
			error: function(){
				alert('네트워크 오류 발생');
			}
		});
		
		//기본 이벤트 제거
		event.preventDefault();
	});
	//댓글 작성 폼 초기화
	function initForm(){
		$('textarea').val('');
		$('#re_first .letter-count').text('300/300');
	}

	/* ====================================
	 * 댓글 목록
	 * ====================================*/
	//댓글 목록
	function selectList(pageNum){
		currentPage = pageNum;
		//로딩 이미지 노출
		$('#loading').show();
		//서버와 통신
		$.ajax({
			url: 'listQa_Comment.do',
			type: 'post',
			data: {pageNum:pageNum,rowCount:rowCount,qa_num:$('#qa_num').val()},
			dataType: 'json',
			success:function(param){
				
				//로딩 이미지 감추기
				$('#loading').hide();
				count = param.count;
				
				if(pageNum == 1){
					//처음 호출시는 해당 ID의 div의 내부 내용물을 제거
					$('#output').empty();
				}
				
				$(param.list).each(function(index, item){
					let output = '<div class="item">';
					output += '<div class="sub-item">';
					output += '<p>' + item.qa_comm_content + '</p>';
					
					if(item.qa_comm_modify){
						output += '<span class="modify-date mb-5">' + item.qa_comm_modify.substring(0,10) + '</span><br>';
					}else{
						output += '<span class="modify-date mb-5">' + item.qa_comm_reg.substring(0,10) + '</span><br>';
					}
					if(param.auth==9){
						output += ' <input type="button" data-renum="' + item.qa_comm_num + '" value="수정" class="modify-btn btn btn-warning text-white mt-2">';
						output += ' <input type="button" data-renum="' + item.qa_comm_num + '" value="삭제" class="delete-btn btn btn-warning text-white mt-2">';
					}	
					output += '</div>';
					output += '</div>';
					
					//문서 객체에 추가
					$('#output').append(output);
				});
				
				//페이지 버튼 처리
				if(currentPage >= Math.ceil(count/rowCount)){
					//다음 페이지가 없음
					$('.paging-button').hide();	
				}else{
					//다음 페이지가 존재
					$('.paging-button').show();
				}
			},
			error:function(){
				$('#loading').hide();
				alert('네트워크 오류 발생');
			}
		});
	}
	//페이지 처리 이벤트 연결(다음 댓글 보기 버튼 클릭 시 데이터 추가)
	$('.paging-button input').click(function(){
		selectList(currentPage + 1);
	});
	
	/* ====================================
	 * 댓글 수정
	 * ====================================*/
	$(document).on('click','.modify-btn', function(){
		//댓글 번호
		let qa_comm_num = $(this).attr('data-renum');
		//댓글 내용
		let qa_comm_content = $(this).parent().find('p').html().replace(/<br>/gi, '\n');
															 //g:지정문자열 모두,i:대소문자 무시
		//댓글 수정폼 UI
		let modifyUI = '<form id="mre_form">';
		modifyUI += '<input type="hidden" name="qa_comm_num" id="mre_num" value="'+ qa_comm_num +'">';
		modifyUI += '<textarea rows="7" cols="100" name="qa_comm_content" id="mre_content" class="rep-content">'+ qa_comm_content +'</textarea>';
		modifyUI += '<div id="mre_first"><span class="letter-count">300/300</span></div>';
		modifyUI += '<div id="mer_second" class="align-right">';
		modifyUI += ' <input type="submit" class="btn btn-warning text-white" value="수정">';
		modifyUI += ' <input type="button" value="취소" class="btn btn-warning text-white re-reset">';
		modifyUI += '</div>';
		modifyUI += '<hr size="1" noshade width="96%">';
		modifyUI += '</form>';
		
		//이전에 이미 수정하는 댓글이 있을 경우 수정버튼을 클릭하면 sub-item 클래스로 지정된 div를 환원시키고 수정폼을 제거함
		initModifyForm();
		
		//수정 버튼을 감싸고 있는 div
		$(this).parent().hide();
		
		//수정폼을 수정하고자 하는 데이터가 있는 div에 노출
		$(this).parents('.item').append(modifyUI);
		
		//입력한 글자수 셋팅
		let inputLength = $('#mre_content').val().length;
		let remain = 300 - inputLength;
		remain += '/300';
		
		//문서 객체에 반영
		$('#mre_first .letter-count').text(remain);
	});
	
	//댓글 수정폼 초기화
	function initModifyForm(){
		$('.sub-item').show();
		$('#mre_form').remove();
	}
	
	//수정폼에서 취소버튼 클릭 시 수정폼 초기화 
	$(document).on('click', '.re-reset', function(){
		initModifyForm();
	})
	//댓글 수정
	$(document).on('submit','#mre_form', function(event){
		if($('#mre_content').val().trim()==''){
			alert('내용을 입력하세요');
			$('#mre_content').val('').focus();
			return false;
		}
		//폼에 입력한 데이터 반환
		let form_data = $(this).serialize();
		
		//서버와 통신
		$.ajax({
			url:'updateQa_Comment.do',
			type: 'post',
			data: form_data,
			dataType: 'json',
			success: function(param){
				if(param.result == 'logout'){
					alert('로그인해야 수정할 수 있습니다.');
				}else if(param.result == 'success'){
					$('#mre_form').parent().find('p').html($('#mre_content').val().replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/\n/g,'<br>'));
					$('#mre_form').parent().find('.modify-date').text('최근 수정일: 5초미만');
					//수정폼 삭제 및 초기화
					initModifyForm();
				}else if(param.result == 'wrongAccess'){
					alert('타인의 글을 수정할 수 없습니다.');
				}else{
					alert('댓글 수정 오류 발생');
				}
			},
			error: function(){
				alert('네트워크 오류 발생');
			}
		});
		
		
		//기본 이벤트 제거
		event.preventDefault();
		
	});
	
	/* ====================================
	 * 댓글 삭제
	 * ====================================*/
	$(document).on('click','.delete-btn', function(){
		//댓글번호
		let qa_comm_num = $(this).attr('data-renum');
		//서버와 통신
		$.ajax({
			url: 'deleteQa_Comment.do',
			type: 'post',
			data: {qa_comm_num:qa_comm_num,qa_num:$('#qa_num').val()},
			dataType: 'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인해야 삭제할 수 있습니다.');
				}else if(param.result == 'success'){
					alert('답변이 삭제되었습니다.');
					$('#answer').show();
					$('#re_form').show();
					selectList(1);
				}else if(param.result == 'wrongAccess'){
					alert('타인의 글을 삭제할 수 없습니다.');
				}else{
					alert('댓글 삭제 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	});
	
	
	
	
	/* ====================================
	 * 초기 데이터(목록) 호출
	 * ====================================*/
	selectList(1);
});