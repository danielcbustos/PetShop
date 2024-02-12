package com.petshop.backend.entities;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
@Entity
@Table(name = "product")
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;
    @Column(name = "name", nullable = false)
    private String name;
    @Column(name = "description", nullable = false)
    private String description;
    @Column(name = "price", nullable = false)
    private double price;
    @Column(name = "image", nullable = false)
    private String image;

    // @ManyToMany(fetch = FetchType.LAZY, cascade = CascadeType.REMOVE)
    // @JoinTable(name = "productCategory", joinColumns = @JoinColumn(name =
    // "product_id", referencedColumnName = "id"), inverseJoinColumns =
    // @JoinColumn(name = "category_id", referencedColumnName = "id"))
    // @JsonIgnoreProperties("products")
    // private List<Category> categories;
}
