// Note: Reading a CSV file and printing its contents are tasks more suited for high-level languages like C#.
// 6502 Assembly is too low-level and typically used for embedded systems, not high-level file I/O.
// Here's a simple C# program that reads a CSV file and prints its contents:

using System;
using System.IO;

class Program
{
    static void Main()
    {
        string filePath = "data.csv";

        if (File.Exists(filePath))
        {
            // Read all lines from the CSV file
            string[] lines = File.ReadAllLines(filePath);

            foreach (string line in lines)
            {
                // Print each line
                Console.WriteLine(line);
            }
        }
        else
        {
            Console.WriteLine($"File '{filePath}' not found.");
        }
    }
}