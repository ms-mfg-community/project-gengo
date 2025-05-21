package com.example.azurereliablewebapp.controller;

import com.example.azurereliablewebapp.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    private final ProductService productService;
    
    @Value("${spring.application.name}")
    private String applicationName;

    @Autowired
    public HomeController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("products", productService.getAllProducts());
        return "home";
    }
    
    @GetMapping("/health")
    public String healthCheck(Model model) {
        model.addAttribute("applicationName", applicationName);
        return "health";
    }
}