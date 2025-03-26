/**
 * @file InventoryManager.h
 * @brief Header file defining the InventoryManager class for inventory management operations
 * 
 * This class provides functionality to manage a collection of inventory items including
 * adding, removing, searching, and displaying items in the inventory.
 */

#ifndef INVENTORYMANAGER_H   // Header guard start - prevents multiple inclusion of this header file
#define INVENTORYMANAGER_H   // Define the guard macro for this header

#include "InventoryItem.h" // Include the InventoryItem class definition
#include <vector>          // Include the STL vector container for storing items

/**
 * @class InventoryManager
 * @brief Manages a collection of inventory items and operations on them
 */
class InventoryManager {
private:
    /** Vector container storing all inventory items */
    std::vector<InventoryItem> items;

public:
    /**
     * @brief Adds a new item to the inventory
     * @param item The InventoryItem object to be added to inventory
     */
    void addItem(const InventoryItem& item);
    
    /**
     * @brief Removes an item from the inventory based on its name
     * @param name The name of the item to be removed
     */
    void removeItem(const std::string& name);
    
    /**
     * @brief Searches for an item in the inventory by name
     * @param name The name of the item to find
     * @return Pointer to the found item or nullptr if not found
     */
    InventoryItem* findItem(const std::string& name);
    
    /**
     * @brief Displays all items currently in the inventory
     */
    void displayInventory() const;
};

#endif // INVENTORYMANAGER_H