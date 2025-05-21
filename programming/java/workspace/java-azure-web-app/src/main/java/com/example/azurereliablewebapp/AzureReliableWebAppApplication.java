package com.example.azurereliablewebapp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@EnableCaching
@EnableJpaRepositories
public class AzureReliableWebAppApplication {

    public static void main(String[] args) {
        SpringApplication.run(AzureReliableWebAppApplication.class, args);
    }
}