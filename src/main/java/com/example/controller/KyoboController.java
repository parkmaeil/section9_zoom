package com.example.controller;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
public class KyoboController {

    @GetMapping("/kysearch")
    public ResponseEntity<?> kysearch(@RequestParam("title") String title){

        String url="https://search.kyobobook.co.kr/search?keyword="+title;

        RestTemplate restTemplate=new RestTemplate();
        String response=restTemplate.getForObject(url, String.class);
        System.out.println(response); // HTML 코드
        // 서버가 클라이언트에게 응답시 정보를 알려주는 행위(Header)
        HttpHeaders headers=new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON_UTF8);

         return new ResponseEntity<>(response, headers, HttpStatus.OK);
    }
}
