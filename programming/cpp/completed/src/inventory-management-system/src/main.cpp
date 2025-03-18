// main.cpp
#include "InventoryManager.h"
#include <iostream>

int main() {
    InventoryManager manager;

    manager.addItem(InventoryItem("Widget", 100, 1.99));
    manager.addItem(InventoryItem("Gadget", 50, 2.99));
    manager.addItem(InventoryItem("Doodad", 200, 0.99));

    std::cout << "Current Inventory:" << std::endl;
    manager.displayInventory();

    std::cout << "\nRemoving 'Gadget' from inventory." << std::endl;
    manager.removeItem("Gadget");

    std::cout << "Updated Inventory:" << std::endl;
    manager.displayInventory();

    return 0;
}