# Statistics Program Class Diagram

The following diagram represents the structure and relationships between components in the Go statistics program:

```mermaid
classDiagram
    class StatisticsProgram {
        -runCalculation: bool
        -firstRun: bool
        +main()
    }
<!-- [MermaidChart: 6d5ca563-fc7b-49f1-8756-656acc67fef3] -->
<!-- [MermaidChart: 6d5ca563-fc7b-49f1-8756-656acc67fef3] -->

    class IOHandler {
        +readUserInput() []float64, error
        +clearScreen()
        +handleCommandLineArgs() []float64, error
    }

    class StatisticsCalculator {
        +validateInput(values []float64) error
        +calculateStatistics(values []float64) (min float64, max float64, mean float64, stdDev float64)
    }

    class LogManager {
        -logFile: *os.File
        +setupLogging() error
        +logResult(values []float64, min float64, max float64, mean float64, stdDev float64)
    }

    class DataPoint {
        +value: float64
        +withinRange(min float64, max float64) bool
    }

    class StatisticsResult {
        +min: float64
        +max: float64
        +mean: float64
        +stdDev: float64
        +display()
    }

    StatisticsProgram --> IOHandler: uses
    StatisticsProgram --> StatisticsCalculator: uses
    StatisticsProgram --> LogManager: uses
    IOHandler ..> DataPoint: creates
    StatisticsCalculator ..> DataPoint: processes
    StatisticsCalculator --> StatisticsResult: produces
    StatisticsProgram --> StatisticsResult: displays
    LogManager ..> StatisticsResult: logs
```

## Explanation of Components

Although the Go program is not strictly object-oriented, this diagram represents the conceptual organization of the program's functionality:

1. **StatisticsProgram**: Represents the main program flow control, coordinating other components.

2. **IOHandler**: Handles all user input/output operations, including reading from command line and interactive input.

3. **StatisticsCalculator**: Contains the core algorithms for statistical calculations.

4. **LogManager**: Manages the logging operations throughout the program.

5. **DataPoint**: Represents a single value in the statistics calculation.

6. **StatisticsResult**: Contains the calculated statistics (min, max, mean, stdDev) and handles displaying them.

## CSV Data Structure

The program reads test data from statistics_test.csv with the following structure:

| Set      | Value1 | Value2 | Value3 | Value4 | Value5 | Min  | Max  | Mean | StdDev |
|----------|--------|--------|--------|--------|--------|------|------|------|--------|
| TestSet1 | 1.0    | 2.0    | 3.0    | 4.0    | 5.0    | 1.0  | 5.0  | 3.0  | 1.58   |
| TestSet2 | 2.5    | 3.5    | 4.5    | 5.5    | 6.5    | 2.5  | 6.5  | 4.5  | 1.58   |
| TestSet3 | 5.0    | 5.0    | 5.0    | 5.0    | 5.0    | 5.0  | 5.0  | 5.0  | 0.0    |
| TestSet4 | 1.0    | 10.0   | 5.0    | 7.0    | 3.0    | 1.0  | 10.0 | 5.2  | 3.49   |
| TestSet5 | 1.5    | 2.7    | 3.9    | 4.2    | 8.6    | 1.5  | 8.6  | 4.18 | 2.78   |

This data can be used to verify the accuracy of the statistics calculations performed by the program.