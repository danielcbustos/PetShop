package com.petshop.backend.services.contracts;

import java.util.List;

import org.springframework.http.ResponseEntity;

import com.petshop.backend.entities.Product;

public interface IProductService {

    public ResponseEntity<List<Product>> findAll();

    public ResponseEntity<Product> create(Product product);

    public ResponseEntity<Product> update(Long id, Product updatedProduct);

    public ResponseEntity<Object> delete(Long id);
}
