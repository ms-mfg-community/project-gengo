// InventoryManager.cpp
#include "InventoryManager.h"
#include <iostream>
#include <algorithm>

void InventoryManager::addItem(const InventoryItem& item) {
    items.push_back(item);
}

void InventoryManager::removeItem(const std::string& name) {
    items.erase(std::remove_if(items.begin(), items.end(),
        [&name](const InventoryItem& item) { return item.getName() == name; }), items.end());
}

InventoryItem* InventoryManager::findItem(const std::string& name) {
    auto it = std::find_if(items.begin(), items.end(),
        [&name](const InventoryItem& item) { return item.getName() == name; });
    return it != items.end() ? &(*it) : nullptr;
}

void InventoryManager::displayInventory() const {
    for (const auto& item : items) {
        std::cout << "Name: " << item.getName()
                  << ", Quantity: " << item.getQuantity()
                  << ", Price: $" << item.getPrice() << std::endl;
    }
}