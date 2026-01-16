# C++ Inventory Management System with VS Code

This document provides a series of prompts to recreate a simple inventory management system in C++ using Visual Studio Code. Each prompt includes the required instructions and code snippets to build the complete solution.
\n\nProject Setup
\n\nPrompt 1: Setting up the project structure

```
Create a new C++ inventory management system project in VS Code with the following structure:\n\nCreate a folder named "inventory-management-system" with a subfolder "src"\n\nSet up VS Code to use g++ compiler with C++17 support\n\nCreate a .vscode folder inside the src directory for VS Code configuration\n\nCreate tasks.json for building the project
```
\n\nPrompt 2: Create tasks.json configuration

```
Create a tasks.json file in the .vscode folder with configurations for both single-file compilation and multi-file compilation using g++. Include support for both MSVC (cl.exe) and GCC (g++). Use proper warning flags and C++17 standard support.
```
\n\nImplementing the Core Classes
\n\nPrompt 3: Create the InventoryItem class header

```
Create an InventoryItem.h file that defines a class to represent individual inventory items. Include properties for name, quantity, price, ID, and category. Implement getters and setters for all properties and include a method to update quantity. Use proper header guards and documentation comments.
```
\n\nPrompt 4: Implement the InventoryItem class

```
Create an InventoryItem.cpp file that implements all the methods from the InventoryItem.h header. Include a static variable for generating unique IDs. Implement constructors, getters, setters, and the updateQuantity method that prevents quantities from going below zero.
```
\n\nPrompt 5: Create the InventoryManager class header

```
Create an InventoryManager.h file that defines a class to manage a collection of inventory items. Include methods for adding, removing, finding, and displaying items. Use a vector to store the items and include proper header guards and documentation comments.
```
\n\nPrompt 6: Implement the InventoryManager class

```
Create an InventoryManager.cpp file that implements all the methods from the InventoryManager.h header. Include implementations for adding items (with duplicate handling), removing items, finding items by name, and displaying formatted inventory lists.
```
\n\nPrompt 7: Create the main application

```
Create a main.cpp file that demonstrates the functionality of the inventory management system. Implement a menu-driven interface with options for adding, removing, finding, and displaying items. Include input validation and a clean user interface.
```
\n\nCode Implementation
\n\nFor InventoryItem.h

```cpp
/**\n\n@file InventoryItem.h\n\n@brief Header file defining the InventoryItem class for representing individual inventory items\n\n* This class represents a single item in the inventory with properties such as\n\nname, quantity, price, and other relevant attributes.
 */
#ifndef INVENTORYITEM_H  // Include guard to prevent multiple inclusion
#define INVENTORYITEM_H  // Define the include guard macro
#include <string>        // Include the string library for std::string support
/**\n\n@class InventoryItem\n\n@brief Represents a single item in the inventory system
 */
class InventoryItem {
private:
    /** Name of the inventory item */
    std::string name;

    /** Current quantity of the item in inventory */
    int quantity;

    /** Price per unit of the item */
    double price;

    /** Unique identifier for the item */
    int id;

    /** Category or type of the item */
    std::string category;
public:
    /**\n\n@brief Default constructor
     */
    InventoryItem();

    /**\n\n@brief Parameterized constructor\n\n@param name Name of the item\n\n@param quantity Initial quantity\n\n@param price Price per unit\n\n@param category Category of the item
     */
    InventoryItem(const std::string& name, int quantity, double price, const std::string& category);

    /**\n\n@brief Get the name of the item\n\n@return Name of the item as string
     */
    std::string getName() const;

    /**\n\n@brief Get the current quantity\n\n@return Quantity as integer
     */
    int getQuantity() const;

    /**\n\n@brief Get the price per unit\n\n@return Price as double
     */
    double getPrice() const;

    /**\n\n@brief Get the unique identifier\n\n@return ID as integer
     */
    int getId() const;

    /**\n\n@brief Get the category\n\n@return Category as string
     */
    std::string getCategory() const;

    /**\n\n@brief Set a new name for the item\n\n@param name New name to set
     */
    void setName(const std::string& name);

    /**\n\n@brief Set a new quantity\n\n@param quantity New quantity to set
     */
    void setQuantity(int quantity);

    /**\n\n@brief Set a new price\n\n@param price New price to set
     */
    void setPrice(double price);

    /**\n\n@brief Set a new category\n\n@param category New category to set
     */
    void setCategory(const std::string& category);

    /**\n\n@brief Add to the current quantity\n\n@param amount Amount to add (can be negative for subtraction)
     */
    void updateQuantity(int amount);
};
#endif // INVENTORYITEM_H
```
\n\nFor InventoryItem.cpp

