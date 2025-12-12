// Note: This is a C# representation of 6502 assembly logic to find the second largest element.
// The code initializes memory segments to simulate 6502 registers and memory.
using System;

class Program
{
    static void Main()
    {
        // Simulated memory: list of integers (the data)
        byte[] data = { 5, 3, 9, 7, 2, 10, 4 };
        int length = data.Length;

        // Registers simulation
        byte max1 = 0; // Largest
        byte max2 = 0; // Second largest

        // Initialize max1 to minimal value
        max1 = 0;

        // First pass: find the maximum element
        for (int i = 0; i < length; i++)
        {
            byte val = data[i];
            if (val > max1)
            {
                max1 = val;
            }
        }

        // Initialize max2 to minimal value
        max2 = 0;

        // Second pass: find the second largest element
        for (int i = 0; i < length; i++)
        {
            byte val = data[i];
            if (val > max2 && val < max1)
            {
                max2 = val;
            }
        }

        Console.WriteLine("Second largest element: " + max2);
    }
}