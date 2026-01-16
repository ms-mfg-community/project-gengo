# Node TypeScript Calculator Project

## Phase 1: Initial Setup and Implementation

- [x] Create a node project using vite with the SSR-React template with HMR and Typescript + SWC template at the path:
      `C:\onedrive-prsn\OneDrive\02.00.00.GENERAL\repos\git\project-gengo\programming\node\workspace` in a new folder named calculator.
- [x] For this app, create a pages folder in the src directory, then create a Calculator.tsx page web UI component with basic four arithmetic operations.
      These operations will be implemented as separate functions and will include addition, subtraction, multiplication and division.

## Phase 2: Feature Enhancement

- [x] Add the modulo and exponent operations to the Calculator.tsx component.

## Phase 3: UI Refinement

- [x] Change the appearance of the calculator to resemble a basic but realistic physical consumer electronics rectangular calculator.

## Phase 4: Testing and Database Integration

- [x] Create a csv file named calculator-test.csv in a new directory under \src called 'test' for the calculator unit tests with these columns: operation, operandA, operandB, result, status.
      The result column represents the toBe value and status will be either pass or fail.
- [x] Next, connect to an SQL database in Azure and upload the data from the calculator-test.csv file into a new table (if it doesn't exist) named calculator
      with the following connection parameters:
  - username: ztmadmin
  - hostname: svr-asi-01.database.windows.net
  - database: sql-asi-01
  - table: calculator
  - password: <redacted>
- [x] Add a new page component to query the calculator table and call it QueryTestData.tsx
- [x] Using the values from the calculator table, create jest unit tests using a node script that will retrieve values from the table and perform these tests in the console.
