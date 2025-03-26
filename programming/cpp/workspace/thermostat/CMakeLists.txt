cmake_minimum_required(VERSION 3.14)
project(thermostat VERSION 0.1.0 LANGUAGES CXX)

# Set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Include directories
include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}/include
)

# Add source files
file(GLOB_RECURSE SOURCES 
    "${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp"
)

# Create library
add_library(${PROJECT_NAME} STATIC ${SOURCES})

# Set include directories for the library
target_include_directories(${PROJECT_NAME} 
    PUBLIC 
        ${CMAKE_CURRENT_SOURCE_DIR}/include
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/src
)

# Add an example executable
add_executable(${PROJECT_NAME}_example examples/main.cpp)
target_link_libraries(${PROJECT_NAME}_example PRIVATE ${PROJECT_NAME})

# Enable testing
enable_testing()
add_subdirectory(tests)

# Install rules
install(TARGETS ${PROJECT_NAME}
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib
    RUNTIME DESTINATION bin
)
install(DIRECTORY include/ DESTINATION include)