```cpp
/**\n\n@file InventoryItem.cpp\n\n@brief Implementation of the InventoryItem class\n\n* Contains the implementation of all methods declared in InventoryItem.h
 */
#include "InventoryItem.h"  // Include the header file that defines the InventoryItem class
#include <iostream>         // Include standard I/O for warning messages in updateQuantity
// Static ID counter to ensure each item gets a unique identifier
static int nextId = 1;
/**\n\nDefault constructor initializes with empty values
 */
InventoryItem::InventoryItem() : name(""), quantity(0), price(0.0), id(nextId++), category("") {
    // Empty body as initialization is done in the initializer list
}
/**\n\nParameterized constructor initializes with provided values\n\n@param name Name of the item\n\n@param quantity Initial quantity\n\n@param price Price per unit\n\n@param category Category of the item
 */
InventoryItem::InventoryItem(const std::string& name, int quantity, double price, const std::string& category)
    : name(name), quantity(quantity), price(price), id(nextId++), category(category) {
    // Empty body as initialization is done in the initializer list
}
/**\n\nReturns the name of the inventory item\n\n@return Name as string
 */
std::string InventoryItem::getName() const {
    return name;
}
/**\n\nReturns the current quantity of the item\n\n@return Quantity as integer
 */
int InventoryItem::getQuantity() const {
    return quantity;
}
/**\n\nReturns the price per unit of the item\n\n@return Price as double
 */
double InventoryItem::getPrice() const {
    return price;
}
/**\n\nReturns the unique identifier of the item\n\n@return ID as integer
 */
int InventoryItem::getId() const {
    return id;
}
/**\n\nReturns the category of the item\n\n@return Category as string
 */
std::string InventoryItem::getCategory() const {
    return category;
}
/**\n\nSets a new name for the item\n\n@param name New name to set
 */
void InventoryItem::setName(const std::string& name) {
    this->name = name;
}
/**\n\nSets a new quantity for the item\n\n@param quantity New quantity to set
 */
void InventoryItem::setQuantity(int quantity) {
    this->quantity = quantity;
}
/**\n\nSets a new price for the item\n\n@param price New price to set
 */
void InventoryItem::setPrice(double price) {
    this->price = price;
}
/**\n\nSets a new category for the item\n\n@param category New category to set
 */
void InventoryItem::setCategory(const std::string& category) {
    this->category = category;
}
/**\n\nUpdates the quantity by adding the specified amount (negative to subtract)\n\n@param amount Amount to add or subtract from current quantity
 */
void InventoryItem::updateQuantity(int amount) {
    quantity += amount;
    // Ensure quantity doesn't go below zero
    if (quantity < 0) {
        std::cout << "Warning: Quantity for " << name << " went below zero and was reset to 0." << std::endl;
        quantity = 0;
    }
}
```
\n\nFor InventoryManager.h

```cpp
/**\n\n@file InventoryManager.h\n\n@brief Header file defining the InventoryManager class for inventory management operations\n\n* This class provides functionality to manage a collection of inventory items including\n\nadding, removing, searching, and displaying items in the inventory.
 */
#ifndef INVENTORYMANAGER_H   // Header guard start - prevents multiple inclusion of this header file
#define INVENTORYMANAGER_H   // Define the guard macro for this header
#include "InventoryItem.h" // Include the InventoryItem class definition
#include <vector>          // Include the STL vector container for storing items
/**\n\n@class InventoryManager\n\n@brief Manages a collection of inventory items and operations on them
 */
class InventoryManager {
private:
    /** Vector container storing all inventory items */
    std::vector<InventoryItem> items;
public:
    /**\n\n@brief Adds a new item to the inventory\n\n@param item The InventoryItem object to be added to inventory
     */
    void addItem(const InventoryItem& item);

    /**\n\n@brief Removes an item from the inventory based on its name\n\n@param name The name of the item to be removed
     */
    void removeItem(const std::string& name);

    /**\n\n@brief Searches for an item in the inventory by name\n\n@param name The name of the item to find\n\n@return Pointer to the found item or nullptr if not found
     */
    InventoryItem* findItem(const std::string& name);

    /**\n\n@brief Displays all items currently in the inventory
     */
    void displayInventory() const;
};
#endif // INVENTORYMANAGER_H
```
\n\nFor InventoryManager.cpp

