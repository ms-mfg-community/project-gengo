/**
 * @file InventoryItem.cpp
 * @brief Implementation of the InventoryItem class
 * 
 * Contains the implementation of all methods declared in InventoryItem.h
 */

#include "InventoryItem.h"  // Include the header file that defines the InventoryItem class
#include <iostream>         // Include standard I/O for warning messages in updateQuantity

// Static ID counter to ensure each item gets a unique identifier
static int nextId = 1;

/**
 * Default constructor initializes with empty values
 */
InventoryItem::InventoryItem() : name(""), quantity(0), price(0.0), id(nextId++), category("") {
    // Empty body as initialization is done in the initializer list
}

/**
 * Parameterized constructor initializes with provided values
 * @param name Name of the item
 * @param quantity Initial quantity
 * @param price Price per unit
 * @param category Category of the item
 */
InventoryItem::InventoryItem(const std::string& name, int quantity, double price, const std::string& category)
    : name(name), quantity(quantity), price(price), id(nextId++), category(category) {
    // Empty body as initialization is done in the initializer list
}

/**
 * Returns the name of the inventory item
 * @return Name as string
 */
std::string InventoryItem::getName() const {
    return name;
}

/**
 * Returns the current quantity of the item
 * @return Quantity as integer
 */
int InventoryItem::getQuantity() const {
    return quantity;
}

/**
 * Returns the price per unit of the item
 * @return Price as double
 */
double InventoryItem::getPrice() const {
    return price;
}

/**
 * Returns the unique identifier of the item
 * @return ID as integer
 */
int InventoryItem::getId() const {
    return id;
}

/**
 * Returns the category of the item
 * @return Category as string
 */
std::string InventoryItem::getCategory() const {
    return category;
}

/**
 * Sets a new name for the item
 * @param name New name to set
 */
void InventoryItem::setName(const std::string& name) {
    this->name = name;
}

/**
 * Sets a new quantity for the item
 * @param quantity New quantity to set
 */
void InventoryItem::setQuantity(int quantity) {
    this->quantity = quantity;
}

/**
 * Sets a new price for the item
 * @param price New price to set
 */
void InventoryItem::setPrice(double price) {
    this->price = price;
}

/**
 * Sets a new category for the item
 * @param category New category to set
 */
void InventoryItem::setCategory(const std::string& category) {
    this->category = category;
}

/**
 * Updates the quantity by adding the specified amount (negative to subtract)
 * @param amount Amount to add or subtract from current quantity
 */
void InventoryItem::updateQuantity(int amount) {
    quantity += amount;
    // Ensure quantity doesn't go below zero
    if (quantity < 0) {
        std::cout << "Warning: Quantity for " << name << " went below zero and was reset to 0." << std::endl;
        quantity = 0;
    }
}