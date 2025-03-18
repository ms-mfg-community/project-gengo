// InventoryItem.cpp
#include "InventoryItem.h"

InventoryItem::InventoryItem(const std::string& name, int quantity, double price)
    : name(name), quantity(quantity), price(price) {}

std::string InventoryItem::getName() const {
    return name;
}

int InventoryItem::getQuantity() const {
    return quantity;
}

double InventoryItem::getPrice() const {
    return price;
}

void InventoryItem::setQuantity(int quantity) {
    this->quantity = quantity;
}

void InventoryItem::setPrice(double price) {
    this->price = price;
}