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

To write unit tests for your C++ inventory management program using Google Test in Visual Studio Code, follow these steps:

### Step 1: Set Up Your Project

1. **Install Visual Studio Code**:
   - Download and install Visual Studio Code from the official website.

2. **Install the C/C++ Extension**:
   - Open Visual Studio Code.
   - Go to the Extensions view by clicking on the Extensions icon in the Activity Bar on the side of the window or by pressing `Ctrl+Shift+X`.
   - Search for "C/C++" and install the extension provided by Microsoft.

3. **Install a C++ Compiler**:
   - Ensure you have a C++ compiler installed. For Windows, you can use MinGW or the Windows Subsystem for Linux (WSL). For macOS, you can use Xcode Command Line Tools. For Linux, you can use GCC.
   - To install MinGW on Windows, follow the MinGW installation guide.

### Step 2: Install Google Test

1. **Download Google Test**:
   - Download Google Test from the Google Test GitHub repository.

2. **Add Google Test to Your Project**:
   - Copy the `googletest` directory into your project directory.

### Step 3: Write Unit Tests

1. **Create a Test File**:
   - Create a new file named `test_inventory_manager.cpp` and add the following code:

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

### Step 4: Configure CMake

1. **Create a CMakeLists.txt File**:
   - Create a `CMakeLists.txt` file in your project directory and add the following content:

     ```cmake
     cmake_minimum_required(VERSION 3.10)
     project(InventoryManager)

     set(CMAKE_CXX_STANDARD 11)

     add_executable(InventoryManager main.cpp InventoryItem.cpp InventoryManager.cpp)
     add_executable(test_inventory_manager test_inventory_manager.cpp InventoryItem.cpp InventoryManager.cpp)

     # Google Test
     add_subdirectory(googletest)
     target_link_libraries(test_inventory_manager gtest gtest_main)
     ```

### Step 5: Build and Run the Tests

1. **Build the Project**:
   - Open the terminal in Visual Studio Code (View > Terminal) and navigate to your project directory.
   - Create a build directory and navigate to it:

     ```sh
     mkdir build
     cd build
     ```

   - Run CMake to generate the build files:

     ```sh
     cmake ..
     ```

   - Build the project:

     ```sh
     cmake --build .
     ```

2. **Run the Tests**:
   - Execute the compiled test program:

     ```sh
     ./test_inventory_manager
     ```

   - Google Test will run the tests and display the results in the terminal.

By following these steps, you can create and test your C++ inventory management program using Google Test in Visual Studio Code. If you have any questions or need further assistance, feel free to ask!

Sure! Here's how you can create a simple inventory management program in C++ and write unit tests using Google Test in CLion:

### Step 1: Set Up Your Project

1. **Create a New C++ Project**:
   - Open CLion and click on `New Project`.
   - Select `C++ Executable` and set the project name and language standard.
   - Click `Create`. CLion will generate a stub project with a single source file `main.cpp` and a root `CMakeLists.txt`.

### Step 2: Write the Inventory Management Code

1. **Create the Inventory Item Class**:
   - In the Project Explorer, right-click on the `src` folder and select `New` > `C++ Class`.
   - Name the class `InventoryItem` and add the following code:

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
   - In the Project Explorer, right-click on the `src` folder and select `New` > `C++ Class`.
   - Name the class `InventoryManager` and add the following code:

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
   - In the Project Explorer, right-click on the `src` folder and select `New` > `C++ File`.
   - Name the file `main.cpp` and add the following code:

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

1. **Download Google Test**:
   - Download Google Test from the Google Test GitHub repository.
   - Extract the contents and copy the `googletest` directory into your project directory.

2. **Configure CMakeLists.txt**:
   - Open the `CMakeLists.txt` file in your project and add the following lines to include Google Test and the test file:

     ```cmake
     cmake_minimum_required(VERSION 3.10)
     project(InventoryManager)

     set(CMAKE_CXX_STANDARD 11)

     add_executable(InventoryManager main.cpp InventoryItem.cpp InventoryManager.cpp)

     # Google Test
     add_subdirectory(googletest)
     enable_testing()
     include_directories(${gtest_SOURCE_DIR}/include ${gtest_SOURCE_DIR})
     add_executable(test_inventory_manager test_inventory_manager.cpp InventoryItem.cpp InventoryManager.cpp)
     target_link_libraries(test_inventory_manager gtest gtest_main)
     add_test(NAME test_inventory_manager COMMAND test_inventory_manager)
     ```

### Step 4: Write Unit Tests

1. **Create a Test File**:
   - In the Project Explorer, right-click on the `src` folder and select `New` > `C++ File`.
   - Name the file `test_inventory_manager.cpp` and add the following code:

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
   - Click on `Build` > `Build Project` to compile the project.

2. **Run the Tests**:
   - In the Project Explorer, right-click on the `test_inventory_manager` target and select `Run 'test_inventory_manager'`.
   - CLion will execute the tests and display the results in the Run tool window[1](https://www.jetbrains.com/help/clion/unit-testing-tutorial.html)[2](https://www.jetbrains.com/help/clion/creating-google-test-run-debug-configuration-for-test.html).

By following these steps, you can create and test your C++ inventory management program using Google Test in CLion. If you have any questions or need further assistance, feel free to ask!