package com.petshop.backend.services.contracts;

import java.util.List;

import org.springframework.http.ResponseEntity;

import com.petshop.backend.entities.Category;

public interface ICategoryService {

    public ResponseEntity<List<Category>> findAll();

    public ResponseEntity<Category> create(Category category);

}
