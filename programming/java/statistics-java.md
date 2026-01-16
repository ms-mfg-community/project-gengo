# java-statistics
\n\ngenerate: Initial build
\n\ngo mod init statistics && cd statistics

Create a go project in the relative path ...programming\java\workspace\statistics in a file statistics.java. If the statistics folder isn't already created, create it. This program will accept a set of 5 floating point numeric arguments with values between 1 and 10. Calculate and display the minimum, maximum, mean and n-1 standard deviation values in the output. Include input validation for checking the allowable range of arguments and type of arguments provided. Log the output to a new folder at ......programming\go\workspace\statistics\log\statistics.log. If the log folder isn't already created, create it first.
\n\nshow-log

Show the contents of the log file with Get-Content -Path .\log\statistics.log
\n\niterate-1: Clear screen

For a neater experience, please clear the screen when the program is executed.
\n\niterate-2: Add loop

After the first calculation, ask the user if they would like another, and if they say yes, clear the screen again and prompt them for each value one line at a time, labeling each entry as parameter1, parameter2, ... parameter5.
\n\nUnit Testing: test cases

Add a 3 unit test cases to execute unit tests for 3 arrays of 5 values each.
\n\nRefactor-1: Loop test cases

Create a loop to iterate over the three test cases.
\n\nIteration-3: Reduce accuracy in main

Reduce the floating point accuracy to one decimal place in the main program to alleviate rounding errors.
\n\nIteration: Reduce accuracy in test

Also update the input values in the test file with 1 decimal place to alleviate rounding errors failing certain test cases.
\n\nRefactor-1: Refactor the ingestion of test values

Create a new csv file called statistics_test.csv with with headers val1, val2, val3, val4, and val5.
\n\nRefactor-2: data ingestion

Ingest the test values from a csv file instead of specifying hard coded values for the values array.
\n\nDocument the test data as a mermaid chart class diagram

Create a mermaid chart class diagram. #file: statistics_test.csv, #file: mermaid_csv.md
\n\nAdd a new column to the csv input file

Add a column named result to the input file that will either be pass or fail for each test, then after running each test, write the result to this column. #file:statistics_test.csv
\n\nShow the results from the csv file

After the test is complete, read and display the content of the #file:statistics_test.csv directly from the java test file.
\n\nRefactor to use the JUnit framework

Refactor the test file to use the JUnit framework if necessary for all testing operations. This is intended to improve test readability, assertions and overall structure.
\n\nRegression testing

Perform a final execution of the test to confirm that the last refactoring operation above did not change the successful behavior of the program.
\n\nThought Exercise

How else can we scale this application to make it handle more volume in a distributed architecture?
\n
