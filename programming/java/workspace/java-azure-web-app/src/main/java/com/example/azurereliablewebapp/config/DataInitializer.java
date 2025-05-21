package com.example.azurereliablewebapp.config;

import com.example.azurereliablewebapp.model.Product;
import com.example.azurereliablewebapp.repository.ProductRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;

import java.math.BigDecimal;
import java.util.Arrays;

@Configuration
public class DataInitializer {
    
    private static final Logger logger = LoggerFactory.getLogger(DataInitializer.class);
    
    @Autowired
    private ProductRepository productRepository;
    
    @Bean
    @Profile("!prod") // Only run in non-production environments
    public CommandLineRunner initializeData() {
        return args -> {
            logger.info("Initializing sample data");
            
            if (productRepository.count() == 0) {
                Product[] products = {
                    new Product("Laptop Pro", "High-performance laptop for professionals", new BigDecimal("1299.99"), 25, "Electronics"),
                    new Product("Smartphone X", "Next generation smartphone with advanced features", new BigDecimal("899.99"), 50, "Electronics"),
                    new Product("Wireless Headphones", "Noise-cancelling wireless headphones", new BigDecimal("199.99"), 100, "Audio"),
                    new Product("Coffee Maker", "Automatic coffee maker with timer", new BigDecimal("89.99"), 30, "Home Appliances"),
                    new Product("Fitness Tracker", "Water-resistant fitness tracker with heart rate monitor", new BigDecimal("79.99"), 75, "Fitness"),
                    new Product("Smart Watch", "Smart watch with health monitoring features", new BigDecimal("249.99"), 40, "Electronics"),
                    new Product("Gaming Console", "Latest generation gaming console", new BigDecimal("499.99"), 15, "Gaming"),
                    new Product("Wireless Charger", "Fast wireless charging pad", new BigDecimal("39.99"), 60, "Accessories"),
                    new Product("Bluetooth Speaker", "Portable waterproof Bluetooth speaker", new BigDecimal("129.99"), 45, "Audio"),
                    new Product("Tablet Pro", "Professional tablet with stylus support", new BigDecimal("799.99"), 35, "Electronics")
                };
                
                productRepository.saveAll(Arrays.asList(products));
                logger.info("Sample data initialized with {} products", products.length);
            } else {
                logger.info("Database already contains data, skipping initialization");
            }
        };
    }
}