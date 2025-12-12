// Simulates a 6502 assembly program to compute factorial using C#
using System;

class Program
{
    static void Main()
    {
        // Input number for factorial calculation
        int inputNumber = 6; // Change this value as needed (0-12 for safe factorial within int limits)
        
        // Registers to simulate 6502 registers
        int A = 0;    // Accumulator
        int X = 0;    // Index register
        int Y = 0;    // Index register
        int temp;     // Temporary variable
        int result;   // Will hold the factorial result
        int counter;// Loop counter
        
        // Initialize registers
        A = 1; // factorial result starts at 1
        result = 1;
        counter = inputNumber; // Loop counter for factorial
        
        if (counter == 0 || counter == 1)
        {
            result = 1;
        }
        else
        {
            // Loop: factorial calculation
            while (counter > 1)
            {
                // Multiply accumulator by counter
                A = A * counter;
                counter--;
            }
            result = A;
        }
        
        Console.WriteLine($"Factorial of {inputNumber} is {result}");
    }
}