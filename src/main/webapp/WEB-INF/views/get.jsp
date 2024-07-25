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
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<div class="container-fluid mt-3">
  <h1>Java Spring Full Stack Developer</h1>
  <p>Resize the browser window to see the effect.</p>
  <p>The first, second and third row will automatically stack on top of each other when the screen is less than 576px wide.</p>

  <div class="container-fluid">

     <div class="card">
        <div class="card-header">Java Spring Framework</div>
        <div class="card-body">
            <div class="row">
              <div class="col-sm-2 mb-2">
                <div class="card">
                  <div class="card-body">
                    <h4 class="card-title">Left</h4>
                    <p class="card-text">Some example text. Some example text.</p>
                    <a href="#" class="card-link">Card link</a>
                    <a href="#" class="card-link">Another link</a>
                  </div>
                </div>
              </div>
              <div class="col-sm-7 mb-2">
                <div class="card">
                  <div class="card-body">
                    <h4 class="card-title">책 상세보기</h4>
                    <p class="card-text">선택한 <span class="badge badge-primary">${book.title}</span> 책의 정보를 보기</p>
                          <div class="card">
                            <div class="card-body">
                              <h4 class="card-title">${book.title}</h4>
                              <p class="card-text">
                              <span class="badge badge-dark">가격</span> ${book.price} /
                              <span class="badge badge-dark">저자</span> ${book.author} /
                              <span class="badge badge-dark">페이지</span> ${book.page}</p>
                              <div id="atag">
                                  <a href="#" class="btn btn-secondary btn-sm">목록</a>
                                  <a href="${book.num}" class="btn btn-secondary btn-sm">수정</a>
                                  <a href="${book.num}" class="btn btn-secondary btn-sm">삭제</a>
                              </div>
                            </div>
                            <button class="btn btn-sm btn-primary form-control" onclick="bookSearch('${book.title}')">교보문고 검색</button>
                            <div class="kyobo"></div>
                          </div>
                  </div>
                </div>
              </div>
              <div class="col-sm-3">
                <div class="card">
                  <div class="card-body">
                    <h4 class="card-title">Right</h4>
                    <p class="card-text">Some example text. Some example text.</p>
                    <a href="#" class="card-link">Card link</a>
                    <a href="#" class="card-link">Another link</a>
                  </div>
                </div>
              </div>
            </div>
        </div>
        <div class="card-footer text-center">Java Spring Full Stack Developer(박매일)</div>
     </div>

  </div>
</div>
 <script>
     document.getElementById("atag").addEventListener("click", function(event){
        event.preventDefault();
        var target=event.target;
        if(target.tagName==="A"){
             var href=target.getAttribute("href");
             if(href==="#"){ // 목록
                 location.href="${cpath}/list";
             }else{
                 var num=href;
                 if(target.textContent==="수정"){
                       location.href="${cpath}/update/"+num; // 수정UI
                 }else if(target.textContent==="삭제"){
                       location.href="${cpath}/remove/"+num;  // 삭제
                 }//
             }//
        }
     });
    function bookSearch(title) {
        let url = "${cpath}/kysearch?title=" + encodeURIComponent(title);
        fetch(url)
            .then(response => {
                if (!response.ok) {
                    throw new Error("Network response was not ok");
                }
                return response.text();
            })
            .then(data => {
                               // HTML 데이터를 DOMParser를 사용하여 파싱합니다.
                               const parser = new DOMParser();
                               const doc = parser.parseFromString(data, "text/html");

                               // 이제 'doc'는 HTML 문서로 작업할 수 있는 Document 객체입니다.
                               // 위에서 제공된 책 정보 추출 코드를 여기에 삽입하고,
                               // 'document' 대신 'doc'을 사용하여 쿼리합니다.
                               const books = [];
                               doc.querySelectorAll('.prod_item').forEach((item) => {
                                   const book = {};
                                   const linkElement = item.querySelector('a.prod_info'); // 클래스 이름을 실제 HTML에 맞게 조정
                                   book.url = linkElement ? linkElement.href : '';
                                   const titleElement = item.querySelector('.prod_name_group span:not(.prod_category)');
                                   book.title = titleElement ? titleElement.textContent.trim() : '';
                                   const authorElement = item.querySelector('.prod_author_group .author');
                                   book.author = authorElement ? authorElement.textContent.trim() : '';
                                   const publisherElement = item.querySelector('.prod_author_group .publish');
                                   book.publisher = publisherElement ? publisherElement.textContent.trim() : '';
                                   const priceElement = item.querySelector('.prod_price .price .val');
                                   book.price = priceElement ? priceElement.textContent.trim() : '';
                                   const reviewScoreElement = item.querySelector('.review_summary_wrap .review_klover_text');
                                   book.reviewScore = reviewScoreElement ? reviewScoreElement.textContent.trim() : '';
                                   books.push(book);
                               });
                               // 결과 확인
                               console.log(books);
                                // Card 형태로 출력
                                updateUIWithBooks(books);
            })
            .catch(error => {
                console.log(error);
            });
    }
    function updateUIWithBooks(books) {
            const container = document.querySelector('.kyobo'); // 또는 책 정보를 추가할 다른 컨테이너 선택
            books.forEach(sbook => {
                var cardHTML ="";
                     cardHTML+="<div class='card mt-2'>";
                     cardHTML+="<div class='card-body'>";
                     cardHTML+="<h5 class='card-title'>"+sbook.title+"</h5>";
                      cardHTML+="<p class='card-text'>"+sbook.author+"/ "+sbook.publisher+"</p>";
                      cardHTML+="<p class='card-text'>"+sbook.price+"</p>";
                      cardHTML+="<p class='card-text'>"+sbook.reviewScore+"</p>";
                      cardHTML+="<a href='"+sbook.url+"' class='btn btn-primary'>상세보기</a>";
                      cardHTML+="</div>";
                      container.innerHTML += cardHTML; // 컨테이너에 카드 추가
            });
        }
  </script>
</body>
</html>