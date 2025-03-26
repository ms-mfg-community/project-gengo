/**
 * @file main.cpp
 * @brief Example usage of the thermostat library
 */

#include <iostream>
#include "thermostat/thermostat.hpp"

int main() {
    // Create a thermostat instance
    thermostat::Thermostat thermostat(22.0);
    
    // Turn the thermostat on
    thermostat.turnOn();
    
    // Display current settings
    std::cout << "Thermostat is " << (thermostat.isOn() ? "on" : "off") << std::endl;
    std::cout << "Current temperature: " << thermostat.getCurrentTemperature() << "°C" << std::endl;
    std::cout << "Target temperature: " << thermostat.getTargetTemperature() << "°C" << std::endl;
    
    // Set a new target temperature
    thermostat.setTargetTemperature(24.5);
    std::cout << "New target temperature: " << thermostat.getTargetTemperature() << "°C" << std::endl;
    
    return 0;
}
