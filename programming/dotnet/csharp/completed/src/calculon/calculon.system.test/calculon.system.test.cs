using Microsoft.VisualStudio.TestPlatform.TestHost;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.IO;
using System.Text;

[TestClass]
public class CalculonSystemTests
{
    [TestMethod]
    public void SystemTest_Addition()
    {
        var input = new StringBuilder();
        input.AppendLine("2"); // First number
        input.AppendLine("3"); // Second number
        input.AppendLine("+"); // Operator
        input.AppendLine("no"); // Terminate the program

        using (var inputReader = new StringReader(input.ToString()))
        using (var outputWriter = new StringWriter())
        {
            Console.SetIn(inputReader);
            Console.SetOut(outputWriter);

            Program.Main();

            var output = outputWriter.ToString();
            StringAssert.Contains(output, "Result: 5");
            StringAssert.Contains(output, "User has terminated the program!");
        }
    }

    [TestMethod]
    public void SystemTest_Subtraction()
    {
        var input = new StringBuilder();
        input.AppendLine("5"); // First number
        input.AppendLine("3"); // Second number
        input.AppendLine("-"); // Operator
        input.AppendLine("no"); // Terminate the program

        using (var inputReader = new StringReader(input.ToString()))
        using (var outputWriter = new StringWriter())
        {
            Console.SetIn(inputReader);
            Console.SetOut(outputWriter);

            Program.Main();

            var output = outputWriter.ToString();
            StringAssert.Contains(output, "Result: 2");
            StringAssert.Contains(output, "User has terminated the program!");
        }
    }

    [TestMethod]
    public void SystemTest_Multiplication()
    {
        var input = new StringBuilder();
        input.AppendLine("2"); // First number
        input.AppendLine("3"); // Second number
        input.AppendLine("*"); // Operator
        input.AppendLine("no"); // Terminate the program

        using (var inputReader = new StringReader(input.ToString()))
        using (var outputWriter = new StringWriter())
        {
            Console.SetIn(inputReader);
            Console.SetOut(outputWriter);

            Program.Main();

            var output = outputWriter.ToString();
            StringAssert.Contains(output, "Result: 6");
            StringAssert.Contains(output, "User has terminated the program!");
        }
    }

    [TestMethod]
    public void SystemTest_Division()
    {
        var input = new StringBuilder();
        input.AppendLine("6"); // First number
        input.AppendLine("3"); // Second number
        input.AppendLine("/"); // Operator
        input.AppendLine("no"); // Terminate the program

        using (var inputReader = new StringReader(input.ToString()))
        using (var outputWriter = new StringWriter())
        {
            Console.SetIn(inputReader);
            Console.SetOut(outputWriter);

            Program.Main();

            var output = outputWriter.ToString();
            StringAssert.Contains(output, "Result: 2");
            StringAssert.Contains(output, "User has terminated the program!");
        }
    }

    [TestMethod]
    public void SystemTest_InvalidOperator()
    {
        var input = new StringBuilder();
        input.AppendLine("2"); // First number
        input.AppendLine("3"); // Second number
        input.AppendLine("%"); // Invalid operator
        input.AppendLine("no"); // Terminate the program

        using (var inputReader = new StringReader(input.ToString()))
        using (var outputWriter = new StringWriter())
        {
            Console.SetIn(inputReader);
            Console.SetOut(outputWriter);

            Program.Main();

            var output = outputWriter.ToString();
            StringAssert.Contains(output, "Invalid operator.");
            StringAssert.Contains(output, "User has terminated the program!");
        }
    }
}
