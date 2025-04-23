# CMakeLists.txt

cmake_minimum_required(VERSION 3.10)

# Set the project name
project(InventoryManagementSystem)

# Set the C++ standard
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# Add the executable
add_executable(InventoryManagementSystem
    programming/cpp/completed/inventory-management-system/src/InventoryItem.cpp
    programming/cpp/completed/inventory-management-system/src/InventoryManager.cpp
    programming/cpp/completed/inventory-management-system/src/main.cpp
)

# Include directories
target_include_directories(InventoryManagementSystem PRIVATE programming/cpp/completed/inventory-management-system/src)