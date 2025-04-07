Sure! Here's how you can write a basic calculator program in Node.js and perform unit testing with Jest in WebStorm:

### Step 1: Set Up Your Project

1. **Create a New Project**:
   - Open WebStorm and create a new project.
   - Select "Node.js" from the list of project templates and click "Next".
   - Name your project and choose a location to save it, then click "Create".

2. **Initialize Your Project**:
   - Open the terminal in WebStorm (View > Tool Windows > Terminal) and navigate to your project directory.
   - Initialize a new Node.js project:

     ```sh
     npm init -y
     ```

### Step 2: Write the Calculator Code

1. **Create the Calculator Module**:
   - In the Project Explorer, right-click on your project folder and select `New` > `File`.
   - Name the file `calculator.js` and add the following code:

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
   - In the Project Explorer, right-click on your project folder and select `New` > `File`.
   - Name the file `calculator.test.js` and add the following test cases:

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
   - In WebStorm, you can run your tests directly from the editor. Right-click on your test file or a specific test case and select `Run 'calculator.test.js'`.
   - Alternatively, you can run the tests from the terminal by executing:

     ```sh
     npm test
     ```

   - WebStorm will execute the tests and display the results in the Run tool window[1](https://www.jetbrains.com/help/webstorm/running-unit-tests-on-jest.html)[2](https://www.jetbrains.com/help/webstorm/unit-testing-javascript.html).

By following these steps, you can create a basic calculator program in Node.js and perform unit testing with Jest in WebStorm. If you have any questions or need further assistance, feel free to ask!