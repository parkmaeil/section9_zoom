package com.example.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Customer {

    private String customer_id;
    private String password;
    private String customer_name;
    private int age;
    private String rating;
    private String occupation;
    private int reserves;

}
