Creating a basic calculator app with TypeScript in Visual Studio 2022 is a great way to get started with both TypeScript and Visual Studio. Here's a step-by-step guide:

1. **Set Up Your Project**:
   - Open Visual Studio 2022 and create a new project.
   - Select "ASP.NET Core Web Application" and click "Next".
   - Name your project and choose a location to save it, then click "Create".
   - Select "Empty" as the project template and make sure "Enable Docker Support" and "Configure for HTTPS" are unchecked. Click "Create".

2. **Add TypeScript Support**:
   - Right-click on your project in the Solution Explorer and select "Add" > "New Item".
   - Choose "TypeScript JSON Configuration File" and name it `tsconfig.json`. This file will configure the TypeScript compiler options.

     ```json
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

3. **Create the Calculator App**:
   - Add a new TypeScript file to your project. Right-click on your project, select "Add" > "New Item", and choose "TypeScript File". Name it `calculator.ts`.

     ```typescript
     class Calculator {
         add(a: number, b: number): number {
             return a + b;
         }

         subtract(a: number, b: number): number {
             return a - b;
         }

         multiply(a: number, b: number): number {
             return a * b;
         }

         divide(a: number, b: number): number {
             if (b === 0) {
                 throw new Error("Division by zero is not allowed.");
             }
             return a / b;
         }
     }

     // Example usage
     const calculator = new Calculator();
     console.log(calculator.add(2, 3)); // Output: 5
     console.log(calculator.subtract(5, 2)); // Output: 3
     console.log(calculator.multiply(4, 3)); // Output: 12
     console.log(calculator.divide(10, 2)); // Output: 5
     ```

4. **Compile TypeScript to JavaScript**:
   - Open the terminal in Visual Studio (View > Terminal) and run the TypeScript compiler:

     ```sh
     tsc
     ```

   This will compile your TypeScript code to JavaScript.

5. **Run Your App**:
   - You can run the compiled JavaScript file using Node.js. In the terminal, run:

     ```sh
     node calculator.js
     ```

   This will execute your calculator app and display the results in the terminal.

That's it! You've created a basic calculator app with TypeScript in Visual Studio 2022. If you have any questions or need further assistance, feel free to ask!

To test your TypeScript calculator app with Vitest in Visual Studio 2022, follow these steps:

1. **Set Up Your Project**:
   - Ensure you have Node.js installed. If not, download and install it from nodejs.org.

2. **Install Vitest**:
   - Open the terminal in Visual Studio (View > Terminal) and navigate to your project directory.
   - Install Vitest as a development dependency:

     ```sh
     npm install --save-dev vitest
     ```

3. **Configure Vitest**:
   - Add a `vitest.config.ts` file to your project root with the following content:

     ```typescript
     import { defineConfig } from 'vitest/config';

     export default defineConfig({
       test: {
         globals: true,
         environment: 'node',
       },
     });
     ```

4. **Create Test Cases**:
   - Create a new file named `calculator.test.ts` in your project directory and add your test cases:

     ```typescript
     import { describe, it, expect } from 'vitest';
     import { Calculator } from './calculator';

     describe('Calculator', () => {
       it('should add two numbers', () => {
         const calculator = new Calculator();
         expect(calculator.add(2, 3)).toBe(5);
       });

       it('should subtract two numbers', () => {
         const calculator = new Calculator();
         expect(calculator.subtract(5, 2)).toBe(3);
       });

       it('should multiply two numbers', () => {
         const calculator = new Calculator();
         expect(calculator.multiply(4, 3)).toBe(12);
       });

       it('should divide two numbers', () => {
         const calculator = new Calculator();
         expect(calculator.divide(10, 2)).toBe(5);
       });

       it('should throw an error when dividing by zero', () => {
         const calculator = new Calculator();
         expect(() => calculator.divide(1, 0)).toThrow('Division by zero is not allowed.');
       });
     });
     ```

5. **Add Test Script**:
   - Open your `package.json` file and add the following script:

     ```json
     "scripts": {
       "test": "vitest"
     }
     ```

6. **Run Your Tests**:
   - In the terminal, run the following command to execute your tests:

     ```sh
     npm run test
     ```

   - Visual Studio will execute the tests and display the results in the terminal.

By following these steps, you can set up and run tests for your TypeScript calculator app using Vitest in Visual Studio 2022. If you have any questions or run into issues, feel free to ask!