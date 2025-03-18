# Makefile

CXX = g++
CXXFLAGS = -std=c++11 -Wall -Wextra
SRC = src/InventoryItem.cpp src/InventoryManager.cpp src/main.cpp
OBJ = $(SRC:.cpp=.o)
TARGET = inventory_management_system

all: $(TARGET)

$(TARGET): $(OBJ)
	$(CXX) $(OBJ) -o $(TARGET)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	rm -f $(OBJ) $(TARGET)