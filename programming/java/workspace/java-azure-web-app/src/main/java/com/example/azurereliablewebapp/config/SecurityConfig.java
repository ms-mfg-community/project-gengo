package com.example.azurereliablewebapp.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.oauth2.client.registration.ClientRegistrationRepository;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Value("${azure.activedirectory.tenant-id:}")
    private String tenantId;

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http, 
                                                  ClientRegistrationRepository clientRegistrationRepository) throws Exception {
        // Only configure AAD if tenant ID is configured
        if (tenantId != null && !tenantId.isBlank()) {
            http
                .authorizeHttpRequests(authorize -> authorize
                    .requestMatchers("/", "/home", "/error", "/webjars/**", "/actuator/**").permitAll()
                    .anyRequest().authenticated())
                .oauth2Login(oauth2 -> oauth2
                    .clientRegistrationRepository(clientRegistrationRepository))
                .oauth2ResourceServer(oauth2 -> oauth2
                    .jwt());
        } else {
            // Development mode - no authentication
            http
                .authorizeHttpRequests(authorize -> authorize
                    .anyRequest().permitAll())
                .csrf(csrf -> csrf.disable());
        }
        
        return http.build();
    }
}