```cpp
/**\n\n@file InventoryManager.cpp\n\n@brief Implementation of the InventoryManager class\n\n* Contains the implementation of all methods declared in InventoryManager.h
 */
#include "InventoryManager.h"  // Include header containing the InventoryManager class declaration
#include <iostream>            // Include for console input/output operations (std::cout, std::endl)
#include <algorithm>           // Include for std::find_if algorithm used in search operations
#include <iomanip>             // Include for output formatting utilities like std::setw and std::left
/**\n\nAdds a new item to the inventory\n\nIf an item with the same name already exists, its quantity will be updated instead\n\n@param item The InventoryItem object to be added to inventory
 */
void InventoryManager::addItem(const InventoryItem& item) {
    // Check if an item with this name already exists
    InventoryItem* existingItem = findItem(item.getName());

    if (existingItem != nullptr) {
        // Item exists, update its quantity
        existingItem->updateQuantity(item.getQuantity());
        std::cout << "Updated quantity of existing item: " << item.getName() << std::endl;
    } else {
        // Add as new item
        items.push_back(item);
        std::cout << "Added new item: " << item.getName() << std::endl;
    }
}
/**\n\nRemoves an item from the inventory based on its name\n\n@param name The name of the item to be removed
 */
void InventoryManager::removeItem(const std::string& name) {
    // Find the item by name using lambda expression
    auto it = std::find_if(items.begin(), items.end(),
                          [&name](const InventoryItem& item) { return item.getName() == name; });

    if (it != items.end()) {
        // Item found, remove it
        items.erase(it);
        std::cout << "Item removed: " << name << std::endl;
    } else {
        // Item not found
        std::cout << "Item not found: " << name << std::endl;
    }
}
/**\n\nSearches for an item in the inventory by name\n\n@param name The name of the item to find\n\n@return Pointer to the found item or nullptr if not found
 */
InventoryItem* InventoryManager::findItem(const std::string& name) {
    // Find the item by name using lambda expression
    auto it = std::find_if(items.begin(), items.end(),
                          [&name](const InventoryItem& item) { return item.getName() == name; });

    if (it != items.end()) {
        // Item found, return pointer to it
        return &(*it);
    } else {
        // Item not found
        return nullptr;
    }
}
/**\n\nDisplays all items currently in the inventory\n\nPrints each item's details to the console
 */
void InventoryManager::displayInventory() const {
    if (items.empty()) {
        std::cout << "Inventory is empty." << std::endl;
        return;
    }

    std::cout << "==== Current Inventory ====" << std::endl;
    std::cout << "--------------------------" << std::endl;

    // Display header
    std::cout << std::left << std::setw(5) << "ID"
              << std::setw(20) << "Name"
              << std::setw(10) << "Quantity"
              << std::setw(10) << "Price"
              << std::setw(15) << "Category" << std::endl;
    std::cout << "--------------------------" << std::endl;

    // Display each item
    for (const auto& item : items) {
        std::cout << std::left << std::setw(5) << item.getId()
                  << std::setw(20) << item.getName()
                  << std::setw(10) << item.getQuantity()
                  << std::setw(10) << "$" + std::to_string(item.getPrice())
                  << std::setw(15) << item.getCategory() << std::endl;
    }

    std::cout << "==========================" << std::endl;
}
```
\n\nFor main.cpp

