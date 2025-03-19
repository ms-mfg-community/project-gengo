/**
 * @file InventoryManager.cpp
 * @brief Implementation of the InventoryManager class
 * 
 * Contains the implementation of all methods declared in InventoryManager.h
 */

#include "InventoryManager.h"  // Include header containing the InventoryManager class declaration
#include <iostream>            // Include for console input/output operations (std::cout, std::endl)
#include <algorithm>           // Include for std::find_if algorithm used in search operations
#include <iomanip>             // Include for output formatting utilities like std::setw and std::left

/**
 * Adds a new item to the inventory
 * If an item with the same name already exists, its quantity will be updated instead
 * @param item The InventoryItem object to be added to inventory
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

/**
 * Removes an item from the inventory based on its name
 * @param name The name of the item to be removed
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

/**
 * Searches for an item in the inventory by name
 * @param name The name of the item to find
 * @return Pointer to the found item or nullptr if not found
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

/**
 * Displays all items currently in the inventory
 * Prints each item's details to the console
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