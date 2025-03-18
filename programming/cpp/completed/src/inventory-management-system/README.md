# Inventory Management System

This project implements a simple Inventory Management System in C++. It allows users to manage inventory items, including adding, removing, and displaying items.

## Project Structure

The project consists of the following files:

- **src/**
  - `InventoryItem.h`: Defines the `InventoryItem` class, which represents an item in the inventory.
  - `InventoryItem.cpp`: Implements the methods of the `InventoryItem` class.
  - `InventoryManager.h`: Defines the `InventoryManager` class, which manages a collection of `InventoryItem` objects.
  - `InventoryManager.cpp`: Implements the methods of the `InventoryManager` class.
  - `main.cpp`: The entry point of the application.

- `CMakeLists.txt`: Configuration file for CMake to build the project.
- `Makefile`: Used for building the project with the make build automation tool.
- `.gitignore`: Specifies files and directories to be ignored by Git.
- `README.md`: Documentation for the project.

## Getting Started

### Prerequisites

- A C++ compiler (e.g., g++, clang++)
- CMake (for building the project)
- Make (if using the Makefile)

### Building the Project

1. Clone the repository:
   ```
   git clone <repository-url>
   cd inventory-management-system
   ```

2. Build using CMake:
   ```
   mkdir build
   cd build
   cmake ..
   make
   ```

   Or, if using the Makefile:
   ```
   make
   ```

### Running the Application

After building the project, you can run the application with the following command:

```
./inventory_management_system
```

### Usage

The application allows you to manage inventory items. You can add items, remove them by name, and display the current inventory.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.

## License

This project is licensed under the MIT License. See the LICENSE file for details.