# go-vscode-statistics

## Code generation: Initial build
Create a go project named statistics.go to accept a set of between 3 to 10 floating point numeric arguments. Calculate and display the minimum, maximum, mean and n-1 standard deviation values in the output. Include input validation for checking the allowable range of arguments and type of arguments provided. Use the log package to log the output to a new folder at ...\src\log\statistics.log.

## Unit Testing: test cases
Add a 3 unit test cases to execute unit tests for 3 arrays of 5 values each.

## Iteration: Reduce floating point accuracy in main program
Update the floating point accuracy and output by rounding to 2 decimal places.

## Iteration: Reduce floating point accuracy in test
Also update the input values in #file:statistics_test.go with 2 decimal places.

## Refactor: Refactor the ingestion of test values 
Crreate a new csv file called statistics_test.csv with with headers val1, val2, val3, val4, and val5. Ingest the test values from a csv file instead of specifying hard coded values for the values array.

## Document the test data as a mermaid chart class diagram
Create a mermaid chart class diagram. #file: statistics_test.csv, #file: mermaid_csv.md

## Add a new column to the csv input file
Add a column named result to the input file that will either be pass or fail for each test, then after running the test, write the result to this column. #file:statistics_test.csv #file:statistics_test.go 

## Show the results from the csv file
After the test is complete, read and display the content of the #file:statistics_test.csv directly from #file:statistics_test.go 

## Thought Exercise
How else can we scale this application to make it handle more volume in a distributed architecture?
