package com.petshop.backend.repositories.contracts;

import org.springframework.data.jpa.repository.JpaRepository;

import com.petshop.backend.entities.Product;

public interface IProductRepository extends JpaRepository<Product, Long> {

}
