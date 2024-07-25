package com.example.controller;

import com.example.entity.Book;
import com.example.repository.BookMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class SpringController {

    @Autowired
    private BookMapper mapper;

    @RequestMapping("/spring")
    public String index(){
        return "template"; // template.jsp
    }

    @RequestMapping("/list")
    public String list(Model model){
        List<Book> list=mapper.bookList();
        model.addAttribute("list", list);
        return "list"; // list.jsp
    }

    @GetMapping("/register")
    public String registerGet(){
        return "register"; // register.jsp
    }

    @PostMapping("/register")
    public String registerPost(Book dto){ // 파라메터 수집(자동으로된다.) , @RequestBody(JSON)
        mapper.registerBook(dto);
        return "redirect:/list";
    }

    @GetMapping("/get/{num}")  // /get?num=12
    public String get(@PathVariable int num, Model model){
        Book book=mapper.get(num);
        model.addAttribute("book", book);
        return "get"; // get.jsp<---- ${book.title}
    }

    @GetMapping("/remove/{num}")
    public String remove(@PathVariable int num){
        mapper.remove(num);
        return "redirect:/list";
    }

    @GetMapping("/update/{num}")
    public String updateGet(@PathVariable int num, Model model){
        Book book=mapper.get(num);
        model.addAttribute("book", book);
        return "update"; // update.jsp<--- ${book.num}
    }

    @PostMapping("/update")
    public String updatePost(Book dto){ // 파라메터 수집(DTO)
        mapper.update(dto);
        //return "redirect:/list";
        return "redirect:/get/"+dto.getNum(); // 상세보기 이동
    }

    @RequestMapping("/jsonList")
    public @ResponseBody List<Book> jsonList(){
        List<Book> list=mapper.bookList();
        return list; // [ {     }, {     }, {     } ]
    }
}
