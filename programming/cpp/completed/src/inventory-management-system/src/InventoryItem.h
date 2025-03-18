// InventoryItem.h
#ifndef INVENTORYITEM_H
#define INVENTORYITEM_H

#include <string>

class InventoryItem {
private:
    std::string name;
    int quantity;
    double price;

public:
    InventoryItem(const std::string& name, int quantity, double price);
    std::string getName() const;
    int getQuantity() const;
    double getPrice() const;
    void setQuantity(int quantity);
    void setPrice(double price);
};

#endif // INVENTORYITEM_H