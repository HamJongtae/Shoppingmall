<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>footers</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- bootstrap 아이콘 cdn 링크 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<style>
  .text-yellow {
    color: #FFD700; /* 노란색 */
  }

  /* 이미지를 가운데에 고정 */
  .center-image {
    display: flex;
    justify-content: center;
    align-items: center;
  }

  /* 이미지 스타일 */
  .center-image img {
    max-width: 100%; /* 이미지 너비를 최대한 화면에 맞게 조절 */
    max-height: 100%; /* 이미지 높이를 최대한 화면에 맞게 조절 */
  }

  /* Footer 스타일 */
  .footer {
    margin-top: -1px; /* 이미지와의 간격을 조절 */
  }
   /* 스크롤 제거 */
  body {
    overflow-x: hidden;
  }
</style>
</head>
<body>
  	<footer class="footer rounded-top border-top border-color-gray">
        <div class="container-fluid rounded-bottom" style="padding-left:0; padding-right:0; background-color:#000000">
            <div class="row text-center">
                <div class="col-md-4 mt-3">
                    <h4 style="color: #CC66FF"><b>회사 정보</b></h4>
                    <ul class = "list-unstyled text-white">
                        <li>회사명 : 나이트오션</li>
                        <li>주소 : 서울특별시 강남구</li>
                        <li>전화 : 02-123-4567</li>
                        <li>email : nightocean@test.com</li>
                    </ul>
                </div>
                <div class="col-md-4 mt-3">
                    <h4 style="color: #CC66FF"><b>운영 정보</b></h4>
                    <ul class = "list-unstyled text-white">
                        <li>월요일 - 금요일, 9:00 - 18:00</li>
                        <li>사업제휴 문의 : nightocean@test.com</li>
                    </ul>
                </div>
                <div class="col-md-4 mt-3">
                    <h4 style="color: #CC66FF"><b>제작자 정보</b></h4>
                    <ul class = "list-unstyled text-white">
                        <li>함종태: h_whdxx</li>
                    </ul>
                </div>
            </div> 
            <div class="text-center">
                <div class="text-white pb-4">Copyright &copy; Your Website 2024</div>
            </div>
        </div>
   	</footer>
</body>
</html>
