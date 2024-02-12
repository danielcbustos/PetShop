package com.petshop.backend.services.implementations;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.petshop.backend.entities.Category;
import com.petshop.backend.repositories.contracts.ICategoryRepository;
import com.petshop.backend.services.contracts.ICategoryService;

@Service
public class CategoryService implements ICategoryService {

    @Autowired
    private ICategoryRepository categoryRepository;

    @Override
    public ResponseEntity<List<Category>> findAll() {
        try {
            List<Category> categories = this.categoryRepository.findAll();
            return new ResponseEntity<List<Category>>(categories, HttpStatus.OK);

        } catch (Exception e) {
            System.out.println("error: " + e);
            return new ResponseEntity<List<Category>>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    public ResponseEntity<Category> create(Category category) {
        try {
            Category existingCategory = categoryRepository.findByNameIgnoreCase(category.getName());

            if (existingCategory != null) {
                return new ResponseEntity<Category>(HttpStatus.CONFLICT);
            }

            Category categorySaves = this.categoryRepository.save(category);
            return new ResponseEntity<Category>(categorySaves, HttpStatus.CREATED);

        } catch (Exception e) {
            System.out.println("error: " + e);
            return new ResponseEntity<Category>(HttpStatus.INTERNAL_SERVER_ERROR);

        }
    }

}
