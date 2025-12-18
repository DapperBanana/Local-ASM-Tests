using System;

class Program
{
    // Simulate the 6502 registers
    static int A; // Accumulator
    static int X; // Index register X
    static int Y; // Index register Y

    // Simulate memory (list of integers)
    static int[] memory;

    static void Main()
    {
        // Sample list to sort
        memory = new int[] { 5, 2, 9, 1, 5, 6 };

        Console.WriteLine("Before sorting: " + string.Join(", ", memory));
        BubbleSort();
        Console.WriteLine("After sorting: " + string.Join(", ", memory));
    }

    static void BubbleSort()
    {
        int n = memory.Length;
        bool swapped;
        do
        {
            swapped = false;
            // For each pass
            for (X = 0; X < n - 1; X++)
            {
                // Load memory[X] into A
                A = memory[X];
                // Load memory[X + 1] into Y
                Y = memory[X + 1];

                // Compare A and Y
                if (A > Y)
                {
                    // Swap them
                    memory[X] = Y;       // Store Y into memory[X]
                    memory[X + 1] = A;   // Store A into memory[X + 1]
                    swapped = true;      // Swap occurred
                }
            }
            n--; // Reduce the range for optimization
        } while (swapped);
    }
}