using System;
using System.IO;

class Program
{
    static void Main()
    {
        string filePath = "Quiz.cs"; // Ensure this path is correct

        try
        {
            // Read all lines from the file
            string[] lines = File.ReadAllLines(filePath);

            // Loop through and display each line
            foreach (string line in lines)
            {
                Console.WriteLine(line);
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"An error occurred: {ex.Message}");
        }
    }
}
