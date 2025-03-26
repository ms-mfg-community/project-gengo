#!/usr/bin/env python
"""
C++ Project Setup Tool

This script creates a standardized C++ project directory structure
following best practices as defined in the project guidelines.
"""

import os
import sys
import shutil
from pathlib import Path
import argparse


def create_directory(path):
    """Create a directory if it doesn't exist."""
    os.makedirs(path, exist_ok=True)
    print(f"Created directory: {path}")


def create_file(path, content=""):
    """Create a file with the specified content."""
    with open(path, 'w') as file:
        file.write(content)
    print(f"Created file: {path}")


def create_cpp_project(project_name, base_dir="."):
    """
    Create a C++ project with standardized directory structure.
    
    Args:
        project_name: Name of the project
        base_dir: Base directory to create the project in
    """
    # Create project directory
    project_dir = os.path.join(base_dir, project_name)
    create_directory(project_dir)
    
    # Create standard directories
    dirs = [
        "build",
        "cmake",
        "docs",
        "examples",
        "external",
        f"include/{project_name}",
        "src",
        "src/internal",
        "tests",
        "scripts"
    ]
    
    for directory in dirs:
        create_directory(os.path.join(project_dir, directory))
    
    # Create basic files
    create_gitignore(project_dir)
    create_cmakelists(project_dir, project_name)
    create_readme(project_dir, project_name)
    create_license(project_dir)
    create_clang_format(project_dir)
    
    # Create basic source files
    create_header_file(project_dir, project_name)
    create_source_file(project_dir, project_name)
    create_test_file(project_dir, project_name)
    
    print(f"\nProject '{project_name}' created successfully at {project_dir}")
    print("\nNext steps:")
    print(f"1. cd {project_name}")
    print("2. mkdir build && cd build")
    print("3. cmake ..")
    print("4. cmake --build .")


def create_gitignore(project_dir):
    """Create a .gitignore file for C++ projects."""
    content = """# Build directories and binary files
build/
out/
cmake-build-*/
bin/
lib/

# IDE files
.vs/
.idea/
.vscode/
*.swp
*.swo
*~

# Compiled Object files
*.slo
*.lo
*.o
*.obj

# Precompiled Headers
*.gch
*.pch

# Compiled Dynamic libraries
*.so
*.dylib
*.dll

# Compiled Static libraries
*.lai
*.la
*.a
*.lib

# Executables
*.exe
*.out
*.app

# CMake
CMakeCache.txt
CMakeFiles/
CMakeScripts/
Testing/
Makefile
cmake_install.cmake
install_manifest.txt
compile_commands.json
CTestTestfile.cmake
_deps/

# User specific files
.DS_Store
"""
    create_file(os.path.join(project_dir, ".gitignore"), content)


def create_cmakelists(project_dir, project_name):
    """Create a CMakeLists.txt file for the project."""
    content = f"""cmake_minimum_required(VERSION 3.14)
project({project_name} VERSION 0.1.0 LANGUAGES CXX)

# Set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Include directories
include_directories(
    ${{CMAKE_CURRENT_SOURCE_DIR}}/include
)

# Add source files
file(GLOB_RECURSE SOURCES 
    "${{CMAKE_CURRENT_SOURCE_DIR}}/src/*.cpp"
)

# Create library
add_library(${{PROJECT_NAME}} STATIC ${{SOURCES}})

# Set include directories for the library
target_include_directories(${{PROJECT_NAME}} 
    PUBLIC 
        ${{CMAKE_CURRENT_SOURCE_DIR}}/include
    PRIVATE
        ${{CMAKE_CURRENT_SOURCE_DIR}}/src
)

# Add an example executable
add_executable(${{PROJECT_NAME}}_example examples/main.cpp)
target_link_libraries(${{PROJECT_NAME}}_example PRIVATE ${{PROJECT_NAME}})

# Enable testing
enable_testing()
add_subdirectory(tests)

# Install rules
install(TARGETS ${{PROJECT_NAME}}
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib
    RUNTIME DESTINATION bin
)
install(DIRECTORY include/ DESTINATION include)
"""
    create_file(os.path.join(project_dir, "CMakeLists.txt"), content)
    
    # Create CMakeLists.txt for tests directory
    test_cmakelists = f"""# Tests CMakeLists.txt
find_package(GTest QUIET)

if(NOT GTEST_FOUND)
    # Download and build GoogleTest
    include(FetchContent)
    FetchContent_Declare(
        googletest
        GIT_REPOSITORY https://github.com/google/googletest.git
        GIT_TAG main
    )
    set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
    FetchContent_MakeAvailable(googletest)
endif()

# Add test executable
add_executable(test_${{PROJECT_NAME}} test_{project_name.lower()}.cpp)

target_link_libraries(test_${{PROJECT_NAME}}
    PRIVATE
        ${{PROJECT_NAME}}
        GTest::gtest_main
)

add_test(NAME ${{PROJECT_NAME}}_test COMMAND test_${{PROJECT_NAME}})
"""
    create_file(os.path.join(project_dir, "tests", "CMakeLists.txt"), test_cmakelists)


