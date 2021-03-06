/**
 * 로그인 페이지에서 유효성 검사 체크
 */

function chkSubmit(){	//공백안돼요
	frm = document.forms["frm"];
	
	var c_id = frm["c_id"].value.trim();
	var c_name = frm["c_name"].value.trim();
	var c_email = frm["c_email"].value.trim();
	
	if(c_id == ""){
		alert("아이디를 입력해주세요");
		frm["c_id"].focus();
		return false;
	}
	
	if(c_name == ""){
		alert("이름을 입력해주세요");
		frm["c_name"].focus();
		return false;
	}
	
	if(c_email == ""){
		alert("이메일을 입력해주세요");
		frm["c_email"].focus();
		return false;
	}
	
	return true;
} // end chkSubmit()

$("#user_email").blur(function() {
	// id = "id_reg" / name = "userId"
	var user_email = $('#user_email').val();
	console.log("제이쿼리 실행");
	$.ajax({
	url : 'emailchk.ajax?userEmail='+ user_email,
	type : "GET",
	success : function(data) {
		console.log("1 = 중복o / 0 = 중복x : "+ data);	
		console.log(user_email + "문자열");
		if (data == '1') {
			// 1 : 아이디가 중복되는 문구
			//$("#email_check").css("display", "block");
			$("#chk_button").attr('disabled', false);
			$("#email_comment").css("display", "none");
		} else {
			$('#email_comment').text("등록된 이메일이 아닙니다.");
			$("#email_comment").css("color", "red");
			$("#email_comment").css("display", "block");
			//$("#email_check").css("display", "none");
			$("#chk_button").attr('disabled', true);
		}
		if(user_email == ""){
			//$("#email_check").css("display", "none");
			$("#chk_button").attr('disabled', true);
			$("#email_comment").css("display", "none");
		}
	}, 
	error : function() {
		console.log("실패");
	}
});

	});
//비밀번호찾기시 인증번호 비교 certif_comment
$("#certif_num").blur(function() {
	var certif_num = $('#certif_num').val();
	console.log("certif_num 제이쿼리 실행");
	$.ajax({
	url : 'certif.ajax?certifNum='+ certif_num,
	type : "GET",
	success : function(data) {
		console.log("1 = 일치o / 0 = 불일치x : "+ data);	
		console.log(certif_num + "문자열");
		if (data == '1') {
			console.log("일치");
			$("#logbtn").attr('disabled', false);
//			form attribute value 변경
			$("#contact-form").attr("action", "findpwOk.do");
			$("#contact-form").attr("method", "post")
			$('#certif_comment').text("인증 완료 :)");
			$("#certif_comment").css("color", "blue");
		} else {
			console.log("불일치");
			$("#logbtn").attr('disabled', true);
//			form attribute value 원상복구
			$("#contact-form").attr("action", "searchPw.jsp");
			$("#contact-form").attr("method", "get")
			$('#certif_comment').text("인증번호가 틀렸습니다 :p");
			$("#certif_comment").css("color", "red");
		}
		if(certif_num == ""){
			console.log("빈 문자열");
			$("#logbtn").attr('disabled', true);
//			form attribute value 원상복구
			$("#contact-form").attr("action", "searchPw.jsp");
			$("#contact-form").attr("method", "get")
			$('#certif_comment').text("인증번호를 입력해주세요;<");
			$("#certif_comment").css("color", "red");
		}
	}, 
	error : function() {
		console.log("실패");
	}
});

	});

