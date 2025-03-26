/**
 * @file test_thermostat.cpp
 * @brief Test file for the thermostat project
 */

#include <gtest/gtest.h>
#include "thermostat/thermostat.hpp"

// Test fixture for Thermostat tests
class ThermostatTest : public ::testing::Test {
protected:
    void SetUp() override {
        // Initialize with default temperature (20.0)
        default_thermostat = new thermostat::Thermostat();
        
        // Initialize with custom temperature
        custom_thermostat = new thermostat::Thermostat(25.0);
    }

    void TearDown() override {
        delete default_thermostat;
        delete custom_thermostat;
    }

    thermostat::Thermostat* default_thermostat;
    thermostat::Thermostat* custom_thermostat;
};

// Test the default constructor
TEST_F(ThermostatTest, DefaultConstructor) {
    EXPECT_EQ(default_thermostat->getCurrentTemperature(), 20.0);
    EXPECT_EQ(default_thermostat->getTargetTemperature(), 20.0);
    EXPECT_FALSE(default_thermostat->isOn());
}

// Test the parameterized constructor
TEST_F(ThermostatTest, ParameterizedConstructor) {
    EXPECT_EQ(custom_thermostat->getCurrentTemperature(), 25.0);
    EXPECT_EQ(custom_thermostat->getTargetTemperature(), 25.0);
    EXPECT_FALSE(custom_thermostat->isOn());
}

// Test temperature setting
TEST_F(ThermostatTest, TemperatureSetting) {
    custom_thermostat->setTargetTemperature(30.0);
    EXPECT_EQ(custom_thermostat->getTargetTemperature(), 30.0);
    
    // Test the temperature clamping (below minimum)
    custom_thermostat->setTargetTemperature(0.0);
    EXPECT_EQ(custom_thermostat->getTargetTemperature(), 5.0);
    
    // Test the temperature clamping (above maximum)
    custom_thermostat->setTargetTemperature(40.0);
    EXPECT_EQ(custom_thermostat->getTargetTemperature(), 35.0);
}

// Test power on/off functionality
TEST_F(ThermostatTest, PowerToggle) {
    EXPECT_FALSE(default_thermostat->isOn());
    
    default_thermostat->turnOn();
    EXPECT_TRUE(default_thermostat->isOn());
    
    default_thermostat->turnOff();
    EXPECT_FALSE(default_thermostat->isOn());
}
