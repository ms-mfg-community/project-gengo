package com.example.azurereliablewebapp.config;

import io.micrometer.azuremonitor.AzureMonitorConfig;
import io.micrometer.azuremonitor.AzureMonitorMeterRegistry;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.actuate.autoconfigure.metrics.MeterRegistryCustomizer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;

import java.time.Duration;

@Configuration
public class MonitoringConfig {
    
    @Value("${azure.application-insights.instrumentation-key:}")
    private String instrumentationKey;
    
    @Bean
    public MeterRegistryCustomizer<AzureMonitorMeterRegistry> azureMeterRegistryCustomizer(Environment environment) {
        return registry -> {
            registry.config().commonTags(
                "application", environment.getProperty("spring.application.name", "azure-reliable-webapp"),
                "environment", environment.getProperty("AZURE_ENVIRONMENT", "development")
            );
        };
    }
    
    @Bean
    public AzureMonitorConfig azureConfig() {
        return new AzureMonitorConfig() {
            @Override
            public String get(String key) {
                return null;
            }
            
            @Override
            public String instrumentationKey() {
                return instrumentationKey;
            }
            
            @Override
            public Duration step() {
                return Duration.ofSeconds(60);
            }
        };
    }
}