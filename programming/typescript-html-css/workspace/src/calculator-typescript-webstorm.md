# Calculator Typescript Webstorm

Developing a basic TypeScript calculator app in WebStorm is straightforward. Here's a step-by-step guide to help you get started:

1. **Set Up Your Project**:
   - Open WebStorm and create a new project.
   - Select "Empty Project" and choose a location to save your project.

1. **Add TypeScript Support**:
   - Right-click on your project in the Project Explorer and select `New` > `File`.
   - Name the file `tsconfig.json` and add the following configuration:

```text
 ```
```

json

```text
 {
   "compilerOptions": {
     "target": "es5",
     "module": "commonjs",
     "strict": true,
     "esModuleInterop": true,
     "skipLibCheck": true,
     "forceConsistentCasingInFileNames": true
   }
 }
 ```
```

1. **Create the Calculator App**:
   - Add a new TypeScript file to your project. Right-click on your project, select `New` > `File`, and name it `calculator.ts`.

```text
 ```
```

typescript

```text
 class Calculator {
   add(a: number, b: number): number {
     return a + b;
   }
```

```text
   subtract(a: number, b: number): number {
     return a - b;
   }
```

```text
   multiply(a: number, b: number): number {
     return a * b;
   }
```

```text
   divide(a: number, b: number): number {
     if (b === 0) {
       throw new Error("Division by zero is not allowed.");
     }
     return a / b;
   }
 }
```

```text
 // Example usage
 const calculator = new Calculator();
 console.log(calculator.add(2, 3)); // Output: 5
 console.log(calculator.subtract(5, 2)); // Output: 3
 console.log(calculator.multiply(4, 3)); // Output: 12
 console.log(calculator.divide(10, 2)); // Output: 5
 ```
```

1. **Compile TypeScript to JavaScript**:
   - Open the terminal in WebStorm (View > Tool Windows > Terminal) and run the TypeScript compiler:

```text
 ```
```

sh

```text
 tsc
 ```
```

   This will compile your TypeScript code to JavaScript.

1. **Run Your App**:
   - You can run the compiled JavaScript file using Node.js. In the terminal, run:

```text
 ```
```

sh

```text
 node calculator.js
 ```
```

   This will execute your calculator app and display the results in the terminal.

That's it! You've created a basic calculator app with TypeScript in WebStorm. If you have any questions or need further assistance, feel free to ask!

To test your TypeScript calculator app with Vitest in WebStorm, follow these steps:

1. **Set Up Your Project**:
   - Ensure you have Node.js installed. If not, download and install it from nodejs.org.

1. **Install Vitest**:
   - Open the terminal in WebStorm (View > Tool Windows > Terminal) and navigate to your project directory.
   - Install Vitest as a development dependency:

```text
 ```
```

sh

```text
 npm install --save-dev vitest
 ```
```

1. **Configure Vitest**:
   - Add a `vitest.config.ts` file to your project root with the following content:

```text
 ```
```

typescript

```text
 import { defineConfig } from "vitest/config";
```

```text
 export default defineConfig({
   test: {
     globals: true,
     environment: "node",
   },
 });
 ```
```

1. **Create Test Cases**:
   - Create a new file named `calculator.test.ts` in your project directory and add your test cases:

```text
 ```
```

typescript

```text
 import { describe, it, expect } from "vitest";
 import { Calculator } from "./calculator";
```

```text
 describe("Calculator", () => {
   it("should add two numbers", () => {
     const calculator = new Calculator();
     expect(calculator.add(2, 3)).toBe(5);
   });
```

```text
   it("should subtract two numbers", () => {
     const calculator = new Calculator();
     expect(calculator.subtract(5, 2)).toBe(3);
   });
```

```text
   it("should multiply two numbers", () => {
     const calculator = new Calculator();
     expect(calculator.multiply(4, 3)).toBe(12);
   });
```

```text
   it("should divide two numbers", () => {
     const calculator = new Calculator();
     expect(calculator.divide(10, 2)).toBe(5);
   });
```

```text
   it("should throw an error when dividing by zero", () => {
     const calculator = new Calculator();
     expect(() => calculator.divide(1, 0)).toThrow(
       "Division by zero is not allowed.",
     );
   });
 });
 ```
```

1. **Add Test Script**:
   - Open your `package.json` file and add the following script:

```text
 ```
```

json

```text
 "scripts": {
   "test": "vitest"
 }
 ```
```

1. **Run Your Tests**:
   - In WebStorm, you can run your tests directly from the editor. Right-click on your test file or a specific test case and select `Run 'calculator.test.ts'`.
   - Alternatively, you can run the tests from the terminal by executing:

```text
 ```
```

sh

```text
 npm run test
 ```
```

   - WebStorm will execute the tests and display the results in the Run tool window[1](https://www.jetbrains.com/help/webstorm/vitest.html).

By following these steps, you can set up and run tests for your TypeScript calculator app using Vitest in WebStorm. If you have any questions or run into issues, feel free to ask!