def create_readme(project_dir, project_name):
    """Create a README.md file."""
    content = f"""# {project_name}

## Overview
A C++ thermostat control system project.

## Features
- Feature 1
- Feature 2

## Building the Project

### Prerequisites
- C++17 compatible compiler
- CMake (version 3.14 or higher)
- Git

### Build Instructions
```bash
# Clone the repository
git clone <repository-url>
cd {project_name}

# Create build directory
mkdir build && cd build

# Configure with CMake
cmake ..

# Build
cmake --build .
```

### Running Tests
```bash
cd build
ctest
```

## Usage
```cpp
#include <{project_name}/{project_name.lower()}.hpp>

int main() {{
    // Example code
    return 0;
}}
```

## License
This project is licensed under the MIT License - see the LICENSE file for details.
"""
    create_file(os.path.join(project_dir, "README.md"), content)


def create_license(project_dir):
    """Create an MIT License file."""
    content = """MIT License

Copyright (c) 2025

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
"""
    create_file(os.path.join(project_dir, "LICENSE"), content)


def create_clang_format(project_dir):
    """Create a .clang-format file."""
    content = """---
BasedOnStyle: Google
IndentWidth: 4
TabWidth: 4
UseTab: Never
ColumnLimit: 100
NamespaceIndentation: All
AccessModifierOffset: -4
AlignAfterOpenBracket: Align
AlignConsecutiveAssignments: true
AlignConsecutiveDeclarations: true
AllowShortFunctionsOnASingleLine: Empty
AllowShortIfStatementsOnASingleLine: false
AllowShortLoopsOnASingleLine: false
BreakBeforeBraces: Stroustrup
---
"""
    create_file(os.path.join(project_dir, ".clang-format"), content)


def create_header_file(project_dir, project_name):
    """Create a sample header file."""
    project_lower = project_name.lower()
    content = f"""/**
 * @file {project_lower}.hpp
 * @brief Main header file for the {project_name} project
 */

#ifndef {project_name.upper()}_HPP
#define {project_name.upper()}_HPP

#include <string>
#include <vector>

namespace {project_lower} {{

/**
 * @class Thermostat
 * @brief A class representing a programmable thermostat
 */
class Thermostat {{
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
}};

}} // namespace {project_lower}

#endif // {project_name.upper()}_HPP
"""
    create_file(os.path.join(project_dir, f"include/{project_name}/{project_lower}.hpp"), content)


