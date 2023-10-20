package com.postgres.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.postgres.entity.Product;

public interface ProductRepository extends JpaRepository<Product, Long>{
	void deleteById(Long id);
}
