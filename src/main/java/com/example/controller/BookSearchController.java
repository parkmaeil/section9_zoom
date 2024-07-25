package com.example.controller;

import org.springframework.http.*;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
public class BookSearchController {
    private final String apiKey="ddcaeaee21f163c58818ca2db1820c67";

    @GetMapping("/search/books") // title="인공지능"
    public ResponseEntity<String> searchBooks(String title){

        // kakak Book Search Open API URL
        final String url="https://dapi.kakao.com/v3/search/book?query="+title;

        HttpHeaders headers=new HttpHeaders();
        headers.set("Authorization" , "KakaoAK " + apiKey);
        //headers.setContentType(MediaType.APPLICATION_JSON_UTF8);
        HttpEntity<String> entity=new HttpEntity<>(headers);

        RestTemplate restTemplate=new RestTemplate();
        ResponseEntity<String> response=restTemplate.exchange(url, HttpMethod.GET, entity, String.class);

        return ResponseEntity.ok()
                .contentType(MediaType.APPLICATION_JSON_UTF8)
                .body(response.getBody());
    }
}
