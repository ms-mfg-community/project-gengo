# CMakeLists.txt

cmake_minimum_required(VERSION 3.10)

# Set the project name
project(InventoryManagementSystem)

# Set the C++ standard
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# Add the executable
add_executable(InventoryManagementSystem
    src/InventoryItem.cpp
    src/InventoryManager.cpp
    src/main.cpp
)

# Include directories
target_include_directories(InventoryManagementSystem PRIVATE src)