// Emulating 6502 assembly logic in C# for calculating area of a parallelogram
using System;

class ParallelogramArea6502
{
    static void Main()
    {
        // Registers simulation
        byte A = 0;   // Accumulator
        byte X = 0;   // Index Register X
        byte Y = 0;   // Index Register Y
        byte temp = 0; // Temporary register for calculations

        // Input: base (b) and height (h)
        // For simplicity, assign some example values
        byte baseLength = 10;   // e.g., base length
        byte height = 5;        // e.g., height

        // Simulate assembly: Load base length into A
        A = baseLength;
        // Store base length temporarily if needed (simulating memory or zero page)
        
        // Load height into Y register
        Y = height;

        // Calculate area = base * height
        // Assembly: multiply A (base) * Y (height) -> result in A
        // Since 6502 doesn't have multiply, simulate via repeated addition
        int area = 0;
        for (int i = 0; i < Y; i++)
        {
            area += A;
        }

        // Output the result
        Console.WriteLine($"Calculating the area of a parallelogram with base {baseLength} and height {height}:");
        Console.WriteLine($"Area = {area}");
    }
}