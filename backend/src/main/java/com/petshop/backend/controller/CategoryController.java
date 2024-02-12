package com.petshop.backend.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.petshop.backend.entities.Category;
import com.petshop.backend.services.contracts.ICategoryService;

@RestController
@RequestMapping("/category")
public class CategoryController {
    @Autowired
    private ICategoryService categoryService;

    @GetMapping("/list")
    private ResponseEntity<List<Category>> getAllCategories() {
        return this.categoryService.findAll();
    }

    @PostMapping("/create")
    private ResponseEntity<Category> createCategory(@RequestBody Category category) {
        return this.categoryService.create(category);
    }
}
