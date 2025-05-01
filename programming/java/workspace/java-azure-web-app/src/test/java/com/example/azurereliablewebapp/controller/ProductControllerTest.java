package com.example.azurereliablewebapp.controller;

import com.example.azurereliablewebapp.model.Product;
import com.example.azurereliablewebapp.service.ProductService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import static org.hamcrest.Matchers.hasSize;
import static org.hamcrest.Matchers.is;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.Mockito.doNothing;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(ProductController.class)
public class ProductControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private ProductService productService;

    @Test
    public void testGetAllProducts() throws Exception {
        // Prepare test data
        List<Product> products = Arrays.asList(
                new Product(1L, "Laptop Pro", "High-end laptop", new BigDecimal("1299.99"), 10, "Electronics"),
                new Product(2L, "Smartphone X", "Flagship smartphone", new BigDecimal("899.99"), 20, "Electronics")
        );

        // Mock service method
        when(productService.getAllProducts()).thenReturn(products);

        // Perform request and verify
        mockMvc.perform(get("/api/products"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$", hasSize(2)))
                .andExpect(jsonPath("$[0].id", is(1)))
                .andExpect(jsonPath("$[0].name", is("Laptop Pro")))
                .andExpect(jsonPath("$[1].id", is(2)))
                .andExpect(jsonPath("$[1].name", is("Smartphone X")));
    }

    @Test
    public void testGetProductById() throws Exception {
        // Prepare test data
        Product product = new Product(1L, "Laptop Pro", "High-end laptop", new BigDecimal("1299.99"), 10, "Electronics");

        // Mock service method
        when(productService.getProductById(anyLong())).thenReturn(Optional.of(product));

        // Perform request and verify
        mockMvc.perform(get("/api/products/1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.id", is(1)))
                .andExpect(jsonPath("$.name", is("Laptop Pro")))
                .andExpect(jsonPath("$.description", is("High-end laptop")))
                .andExpect(jsonPath("$.price", is(1299.99)))
                .andExpect(jsonPath("$.stockQuantity", is(10)))
                .andExpect(jsonPath("$.category", is("Electronics")));
    }

    @Test
    public void testGetProductByIdNotFound() throws Exception {
        // Mock service method
        when(productService.getProductById(anyLong())).thenReturn(Optional.empty());

        // Perform request and verify
        mockMvc.perform(get("/api/products/999"))
                .andExpect(status().isNotFound());
    }

    @Test
    public void testGetProductsByCategory() throws Exception {
        // Prepare test data
        List<Product> products = Arrays.asList(
                new Product(1L, "Laptop Pro", "High-end laptop", new BigDecimal("1299.99"), 10, "Electronics"),
                new Product(2L, "Smartphone X", "Flagship smartphone", new BigDecimal("899.99"), 20, "Electronics")
        );

        // Mock service method
        when(productService.getProductsByCategory("Electronics")).thenReturn(products);

        // Perform request and verify
        mockMvc.perform(get("/api/products/category/Electronics"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$", hasSize(2)))
                .andExpect(jsonPath("$[0].category", is("Electronics")))
                .andExpect(jsonPath("$[1].category", is("Electronics")));
    }

    @Test
    public void testDeleteProduct() throws Exception {
        // Mock service methods
        when(productService.getProductById(anyLong())).thenReturn(Optional.of(
                new Product(1L, "Laptop Pro", "High-end laptop", new BigDecimal("1299.99"), 10, "Electronics")));
        doNothing().when(productService).deleteProduct(anyLong());

        // Perform request and verify
        mockMvc.perform(delete("/api/products/1"))
                .andExpect(status().isNoContent());
    }

    @Test
    public void testLowStockProducts() throws Exception {
        // Prepare test data
        List<Product> products = Arrays.asList(
                new Product(1L, "Laptop Pro", "High-end laptop", new BigDecimal("1299.99"), 3, "Electronics"),
                new Product(2L, "Smartphone X", "Flagship smartphone", new BigDecimal("899.99"), 4, "Electronics")
        );

        // Mock service method
        when(productService.getLowStockProducts(5)).thenReturn(products);

        // Perform request and verify
        mockMvc.perform(get("/api/products/low-stock").param("threshold", "5"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$", hasSize(2)))
                .andExpect(jsonPath("$[0].stockQuantity", is(3)))
                .andExpect(jsonPath("$[1].stockQuantity", is(4)));
    }
}