<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="cpath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=db161ca250d8f49e2fdd7fb57f7bd127"></script>
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

  <style>
    .login-form {
      padding: 20px;
      background-color: #f8f9fa;
      border-radius: 5px;
    }
    .login-button, .register-button {
      width: 100%;
      padding: 8px;
    }
    .login-button {
      background-color: #007bff;
      color: white;
    }
    .register-button {
      background-color: #28a745;
      color: white;
      margin-top: 10px;
    }
    #map {
          width: 100%;
          height: 300px; /* 지도의 높이 */
        }
        .info-window {
            padding: 10px; /* 패딩 조정 */
                max-width: 300px; /* 최대 너비 설정 */
                border: 1px solid #ccc; /* 경계선 추가 */
                border-radius: 4px; /* 경계선 둥글게 처리 */
                background-color: white; /* 배경색 설정 */
            }
            .info-window button {
                display: block; /* 블록 레벨 요소로 변경 */
                width: 100%; /* 부모 요소에 맞춰 너비 설정 */
                margin-top: 8px; /* 상단 마진 추가 */
            }
  </style>

  <script>
  function searchLocation() {
      var address = document.getElementById('address').value;
      fetch('${cpath}/search/maps?address=' + encodeURIComponent(address))
      .then(response => response.json())
      .then(data => {
          if (data.documents && data.documents.length > 0) {
              var location = data.documents[0];
              var addressName = location.address.address_name;
              var roadAddressName = location.road_address? location.road_address.address_name : "도로명 주소 없음";
              document.getElementById('latitude').value = location.y;
              document.getElementById('longitude').value = location.x;
              // 지도보기 함수 호출
              displayMap(location.y, location.x, addressName, roadAddressName);
          } else {
              console.log('No location found for this address.');
          }
      })
      .catch(error => {
          console.error('Error:', error);
      });
  }

function displayMap(lat, lng, address, roadAddress) {
    var mapContainer = document.getElementById('map'),
        mapOption = {
            center: new kakao.maps.LatLng(lat, lng),
            level: 3,
            draggable: true
        };

    var map = new kakao.maps.Map(mapContainer, mapOption);
    var zoomControl = new kakao.maps.ZoomControl();
    map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHTBOTTOM);

    var markerPosition = new kakao.maps.LatLng(lat, lng);
    var marker = new kakao.maps.Marker({
        map : map,
        position: markerPosition
    });
    marker.setMap(map);

var contentString = '<div class="info-window">' + // 클래스 추가
    '<b>일반 주소:</b> ' + address + '<br>' +
    '<b>도로명 주소:</b> ' + roadAddress + '<br>' +
    '<button class="btn btn-sm btn-secondary" onclick="closeInfowindow()">닫기</button>' +
    '</div>';

    var infowindow = new kakao.maps.InfoWindow({
        content: contentString
    });

    // 마커에 클릭 이벤트를 등록합니다.
    kakao.maps.event.addListener(marker, 'click', function() {
        infowindow.open(map, marker);
    });

    // 전역 변수로 infowindow를 저장하여 접근 가능하게 합니다.
    window.currentInfowindow = infowindow;
}

// 인포윈도우를 닫는 함수
function closeInfowindow() {
    if (window.currentInfowindow) {
        window.currentInfowindow.close();
    }
}


  </script>
</head>
<body>

<div class="container-fluid mt-3">
  <h1>Java Spring Full Stack Developer</h1>
  <p>Resize the browser window to see the effect.</p>
  <div class="container-fluid">
    <div class="card">
      <div class="card-header">Java Spring Framework</div>
      <div class="card-body">
        <div class="row">
          <div class="col-sm-2 mb-2">
            <div class="card login-form">
              <div class="card-body">
                <h4 class="card-title">회원 로그인</h4>
                <form>
                  <div class="form-group">
                    <label for="username">사용자 이름:</label>
                    <input type="text" class="form-control" id="username" placeholder="Enter username">
                  </div>
                  <div class="form-group">
                    <label for="password">비밀번호:</label>
                    <input type="password" class="form-control" id="password" placeholder="Enter password">
                  </div>
                  <button type="submit" class="btn login-button">로그인</button>
                  <a href="${cpath}/register" class="btn register-button">회원가입</a>
                </form>
              </div>
            </div>
          </div>
<div class="col-sm-7 mb-2">
  <div class="card">
    <div class="card-body">
      <h4 class="card-title">회원가입</h4>
      <p class="card-text">회원가입 데이터를 입력해주세요.</p>
      <form>
        <div class="form-group">
          <label for="customer_id">고객아이디:</label>
          <input type="text" class="form-control" id="customer_id" placeholder="Enter Customer ID">
        </div>
        <div class="form-group">
          <label for="password">패스워드:</label>
          <input type="password" class="form-control" id="customer_password" placeholder="Enter Password">
        </div>
        <div class="form-group">
          <label for="customer_name">이름:</label>
          <input type="text" class="form-control" id="customer_name" placeholder="Enter Customer Name">
        </div>
        <div class="form-group">
          <label for="age">나이:</label>
          <input type="number" class="form-control" id="age" placeholder="Enter Age">
        </div>
        <div class="form-group">
          <label for="occupation">직업:</label>
          <input type="text" class="form-control" id="occupation" placeholder="Enter Occupation">
        </div>
        <div class="form-group">
          <label for="address">주소:</label>
          <input type="text" class="form-control" id="address" placeholder="Enter Address">
          <button type="button" class="btn btn-primary mt-2" onclick="searchLocation()">위도와 경도 검색</button>
        </div>
        <div class="form-group">
          <label for="latitude">위도:</label>
          <input type="text" class="form-control" id="latitude" placeholder="Latitude" readonly>
        </div>
        <div class="form-group">
          <label for="longitude">경도:</label>
          <input type="text" class="form-control" id="longitude" placeholder="Longitude" readonly>
        </div>
        <button type="submit" class="btn btn-success">회원가입</button>
      </form>
    </div>
  </div>
</div>

          <div class="col-sm-3">
            <div class="card">
              <div class="card-body">
                <h4 class="card-title">지도보기</h4>
                <p class="card-text">검색된 주소의 지도가 표시된다</p>
                <div id="map" class="map-container"></div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="card-footer text-center">Java Spring Full Stack Developer(박매일)</div>
     </div>
   </div>
 </div>
 </body>
 </html>
