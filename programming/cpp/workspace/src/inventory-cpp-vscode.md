For a GitHub Copilot workshop aimed at developers in Fortune 500 manufacturing companies, a demo that showcases practical applications and highlights the power of Copilot in streamlining development would be ideal. Here's a suggestion for a demo that involves building a simple C++ program to manage inventory in a manufacturing setting:

### Demo: Inventory Management System

#### Step 1: Set Up the Project

1. **Create a New C++ Project**:
   - Open your preferred IDE (e.g., Visual Studio, CLion, or Visual Studio Code).
   - Create a new C++ project.

#### Step 2: Define the Inventory Item Class

1. **Create the Inventory Item Class**:
   - Create a new file named `InventoryItem.h` and define the class:

     ```cpp
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
     ```

2. **Implement the Inventory Item Class**:
   - Create a new file named `InventoryItem.cpp` and implement the class methods:

     ```cpp
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
     ```

#### Step 3: Create the Inventory Management System

1. **Create the Inventory Management Class**:
   - Create a new file named `InventoryManager.h` and define the class:

     ```cpp
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
     ```

2. **Implement the Inventory Management Class**:
   - Create a new file named `InventoryManager.cpp` and implement the class methods:

     ```cpp
     // InventoryManager.cpp
     #include "InventoryManager.h"
     #include <iostream>
     #include <algorithm>

     void InventoryManager::addItem(const InventoryItem& item) {
         items.push_back(item);
     }

     void InventoryManager::removeItem(const std::string& name) {
         items.erase(std::remove_if(items.begin(), items.end(),
             &name { return item.getName() == name; }), items.end());
     }

     InventoryItem* InventoryManager::findItem(const std::string& name) {
         auto it = std::find_if(items.begin(), items.end(),
             &name { return item.getName() == name; });
         return it != items.end() ? &(*it) : nullptr;
     }

     void InventoryManager::displayInventory() const {
         for (const auto& item : items) {
             std::cout << "Name: " << item.getName()
                       << ", Quantity: " << item.getQuantity()
                       << ", Price: $" << item.getPrice() << std::endl;
         }
     }
     ```

#### Step 4: Create the Main Program

1. **Create the Main Program**:
   - Create a new file named `main.cpp` and add the following code:

     ```cpp
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
     ```

#### Step 5: Compile and Run the Program

1. **Compile the Program**:
   - Use your IDE's build tools to compile the program. For example, in Visual Studio, click on `Build` > `Build Solution`.

2. **Run the Program**:
   - Run the compiled program to see the inventory management system in action.

### Step 6: Demonstrate GitHub Copilot

1. **Show Copilot in Action**:
   - Demonstrate how GitHub Copilot can assist in writing code by suggesting code completions, generating boilerplate code, and providing useful snippets.
   - Highlight how Copilot can help with writing class definitions, implementing methods, and even generating test cases.

This demo showcases a practical application that resonates with developers in manufacturing companies, as inventory management is a common task. It also highlights the power of GitHub Copilot in streamlining the development process and improving productivity. If you have any questions or need further assistance, feel free to ask!