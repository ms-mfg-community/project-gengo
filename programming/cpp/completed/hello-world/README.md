# Hello World Application

A simple C++ application that prints "Hello, World!" to the console.

## Building the Application

### Using CMake

```bash
# Create a build directory
mkdir build && cd build

# Configure and build
cmake ..
cmake --build .
```

### Using G++

```bash
g++ -std=c++11 src/main.cpp -o hello_world
```

## Running the Application

```bash
# If built with CMake
./HelloWorld  # Linux/Mac
.\HelloWorld.exe  # Windows

# If built with G++
./hello_world  # Linux/Mac
.\hello_world.exe  # Windows
```

## Requirements
- C++11 compatible compiler
- CMake 3.10 or higher (optional)