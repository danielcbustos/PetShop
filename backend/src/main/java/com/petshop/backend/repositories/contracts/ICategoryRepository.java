package com.petshop.backend.repositories.contracts;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;

import com.petshop.backend.entities.Category;

public interface ICategoryRepository extends JpaRepository<Category, Long> {
    public Category findByNameIgnoreCase(@Param("name") String name);
}
