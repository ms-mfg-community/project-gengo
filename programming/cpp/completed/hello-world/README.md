# Hello World Application

A simple C++ application that prints "Hello, World!" to the console.
\n\nBuilding the Application
\n\nUsing CMake

```bash\n\nCreate a build directory
mkdir build && cd build
\n\nConfigure and build
cmake ..
cmake --build .
```
\n\nUsing G++

```bash
g++ -std=c++11 src/main.cpp -o hello_world
```
\n\nRunning the Application

```bash\n\nIf built with CMake
./HelloWorld  # Linux/Mac
.\HelloWorld.exe  # Windows
\n\nIf built with G++
./hello_world  # Linux/Mac
.\hello_world.exe  # Windows
```
\n\nRequirements
\n\nC++11 compatible compiler\n\nCMake 3.10 or higher (optional)
\n
