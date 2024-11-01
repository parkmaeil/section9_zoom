package com.example.controller;

import com.example.entity.Book;
import com.example.entity.Customer;
import com.example.repository.BookMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
public class SpringRestController {

    @Autowired
    private BookMapper mapper;

    // http://localhost:8081/myweb/rest
    @RequestMapping("/rest")
    public ResponseEntity<?> rest() {
        List<String> list = new ArrayList<>();
        list.add("스프링 프레임워크");
        list.add("잘 하면");
        list.add("된다");
        return new ResponseEntity<>(list, HttpStatus.OK); // rest.jsp <-- 뷰를 만들면 된다.(X) : JSON -> [{ key:value,   ,    ,}.{     },{    }]
    }

    @RequestMapping("/restlist")
    public ResponseEntity<?>  list() {
        List<Book> list = mapper.bookList();
        return new ResponseEntity<>(list, HttpStatus.OK);
    }

    @PostMapping("/restsave")
    public ResponseEntity<?> saveBook(@RequestBody Book dto) {
        mapper.saveBook(dto);
        return new ResponseEntity<>("success", HttpStatus.BAD_REQUEST);
    }

    @GetMapping("/api/users/{userId}")
    public ResponseEntity<?> getUserName(@PathVariable String userId ){
        Customer cus =mapper.getUserName(userId);
        //                                                cus->JSON
        return  new ResponseEntity<>(cus, HttpStatus.OK);
    }
}
