package com.petshop.backend.services.implementations;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.petshop.backend.entities.Product;
import com.petshop.backend.repositories.contracts.IProductRepository;
import com.petshop.backend.services.contracts.IProductService;

@Service
public class ProductService implements IProductService {

    @Autowired
    private IProductRepository productRepository;

    @Override
    public ResponseEntity<List<Product>> findAll() {
        try {
            List<Product> products = this.productRepository.findAll();
            return new ResponseEntity<List<Product>>(products, HttpStatus.OK);

        } catch (Exception e) {
            System.out.println("error: " + e);
            return new ResponseEntity<List<Product>>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    public ResponseEntity<Product> create(Product product) {
        try {
            Product productSaves = this.productRepository.save(product);
            return new ResponseEntity<Product>(productSaves, HttpStatus.CREATED);

        } catch (Exception e) {
            System.out.println("error: " + e);
            return new ResponseEntity<Product>(HttpStatus.INTERNAL_SERVER_ERROR);

        }
    }

    @Override
    public ResponseEntity<Product> update(Long id, Product updatedProduct) {
        try {
            Optional<Product> existingProduct = this.productRepository.findById(id);
            if (existingProduct.isPresent()) {
                Product product = existingProduct.get();
                product.setName(updatedProduct.getName());
                product.setDescription(updatedProduct.getDescription());
                product.setPrice(updatedProduct.getPrice());
                product.setImage(updatedProduct.getImage());
                // product.setCategories(updatedProduct.getCategories());

                Product productUpdated = this.productRepository.save(product);
                return new ResponseEntity<Product>(productUpdated, HttpStatus.OK);
            } else {
                return new ResponseEntity<Product>(HttpStatus.NOT_FOUND);
            }

        } catch (Exception e) {
            System.out.println(e.getMessage());
            return new ResponseEntity<Product>(HttpStatus.INTERNAL_SERVER_ERROR);

        }
    }

    @Override
    public ResponseEntity<Object> delete(Long id) {
        Map<String, Object> response = new HashMap<>();
        try {
            Optional<Product> productToDelete = this.productRepository.findById(id);
            if (productToDelete.isPresent()) {
                Product product = productToDelete.get();
                // product.getCategories().clear();
                this.productRepository.delete(product);
                return new ResponseEntity<>(response, HttpStatus.OK);
            } else {
                return new ResponseEntity<>(response.put("msg", "id does not exist"), HttpStatus.NOT_FOUND);
            }

        } catch (Exception e) {
            return new ResponseEntity<>(response.put("msg", e), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

}
