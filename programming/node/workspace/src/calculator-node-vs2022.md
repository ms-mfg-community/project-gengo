Sure! Here's a step-by-step guide to help you write a basic calculator program in Node.js and perform unit testing with Jest in Visual Studio 2022:

### Step 1: Set Up Your Project

1. **Create a New Project**:
   - Open Visual Studio 2022 and create a new project.
   - Select "Node.js Console Application" from the project templates and click "Next".
   - Name your project and choose a location to save it, then click "Create".

2. **Initialize Your Project**:
   - Open the terminal in Visual Studio (View > Terminal) and navigate to your project directory.
   - Initialize a new Node.js project:

     ```sh
     npm init -y
     ```

### Step 2: Write the Calculator Code

1. **Create the Calculator Module**:
   - Create a new file named `calculator.js` and add the following code:

     ```javascript
     class Calculator {
         add(a, b) {
             return a + b;
         }

         subtract(a, b) {
             return a - b;
         }

         multiply(a, b) {
             return a * b;
         }

         divide(a, b) {
             if (b === 0) {
                 throw new Error("Division by zero is not allowed.");
             }
             return a / b;
         }
     }

     module.exports = Calculator;
     ```

### Step 3: Install Jest

1. **Install Jest**:
   - In the terminal, install Jest as a development dependency:

     ```sh
     npm install --save-dev jest
     ```

2. **Configure Jest**:
   - Open your `package.json` file and add the following script:

     ```json
     "scripts": {
       "test": "jest"
     }
     ```

### Step 4: Write Unit Tests

1. **Create Test Cases**:
   - Create a new file named `calculator.test.js` and add the following test cases:

     ```javascript
     const Calculator = require('./calculator');
     const calculator = new Calculator();

     test('adds 2 + 3 to equal 5', () => {
         expect(calculator.add(2, 3)).toBe(5);
     });

     test('subtracts 5 - 2 to equal 3', () => {
         expect(calculator.subtract(5, 2)).toBe(3);
     });

     test('multiplies 4 * 3 to equal 12', () => {
         expect(calculator.multiply(4, 3)).toBe(12);
     });

     test('divides 10 / 2 to equal 5', () => {
         expect(calculator.divide(10, 2)).toBe(5);
     });

     test('throws error when dividing by zero', () => {
         expect(() => calculator.divide(1, 0)).toThrow('Division by zero is not allowed.');
     });
     ```

### Step 5: Run Your Tests

1. **Run the Tests**:
   - In the terminal, run the following command to execute your tests:

     ```sh
     npm test
     ```

   - Visual Studio will execute the tests and display the results in the terminal.

By following these steps, you can create a basic calculator program in Node.js and perform unit testing with Jest in Visual Studio 2022. If you have any questions or need further assistance, feel free to ask!