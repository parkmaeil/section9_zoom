package com.example.controller;

import org.springframework.http.*;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
public class MapSearchController {
    //  주소->위도, 경도
    private final String apiKey="fb1c310e228098321e6a6f5ef04723be";

    @GetMapping("/search/maps")
    public ResponseEntity<String> searchMaps(String address){

        String url="https://dapi.kakao.com/v2/local/search/address.json?query="+address;

        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "KakaoAK " + apiKey);

        HttpEntity<String> entity=new HttpEntity<>(headers);

        RestTemplate restTemplate=new RestTemplate();
        ResponseEntity<String> response=restTemplate.exchange(url, HttpMethod.GET, entity, String.class);

        return ResponseEntity.ok()
                .contentType(MediaType.APPLICATION_JSON_UTF8)
                .body(response.getBody());
    }

}
