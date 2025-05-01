package com.example.azurereliablewebapp.service;

import com.example.azurereliablewebapp.model.Product;
import com.example.azurereliablewebapp.repository.ProductRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ProductService {
    
    private static final Logger logger = LoggerFactory.getLogger(ProductService.class);
    
    private final ProductRepository productRepository;
    
    @Autowired
    public ProductService(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }
    
    @Cacheable(value = "products")
    public List<Product> getAllProducts() {
        logger.info("Fetching all products from database");
        return productRepository.findAll();
    }
    
    @Cacheable(value = "product", key = "#id")
    public Optional<Product> getProductById(Long id) {
        logger.info("Fetching product with id: {}", id);
        return productRepository.findById(id);
    }
    
    @Cacheable(value = "productsByCategory", key = "#category")
    public List<Product> getProductsByCategory(String category) {
        logger.info("Fetching products with category: {}", category);
        return productRepository.findByCategory(category);
    }
    
    @Cacheable(value = "productsByName", key = "#name")
    public List<Product> searchProductsByName(String name) {
        logger.info("Searching products with name containing: {}", name);
        return productRepository.findByNameContainingIgnoreCase(name);
    }
    
    public Product saveProduct(Product product) {
        logger.info("Saving product: {}", product);
        return productRepository.save(product);
    }
    
    @CacheEvict(value = {"product", "products", "productsByCategory", "productsByName"}, allEntries = true)
    public void updateProduct(Product product) {
        logger.info("Updating product: {}", product);
        productRepository.save(product);
    }
    
    @CacheEvict(value = {"product", "products", "productsByCategory", "productsByName"}, allEntries = true)
    public void deleteProduct(Long id) {
        logger.info("Deleting product with id: {}", id);
        productRepository.deleteById(id);
    }
    
    public List<Product> getLowStockProducts(int threshold) {
        logger.info("Fetching products with stock quantity less than: {}", threshold);
        return productRepository.findByStockQuantityLessThan(threshold);
    }
}