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

No problem! Here's how you can write unit tests for your C++ inventory management program using Google Test in Visual Studio 2022:

### Step 1: Set Up Your Project

1. **Create a New C++ Project**:
   - Open Visual Studio 2022.
   - Go to `File` > `New` > `Project`.
   - Select `Console App` from the list of templates, make sure `C++` is selected as the language, and click `Next`.
   - Name your project (e.g., `InventoryManager`) and choose a location to save it, then click `Create`.

### Step 2: Write the Inventory Management Code

1. **Create the Inventory Item Class**:
   - In the Solution Explorer, right-click on the `Source Files` folder, select `Add` > `New Item`.
   - Choose `C++ File (.cpp)` and name it `InventoryItem.cpp`.
   - Add the following code:

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

2. **Create the Inventory Management Class**:
   - In the Solution Explorer, right-click on the `Source Files` folder, select `Add` > `New Item`.
   - Choose `C++ File (.cpp)` and name it `InventoryManager.cpp`.
   - Add the following code:

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

3. **Create the Main Program**:
   - In the Solution Explorer, right-click on the `Source Files` folder, select `Add` > `New Item`.
   - Choose `C++ File (.cpp)` and name it `main.cpp`.
   - Add the following code:

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

### Step 3: Set Up Google Test for Unit Testing

1. **Install Google Test**:
   - Download Google Test from the Google Test GitHub repository.
   - Extract the contents and copy the `googletest` directory into your project directory.

2. **Add Google Test to Your Project**:
   - In the Solution Explorer, right-click on your solution and select `Add` > `Existing Project`.
   - Navigate to the `googletest` directory, select the `googletest` project file, and click `Open`.

3. **Configure Your Project to Use Google Test**:
   - Right-click on your project in the Solution Explorer and select `Properties`.
   - Go to `Configuration Properties` > `VC++ Directories`.
   - Add the path to the `googletest/include` directory to the `Include Directories`.
   - Add the path to the `googletest` library directory to the `Library Directories`.

### Step 4: Write Unit Tests

1. **Create a Test File**:
   - In the Solution Explorer, right-click on the `Source Files` folder, select `Add` > `New Item`.
   - Choose `C++ File (.cpp)` and name it `test_inventory_manager.cpp`.
   - Add the following code:

     ```cpp
     // test_inventory_manager.cpp
     #include "gtest/gtest.h"
     #include "InventoryManager.h"

     TEST(InventoryManagerTest, AddItem) {
         InventoryManager manager;
         InventoryItem item("Widget", 100, 1.99);
         manager.addItem(item);
         InventoryItem* foundItem = manager.findItem("Widget");
         ASSERT_NE(foundItem, nullptr);
         EXPECT_EQ(foundItem->getName(), "Widget");
         EXPECT_EQ(foundItem->getQuantity(), 100);
         EXPECT_DOUBLE_EQ(foundItem->getPrice(), 1.99);
     }

     TEST(InventoryManagerTest, RemoveItem) {
         InventoryManager manager;
         InventoryItem item("Widget", 100, 1.99);
         manager.addItem(item);
         manager.removeItem("Widget");
         InventoryItem* foundItem = manager.findItem("Widget");
         EXPECT_EQ(foundItem, nullptr);
     }

     TEST(InventoryManagerTest, FindItem) {
         InventoryManager manager;
         InventoryItem item("Widget", 100, 1.99);
         manager.addItem(item);
         InventoryItem* foundItem = manager.findItem("Widget");
         ASSERT_NE(foundItem, nullptr);
         EXPECT_EQ(foundItem->getName(), "Widget");
     }

     TEST(InventoryManagerTest, DisplayInventory) {
         InventoryManager manager;
         InventoryItem item1("Widget", 100, 1.99);
         InventoryItem item2("Gadget", 50, 2.99);
         manager.addItem(item1);
         manager.addItem(item2);
         testing::internal::CaptureStdout();
         manager.displayInventory();
         std::string output = testing::internal::GetCapturedStdout();
         EXPECT_NE(output.find("Widget"), std::string::npos);
         EXPECT_NE(output.find("Gadget"), std::string::npos);
     }

     int main(int argc, char **argv) {
         ::testing::InitGoogleTest(&argc, argv);
         return RUN_ALL_TESTS();
     }
     ```

### Step 5: Build and Run the Tests

1. **Build the Project**:
   - Click on `Build` > `Build Solution` to compile the project.

2. **Run the Tests**:
   - In the Solution Explorer, right-click on the `test_inventory_manager` project and select `Set as Startup Project`.
   - Click on `Debug` > `Start Without Debugging` to run the tests.
   - Google Test will execute the tests and display the results in the Output window[1](https://learn.microsoft.com/en-us/visualstudio/test/how-to-use-google-test-for-cpp?view=vs-2022)[2](https://learn.microsoft.com/en-us/visualstudio/test/writing-unit-tests-for-c-cpp?view=vs-2022).

By following these steps, you can create and test your C++ inventory management program using Google Test in Visual Studio 2022. If you have any questions or need further assistance, feel free to ask!