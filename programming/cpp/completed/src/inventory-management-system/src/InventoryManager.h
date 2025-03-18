// InventoryManager.h
#ifndef INVENTORYMANAGER_H
#define INVENTORYMANAGER_H

#include "InventoryItem.h"
#include <vector>

class InventoryManager {
private:
    std::vector<InventoryItem> items;

public:
    void addItem(const InventoryItem& item);
    void removeItem(const std::string& name);
    InventoryItem* findItem(const std::string& name);
    void displayInventory() const;
};

#endif // INVENTORYMANAGER_H