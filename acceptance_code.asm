// C# simulation of 6502 assembly logic to find union of two sets
using System;

class Union6502Simulation
{
    static void Main()
    {
        // Example sets
        byte[] setA = { 1, 2, 4, 5 };
        byte[] setB = { 2, 3, 5, 6 };

        // Maximum size for union (sum of sets' sizes)
        byte[] unionSet = new byte[setA.Length + setB.Length];
        int unionCount = 0;

        // Simulate 6502 register-like variables
        int regAIndex = 0; // pointer for setA
        int regBIndex = 0; // pointer for setB
        int regUnionIndex = 0; // pointer for unionSet

        // Helper functions to simulate assembly behavior
        bool IsInUnion(byte value)
        {
            for (int i = 0; i < unionCount; i++)
            {
                if (unionSet[i] == value)
                    return true;
            }
            return false;
        }

        // Process setA
        while (regAIndex < setA.Length)
        {
            byte current = setA[regAIndex];
            // Check if already in unionSet
            if (!IsInUnion(current))
            {
                unionSet[unionCount] = current;
                unionCount++;
            }
            regAIndex++;
        }

        // Process setB
        while (regBIndex < setB.Length)
        {
            byte current = setB[regBIndex];
            // Check if already in unionSet
            if (!IsInUnion(current))
            {
                unionSet[unionCount] = current;
                unionCount++;
            }
            regBIndex++;
        }

        // Output the union set
        Console.WriteLine("Union of sets:");
        for (int i = 0; i < unionCount; i++)
        {
            Console.Write($"{unionSet[i]} ");
        }
        Console.WriteLine();
    }
}