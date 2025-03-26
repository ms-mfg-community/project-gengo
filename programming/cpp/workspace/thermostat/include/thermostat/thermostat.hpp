/**
 * @file thermostat.hpp
 * @brief Main header file for the thermostat project
 */

#ifndef THERMOSTAT_HPP
#define THERMOSTAT_HPP

#include <string>
#include <vector>

namespace thermostat {

/**
 * @class Thermostat
 * @brief A class representing a programmable thermostat
 */
class Thermostat {
public:
    /**
     * @brief Default constructor
     */
    Thermostat();

    /**
     * @brief Constructor with initial temperature
     * @param initial_temp The initial temperature setting
     */
    explicit Thermostat(double initial_temp);

    /**
     * @brief Get the current temperature
     * @return Current temperature value
     */
    double getCurrentTemperature() const;

    /**
     * @brief Set the target temperature
     * @param temp Target temperature value
     */
    void setTargetTemperature(double temp);

    /**
     * @brief Get the target temperature
     * @return Target temperature value
     */
    double getTargetTemperature() const;

    /**
     * @brief Turn the thermostat on
     */
    void turnOn();

    /**
     * @brief Turn the thermostat off
     */
    void turnOff();

    /**
     * @brief Check if the thermostat is on
     * @return True if the thermostat is on, false otherwise
     */
    bool isOn() const;

private:
    double current_temperature_;
    double target_temperature_;
    bool is_on_;
};

} // namespace thermostat

#endif // THERMOSTAT_HPP
