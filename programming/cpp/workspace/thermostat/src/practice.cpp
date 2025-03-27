#include <iostream>
using namespace std;

int main() {
    int arr[10] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
    cout << "Hello, World!" << endl;
    for(size_t i {0}; i < sizeof(arr)/sizeof(arr[0]); ++i) {
        cout << arr[i] << " ";
    }
    return 0;
}