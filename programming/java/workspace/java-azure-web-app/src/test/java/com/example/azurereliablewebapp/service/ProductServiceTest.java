package com.example.azurereliablewebapp.service;

import com.example.azurereliablewebapp.model.Product;
import com.example.azurereliablewebapp.repository.ProductRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.Mockito.*;

class ProductServiceTest {

    @Mock
    private ProductRepository productRepository;

    @InjectMocks
    private ProductService productService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void getAllProducts() {
        // Prepare test data
        List<Product> products = Arrays.asList(
                new Product(1L, "Product 1", "Description 1", new BigDecimal("10.00"), 5, "Category 1"),
                new Product(2L, "Product 2", "Description 2", new BigDecimal("20.00"), 10, "Category 2")
        );

        // Mock repository method
        when(productRepository.findAll()).thenReturn(products);

        // Call service method
        List<Product> result = productService.getAllProducts();

        // Verify
        assertEquals(2, result.size());
        assertEquals("Product 1", result.get(0).getName());
        assertEquals("Product 2", result.get(1).getName());
        verify(productRepository, times(1)).findAll();
    }

    @Test
    void getProductById() {
        // Prepare test data
        Product product = new Product(1L, "Product 1", "Description 1", new BigDecimal("10.00"), 5, "Category 1");
        
        // Mock repository method
        when(productRepository.findById(1L)).thenReturn(Optional.of(product));
        when(productRepository.findById(2L)).thenReturn(Optional.empty());

        // Call service method
        Optional<Product> foundProduct = productService.getProductById(1L);
        Optional<Product> notFoundProduct = productService.getProductById(2L);

        // Verify
        assertTrue(foundProduct.isPresent());
        assertEquals("Product 1", foundProduct.get().getName());
        assertFalse(notFoundProduct.isPresent());
        verify(productRepository, times(1)).findById(1L);
        verify(productRepository, times(1)).findById(2L);
    }

    @Test
    void getProductsByCategory() {
        // Prepare test data
        List<Product> products = Arrays.asList(
                new Product(1L, "Product 1", "Description 1", new BigDecimal("10.00"), 5, "Electronics"),
                new Product(2L, "Product 2", "Description 2", new BigDecimal("20.00"), 10, "Electronics")
        );

        // Mock repository method
        when(productRepository.findByCategory("Electronics")).thenReturn(products);

        // Call service method
        List<Product> result = productService.getProductsByCategory("Electronics");

        // Verify
        assertEquals(2, result.size());
        assertEquals("Electronics", result.get(0).getCategory());
        assertEquals("Electronics", result.get(1).getCategory());
        verify(productRepository, times(1)).findByCategory("Electronics");
    }

    @Test
    void saveProduct() {
        // Prepare test data
        Product product = new Product(null, "New Product", "New Description", new BigDecimal("15.00"), 8, "New Category");
        Product savedProduct = new Product(1L, "New Product", "New Description", new BigDecimal("15.00"), 8, "New Category");

        // Mock repository method
        when(productRepository.save(any(Product.class))).thenReturn(savedProduct);

        // Call service method
        Product result = productService.saveProduct(product);

        // Verify
        assertNotNull(result);
        assertEquals(1L, result.getId());
        assertEquals("New Product", result.getName());
        verify(productRepository, times(1)).save(product);
    }

    @Test
    void deleteProduct() {
        // Call service method
        productService.deleteProduct(1L);

        // Verify
        verify(productRepository, times(1)).deleteById(1L);
    }

    @Test
    void getLowStockProducts() {
        // Prepare test data
        List<Product> products = Arrays.asList(
                new Product(1L, "Product 1", "Description 1", new BigDecimal("10.00"), 3, "Category 1"),
                new Product(2L, "Product 2", "Description 2", new BigDecimal("20.00"), 4, "Category 2")
        );

        // Mock repository method
        when(productRepository.findByStockQuantityLessThan(5)).thenReturn(products);

        // Call service method
        List<Product> result = productService.getLowStockProducts(5);

        // Verify
        assertEquals(2, result.size());
        assertTrue(result.get(0).getStockQuantity() < 5);
        assertTrue(result.get(1).getStockQuantity() < 5);
        verify(productRepository, times(1)).findByStockQuantityLessThan(5);
    }
}