```cpp
/**\n\n@file main.cpp\n\n@brief Main program for the Inventory Management System\n\n* Demonstrates the functionality of the InventoryItem and InventoryManager classes\n\nby creating a sample inventory and performing various operations.\n\nTo compile this project, use the following command:\n\ng++ (Get-ChildItem -Path . -Recurse -File -Filter *.cpp).Name -o main.exe
 */
#include "InventoryManager.h"  // Include for the InventoryManager class that manages the collection of items
#include "InventoryItem.h"     // Include for the InventoryItem class representing individual inventory items
#include <iostream>            // Include for console input/output operations (std::cout, std::cin, std::endl)
#include <iomanip>             // Include for output formatting utilities like std::setw and std::left
#include <limits>              // Include for std::numeric_limits used in input validation functions
/**\n\nFunction to display the main menu options
 */
void displayMenu() {
    std::cout << "\n===== Inventory Management System =====\n";
    std::cout << "1. Add New Item\n";
    std::cout << "2. Remove Item\n";
    std::cout << "3. Find Item\n";
    std::cout << "4. Display All Items\n";
    std::cout << "5. Exit\n";
    std::cout << "Enter your choice (1-5): ";
}
/**\n\nFunction to get a valid integer input from the user\n\n@return Valid integer input
 */
int getIntInput() {
    int input;
    while (!(std::cin >> input)) {
        std::cin.clear();  // Clear error flags
        std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');  // Discard invalid input
        std::cout << "Invalid input. Please enter a number: ";
    }
    std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');  // Clear the input buffer
    return input;
}
/**\n\nFunction to get a valid double input from the user\n\n@return Valid double input
 */
double getDoubleInput() {
    double input;
    while (!(std::cin >> input)) {
        std::cin.clear();  // Clear error flags
        std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');  // Discard invalid input
        std::cout << "Invalid input. Please enter a number: ";
    }
    std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');  // Clear the input buffer
    return input;
}
/**\n\nMain function - entry point of the program\n\n@return Exit status code
 */
int main() {
    // Create an inventory manager
    InventoryManager manager;

    // Variables for menu interaction
    int choice;
    std::string name, category;
    int quantity;
    double price;

    // Add some initial sample items
    manager.addItem(InventoryItem("Laptop", 10, 999.99, "Electronics"));
    manager.addItem(InventoryItem("Desk Chair", 15, 149.99, "Furniture"));
    manager.addItem(InventoryItem("Notebook", 100, 4.99, "Stationery"));

    // Main program loop
    while (true) {
        displayMenu();
        choice = getIntInput();

        // Process the user's choice
        switch (choice) {
            case 1:  // Add New Item
                std::cout << "Enter item name: ";
                std::getline(std::cin, name);

                std::cout << "Enter quantity: ";
                quantity = getIntInput();

                std::cout << "Enter price: ";
                price = getDoubleInput();

                std::cout << "Enter category: ";
                std::getline(std::cin, category);

                manager.addItem(InventoryItem(name, quantity, price, category));
                break;

            case 2:  // Remove Item
                std::cout << "Enter name of item to remove: ";
                std::getline(std::cin, name);
                manager.removeItem(name);
                break;

            case 3:  // Find Item
                {  // Added braces to create a local scope for 'found'
                    std::cout << "Enter name of item to find: ";
                    std::getline(std::cin, name);

                    InventoryItem* found = manager.findItem(name);
                    if (found != nullptr) {
                        std::cout << "Item found: " << found->getName() << ", Quantity: " << found->getQuantity()
                                  << ", Price: $" << found->getPrice() << ", Category: " << found->getCategory() << std::endl;
                    } else {
                        std::cout << "Item not found: " << name << std::endl;
                    }
                }  // End of scope for 'found'
                break;

            case 4:  // Display All Items
                manager.displayInventory();
                break;

            case 5:  // Exit
                std::cout << "Thank you for using the Inventory Management System!\n";
                return 0;

            default:
                std::cout << "Invalid choice. Please try again.\n";
        }
    }
    return 0;
}
```
\n\nFor .vscode/tasks.json

