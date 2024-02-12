package com.petshop.backend.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.petshop.backend.entities.Product;
import com.petshop.backend.services.contracts.IProductService;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/product")
public class ProductController {

    @Autowired
    private IProductService productService;

    @GetMapping("/list")
    private ResponseEntity<List<Product>> getAllProducts() {
        return this.productService.findAll();
    }

    @PostMapping("/create")
    private ResponseEntity<Product> createProduct(@RequestBody Product product) {
        return this.productService.create(product);
    }

    @PutMapping("/update/{id}")
    private ResponseEntity<Product> updateProduct(@PathVariable Long id, @RequestBody Product updatedProduct) {
        return this.productService.update(id, updatedProduct);
    }

    @DeleteMapping("/delete/{id}")
    private ResponseEntity<Object> deleteProduct(@PathVariable Long id) {
        return this.productService.delete(id);
    }
}
