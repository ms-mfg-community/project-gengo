/**
 * @file main.cpp
 * @brief Main program for the Inventory Management System
 * 
 * Demonstrates the functionality of the InventoryItem and InventoryManager classes
 * by creating a sample inventory and performing various operations.
 * To compile this project, use the following command:
 * g++ (Get-ChildItem -Path . -Recurse -File -Filter *.cpp).Name -o main.exe
 */

#include "InventoryManager.h"  // Include for the InventoryManager class that manages the collection of items
#include "InventoryItem.h"     // Include for the InventoryItem class representing individual inventory items
#include <iostream>            // Include for console input/output operations (std::cout, std::cin, std::endl)
#include <iomanip>             // Include for output formatting utilities like std::setw and std::left
#include <limits>              // Include for std::numeric_limits used in input validation functions

/**
 * Function to display the main menu options
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

/**
 * Function to get a valid integer input from the user
 * @return Valid integer input
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

/**
 * Function to get a valid double input from the user
 * @return Valid double input
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

/**
 * Main function - entry point of the program
 * @return Exit status code
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