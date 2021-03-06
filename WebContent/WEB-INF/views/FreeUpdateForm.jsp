<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유 게시판</title>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/16.0.0/classic/ckeditor.js"></script>
<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>

<!-- ckEditor 크기 조절 -->
<style type="text/css">
.ck.ck-editor
{
	max-width: 850px;
}
.ck-editor_editable
{
	min-height: 500px;
}
</style>

<script type="text/javascript">

	$(document).ready(function()
	{
		//제목 글자 수 byte 받아오기.
		$('#subjectHelp').on('keyup', function()
		{
			if($(this).val().length > 200)
			{
				$(this).val($(this).val().substring(0,200));
			}
		});
		
		// 제목 글자 수 입력 제한(4000byte)	
		$(document).on('keyup', '#subjectHelp', function(e)
		{
			var textarea = $(this).val();
			$('#postTitle').text(getSubject(textarea));
		});
		
		function getSubject(str)
		{
			var count = 0;
			for(var i=0; i<str.length; i++)
			{
				count += (str.charCodeAt(i) > 200) ? 2 : 1;
			}
			return count;
		}
		
		$('.board').click(function()
		{
			var test = $(this).text();
			
			if (test == '질문 게시판')
			{
				$(location).attr('href', 'board.action?bid=1');
			}
			
			else if (test == '정보 게시판') 
			{
				$(location).attr('href', 'board.action?bid=2');
			}
			
			else if (test == '자유 게시판') 
			{
				$(location).attr('href', 'board.action?bid=3');
			}
			
			else if (test == '건의 게시판')
			{
				$(location).attr('href', 'board.action?bid=4');
			}
		});
		
		$('#write').click(function()
		{
			$(location).attr('href', 'board.action?bid=3');
		});
		
		ClassicEditor.create(document.querySelector( '#editor' ));
		
	});

</script>

</head>
<body>

	<!-- Header -->
	<div style="background-color: #34314c; height: 115px;"></div>
	<div class="container">
		<header>
			<jsp:include page="Header.jsp" />
		</header>
	</div>

	<br />
	<br />

	<div class="container">
		<p class="h1" style="font-weight: bold;"><a href="board.action?bid=3" style="color: black; text-decoration: none">자유 게시판</a></p>
	</div>

	<br />
	<br />

	<div class="container">
		<div class="row col-md-3 float-left" style="width: 300px;">      
			<div class="col-10">
				<div class="list-group" id="list-tab" role="tablist">
				<c:forEach var="boardName" items="${boardName }" varStatus="status">
					<a href="#" id="${status.count }" class="board list-group-item list-group-item-action">${boardName.bname } 게시판</a>
				</c:forEach>					
				</div>
			</div>
		</div>
		

		<p class="h3" style="color: black">게시글 수정</p>
		<br /><br />

		<div class="col-md-9 float-right" style="width: 850px;">
			<c:forEach var="readData" items="${readData }">
			<form action="boardupdate.action" method="POST" role="form">
				<div class="form-group" style="font-style: bold;">
					<label>제목</label> 
					<input type="text" name="postTitle" id="subjectHelp" class="form-control" placeholder="100자 이내만 입력하세요." 
						style="background-color: rgba(255, 255, 255, 0.5)" value="${readData.postTitle }">
				</div>
				
				<br />
				
				<div class="float-right">
					<p class="byte" style="margin-bottom: 0px;">${readData.content }<span id="postTitle">0</span>/200 byte</p>
				</div>
				
				<div class="form-group">
					<label>내용</label>
						<textarea name="content" id="editor"></textarea>
				</div>
					
				<input type="text" name="bid" value="${bid }" hidden/>
				<input type="text" name="bpid"	value="${bpid }" hidden/>
				<input type="text" name="usId" value="${usId }" hidden/>
				
				<br /><br />
				
				<button type="submit" class="btn float-right"
				style="width: 90px; height: 40px; background-color: #34314c; color: white;">확인</button>

			</form>
			</c:forEach>
			
			<button type="submit" class="btn float-center"
				style="width: 90px; height: 40px; background-color: #79bd9a; color: white;" onclick="location.href='boardread.action?bid=3'">목록으로</button>

			
			<br /> <br />			
			
			
			<br /><br /><br /><br /><br /><br />
		</div>
	</div>

</body>
</html>