```jsonc
// VS Code tasks.json - Configures build tasks for C/C++ development
// This file defines compilation tasks that can be executed via Terminal > Run Task in VS Code
{
  // Version of the tasks configuration format
  "version": "2.0.0",
  // List of available tasks
  "tasks": [
    {
      // Task 1: Basic MSVC compiler configuration for single file compilation
      "type": "cppbuild", // Indicates this is a C/C++ build task
      "label": "C/C++: cl.exe build active file",
      "command": "cl.exe", // Microsoft Visual C++ compiler
      "args": [
        "/Zi", // Generate complete debugging information
        "/EHsc", // Enable C++ exception handling
        "/nologo", // Suppress startup banner
        "/Fe${fileDirname}\\${fileBasenameNoExtension}.exe", // Set output executable name
        "${file}", // Compile the currently active file
      ],
      "options": {
        "cwd": "${fileDirname}", // Set working directory to the directory of the file being compiled
      },
      "problemMatcher": [
        "$msCompile", // Use MSVC problem matcher to parse compiler output for errors
      ],
      "group": "build",
      "detail": "compiler: cl.exe",
    },
    {
      // Task 2: Enhanced MSVC compiler configuration with additional include paths
      "type": "cppbuild",
      "label": "C/C++: cl.exe build active file",
      "command": "cl.exe",
      "args": [
        "/Zi", // Generate complete debugging information
        "/EHsc", // Enable C++ exception handling
        "/nologo", // Suppress startup banner
        "/I",
        "C:\\Program Files\\Microsoft Visual Studio\\2022\\Enterprise\\VC\\Tools\\MSVC\\14.42.34433\\include", // Additional include directory
        "/Fe${fileDirname}\\${fileBasenameNoExtension}.exe", // Set output executable name
        "${file}", // Compile the currently active file
      ],
      "options": {
        "cwd": "${fileDirname}", // Set working directory to the directory of the file being compiled
      },
      "problemMatcher": [
        "$msCompile", // Use MSVC problem matcher to parse compiler output for errors
      ],
      "group": {
        "kind": "build",
        "isDefault": true, // Set as the default build task when pressing Ctrl+Shift+B
      },
      "detail": "compiler: cl.exe",
    },
    {
      // Task 3: GCC/G++ compiler configuration for single file compilation with thorough warnings
      "type": "cppbuild",
      "label": "C/C++: g++.exe build active file",
      "command": "g++.exe", // GCC C++ compiler
      "args": [
        "-fdiagnostics-color=always", // Colorize compiler output
        "-g", // Generate debugging information
        "-std=c++17", // Use C++17 standard
        "-Wall", // Enable all warnings
        "-Wextra", // Enable extra warnings
        "-Wpedantic", // Issue warnings for strict ISO C/C++ compliance
        "${file}", // Compile the currently active file
        "-o", // Output flag
        "${fileDirname}\\${fileBasenameNoExtension}.exe", // Output executable path
      ],
      "options": {
        "cwd": "${fileDirname}", // Set working directory to the directory of the file being compiled
      },
      "problemMatcher": [
        "$gcc", // Use GCC problem matcher to parse compiler output for errors
      ],
      "group": {
        "kind": "build",
        "isDefault": true, // Set as the default build task (Note: conflict with Task 2 default setting)
      },
      "detail": "compiler: g++.exe",
    },
    {
      // Task 4: Project-wide compilation using G++ to build all .cpp files for inventory system
      "type": "cppbuild",
      "label": "C/C++: g++.exe build project with multiple *.cpp files",
      "command": "g++.exe", // GCC C++ compiler
      "args": [
        "-fdiagnostics-color=always", // Colorize compiler output
        "-g", // Generate debugging information
        "-std=c++17", // Use C++17 standard
        "-Wall", // Enable all warnings
        "-Wextra", // Enable extra warnings
        "-Wpedantic", // Issue warnings for strict ISO C/C++ compliance
        "$(Get-ChildItem -Path . -Recurse -File -Filter *.cpp).Name", // Specific path to InventoryItem implementation
        "-o", // Output flag
        "./main.exe", // Output executable name
      ],
      "options": {
        "cwd": ".", // Set working directory to the workspace folder
      },
      "problemMatcher": [
        "$gcc", // Use GCC problem matcher to parse compiler output for errors
      ],
      "group": {
        "kind": "build",
        "isDefault": false, // Not set as default yet to avoid conflict
      },
      "detail": "compiler: g++.exe - build inventory management system",
    },
  ],
}
```
\n\nBuilding and Testing
\n\nPrompt 8: Compiling the project with PowerShell

```
To compile all files in the project using PowerShell and g++, run the following command from the src directory:

g++ -fdiagnostics-color=always -g -std=c++17 -Wall -Wextra -Wpedantic $(Get-ChildItem -Path . -Recurse -File -Filter *.cpp | Select-Object -ExpandProperty FullName) -o main.exe
```
\n\nPrompt 9: Testing the application

```
Run the compiled application and test all its features:\n\nRun the main.exe file\n\nTry adding new items with different properties\n\nTest removing items by name\n\nSearch for specific items by name\n\nDisplay the full inventory\n\nVerify error handling with invalid inputs
```
\n\nConclusion

This inventory management system provides a foundation for tracking and managing items in a simple inventory. It demonstrates object-oriented programming principles in C++, using classes, encapsulation, and proper memory management. The system could be extended with additional features such as:
\n\nPersistent storage (saving/loading inventory from files)\n\nMore advanced search capabilities (by ID, category, etc.)\n\nUser authentication\n\nBarcode/SKU support\n\nReporting and analytics features
\n
