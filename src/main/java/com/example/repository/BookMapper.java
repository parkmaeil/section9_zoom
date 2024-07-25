package com.example.repository;

import com.example.entity.Book;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BookMapper {
    public List<Book> bookList();
    public void saveBook(Book dto);
    public void registerBook(Book dto);
    public Book get(int num);
    public void remove(int num);
    public void update(Book dto);
}
