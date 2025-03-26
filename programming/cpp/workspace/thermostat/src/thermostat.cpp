/**
 * @file thermostat.cpp
 * @brief Implementation of the Thermostat class
 */

#include "thermostat/thermostat.hpp"
#include <algorithm>

namespace thermostat {

Thermostat::Thermostat()
    : current_temperature_(20.0), target_temperature_(20.0), is_on_(false)
{
}

Thermostat::Thermostat(double initial_temp)
    : current_temperature_(initial_temp), 
      target_temperature_(initial_temp),
      is_on_(false)
{
}

double Thermostat::getCurrentTemperature() const
{
    return current_temperature_;
}

void Thermostat::setTargetTemperature(double temp)
{
    // Ensure temperature is in a reasonable range
    target_temperature_ = std::clamp(temp, 5.0, 35.0);
}

double Thermostat::getTargetTemperature() const
{
    return target_temperature_;
}

void Thermostat::turnOn()
{
    is_on_ = true;
}

void Thermostat::turnOff()
{
    is_on_ = false;
}

bool Thermostat::isOn() const
{
    return is_on_;
}

} // namespace thermostat