def create_source_file(project_dir, project_name):
    """Create a sample source file."""
    project_lower = project_name.lower()
    content = f"""/**
 * @file {project_lower}.cpp
 * @brief Implementation of the Thermostat class
 */

#include "{project_name}/{project_lower}.hpp"
#include <algorithm>

namespace {project_lower} {{

Thermostat::Thermostat()
    : current_temperature_(20.0), target_temperature_(20.0), is_on_(false)
{{
}}

Thermostat::Thermostat(double initial_temp)
    : current_temperature_(initial_temp), 
      target_temperature_(initial_temp),
      is_on_(false)
{{
}}

double Thermostat::getCurrentTemperature() const
{{
    return current_temperature_;
}}

void Thermostat::setTargetTemperature(double temp)
{{
    // Ensure temperature is in a reasonable range
    target_temperature_ = std::clamp(temp, 5.0, 35.0);
}}

double Thermostat::getTargetTemperature() const
{{
    return target_temperature_;
}}

void Thermostat::turnOn()
{{
    is_on_ = true;
}}

void Thermostat::turnOff()
{{
    is_on_ = false;
}}

bool Thermostat::isOn() const
{{
    return is_on_;
}}

}} // namespace {project_lower}
"""
    create_file(os.path.join(project_dir, f"src/{project_lower}.cpp"), content)

    # Create an example main.cpp file
    example_content = f"""/**
 * @file main.cpp
 * @brief Example usage of the {project_name} library
 */

#include <iostream>
#include "{project_name}/{project_lower}.hpp"

int main() {{
    // Create a thermostat instance
    {project_lower}::Thermostat thermostat(22.0);
    
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
}}
"""
    create_file(os.path.join(project_dir, f"examples/main.cpp"), example_content)


def create_test_file(project_dir, project_name):
    """Create a test file using Google Test."""
    project_lower = project_name.lower()
    content = f"""/**
 * @file test_{project_lower}.cpp
 * @brief Test file for the {project_name} project
 */

#include <gtest/gtest.h>
#include "{project_name}/{project_lower}.hpp"

// Test fixture for Thermostat tests
class ThermostatTest : public ::testing::Test {{
protected:
    void SetUp() override {{
        // Initialize with default temperature (20.0)
        default_thermostat = new {project_lower}::Thermostat();
        
        // Initialize with custom temperature
        custom_thermostat = new {project_lower}::Thermostat(25.0);
    }}

    void TearDown() override {{
        delete default_thermostat;
        delete custom_thermostat;
    }}

    {project_lower}::Thermostat* default_thermostat;
    {project_lower}::Thermostat* custom_thermostat;
}};

// Test the default constructor
TEST_F(ThermostatTest, DefaultConstructor) {{
    EXPECT_EQ(default_thermostat->getCurrentTemperature(), 20.0);
    EXPECT_EQ(default_thermostat->getTargetTemperature(), 20.0);
    EXPECT_FALSE(default_thermostat->isOn());
}}

// Test the parameterized constructor
TEST_F(ThermostatTest, ParameterizedConstructor) {{
    EXPECT_EQ(custom_thermostat->getCurrentTemperature(), 25.0);
    EXPECT_EQ(custom_thermostat->getTargetTemperature(), 25.0);
    EXPECT_FALSE(custom_thermostat->isOn());
}}

// Test temperature setting
TEST_F(ThermostatTest, TemperatureSetting) {{
    custom_thermostat->setTargetTemperature(30.0);
    EXPECT_EQ(custom_thermostat->getTargetTemperature(), 30.0);
    
    // Test the temperature clamping (below minimum)
    custom_thermostat->setTargetTemperature(0.0);
    EXPECT_EQ(custom_thermostat->getTargetTemperature(), 5.0);
    
    // Test the temperature clamping (above maximum)
    custom_thermostat->setTargetTemperature(40.0);
    EXPECT_EQ(custom_thermostat->getTargetTemperature(), 35.0);
}}

// Test power on/off functionality
TEST_F(ThermostatTest, PowerToggle) {{
    EXPECT_FALSE(default_thermostat->isOn());
    
    default_thermostat->turnOn();
    EXPECT_TRUE(default_thermostat->isOn());
    
    default_thermostat->turnOff();
    EXPECT_FALSE(default_thermostat->isOn());
}}
"""
    create_file(os.path.join(project_dir, f"tests/test_{project_lower}.cpp"), content)


def main():
    """Main function to parse arguments and create the project."""
    parser = argparse.ArgumentParser(description='Create a C++ project structure.')
    parser.add_argument('--name', default='thermostat', help='Name of the project')
    parser.add_argument('--dir', default='.', help='Base directory to create the project in')
    
    args = parser.parse_args()
    
    create_cpp_project(args.name, args.dir)


if __name__ == "__main__":
    main()