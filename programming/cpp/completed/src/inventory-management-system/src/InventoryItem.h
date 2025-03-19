/**
 * @file InventoryItem.h
 * @brief Header file defining the InventoryItem class for representing individual inventory items
 * 
 * This class represents a single item in the inventory with properties such as 
 * name, quantity, price, and other relevant attributes.
 */

#ifndef INVENTORYITEM_H  // Include guard to prevent multiple inclusion
#define INVENTORYITEM_H  // Define the include guard macro

#include <string>        // Include the string library for std::string support

/**
 * @class InventoryItem
 * @brief Represents a single item in the inventory system
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
    /**
     * @brief Default constructor
     */
    InventoryItem();
    
    /**
     * @brief Parameterized constructor
     * @param name Name of the item
     * @param quantity Initial quantity
     * @param price Price per unit
     * @param category Category of the item
     */
    InventoryItem(const std::string& name, int quantity, double price, const std::string& category);
    
    /**
     * @brief Get the name of the item
     * @return Name of the item as string
     */
    std::string getName() const;
    
    /**
     * @brief Get the current quantity
     * @return Quantity as integer
     */
    int getQuantity() const;
    
    /**
     * @brief Get the price per unit
     * @return Price as double
     */
    double getPrice() const;
    
    /**
     * @brief Get the unique identifier
     * @return ID as integer
     */
    int getId() const;
    
    /**
     * @brief Get the category
     * @return Category as string
     */
    std::string getCategory() const;
    
    /**
     * @brief Set a new name for the item
     * @param name New name to set
     */
    void setName(const std::string& name);
    
    /**
     * @brief Set a new quantity
     * @param quantity New quantity to set
     */
    void setQuantity(int quantity);
    
    /**
     * @brief Set a new price
     * @param price New price to set
     */
    void setPrice(double price);
    
    /**
     * @brief Set a new category
     * @param category New category to set
     */
    void setCategory(const std::string& category);
    
    /**
     * @brief Add to the current quantity
     * @param amount Amount to add (can be negative for subtraction)
     */
    void updateQuantity(int amount);
};

#endif // INVENTORYITEM_H