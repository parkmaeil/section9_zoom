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
   <script src="https://unpkg.com/mqtt/dist/mqtt.min.js"></script>
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

     #map { width: 100%; height: 400px; } /* 지도 크기 설정 */

  </style>
<script>
        var map;
        function initMap() {
            // 지도 생성 및 객체 생성
            map = new kakao.maps.Map(document.getElementById('map'), {
                center: new kakao.maps.LatLng(37.5665, 126.9780), // 초기 중심 좌표 설정
                level: 3 // 지도의 확대 레벨
            });
        }

        window.onload = initMap; // 윈도우 로드 시 지도 초기화

        const client = mqtt.connect('ws://localhost:9001'); // MQTT 브로커 연결

        client.on('connect', function () {
            console.log('Connected to MQTT Broker on ws://localhost:9001');
            client.subscribe('user/+/topic'); // 수신서버등록
        });
       //                                            user/user03/topic
        client.on('message', function (topic, message) {
            console.log("Message from"+topic +":"+message.toString());
            document.getElementById('messages').innerHTML += "<p>"+message.toString()+"</p>";

            const data = JSON.parse(message); // 메시지 파싱
            const latLng = new kakao.maps.LatLng(data.lat, data.lng);

            // 마커 생성 및 지도에 추가
            new kakao.maps.Marker({
                position: latLng,
                map: map
            });

            // 지도의 중심을 마커 위치로 이동
            map.setCenter(latLng);

            const topicParts = topic.split('/'); // "user/user01/topic"
            const userId = topicParts[1]; // 'user/{user_id}/topic' 형식이라고 가정

            fetch(`${cpath}/api/users/` + userId)
                .then(response => {
                    if (!response.ok) throw new Error('User not found');
                    return response.json();
                })
                .then(userData => {
                    console.log(userData);
                    document.getElementById('userDetails').innerHTML = "User Name: " + userData.customer_name;
                })
                .catch(error => {
                    console.error('Error fetching user data:', error);
                    document.getElementById('userDetails').innerHTML = "사용자가 없습니다.";
                });

        });

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
                <h4 class="card-title">위치 추적 시스템</h4>
                <p class="card-text">위도 경도가 변경시 지도가 실시간으로 변경된다</p>
                <h1>MQTT Message Receiver</h1>
                <div id="messages"></div>
                 <div id="map"></div> <!-- 지도를 표시할 div 요소 -->
              </div>
            </div>
          </div>
          <div class="col-sm-3">
            <div class="card">
              <div class="card-body">
                <h4 class="card-title">회원정보</h4>
                <p class="card-text">여기에 회원의 정보가 출력이 된다.</p>
                <div id="userDetails"></div>
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