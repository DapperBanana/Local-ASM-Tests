using System;

class Program
{
    static void Main()
    {
        // Sample list of elements (can be modified)
        byte[] list = { 10, 20, 30, 40, 50 };
        int length = list.Length;

        // Emulate 6502 memory
        byte[] memory = new byte[256];

        // Load list data into memory starting at address 0x00
        Array.Copy(list, 0, memory, 0x00, length);

        // Initialize counter (X) to 0 at 0x80
        memory[0x80] = 0;  
        // Initialize sum (A) to 0 at 0x81
        memory[0x81] = 0;  
        // Store length at 0x82
        memory[0x82] = (byte)length;

        // Address pointers
        // Data start address
        int dataPtr = 0x00;

        // Loop:
        // 1. Load current element into A from memory[dataPtr]
        // 2. Add A to sum (memory[0x81])
        // 3. Increment dataPtr
        // 4. Increment counter X (0x80)
        // 5. Loop until X == length

        while (true)
        {
            // Check if all elements processed
            if (memory[0x80] >= memory[0x82])
                break;

            // Load element at dataPtr into A
            byte element = memory[dataPtr];
            int sum = memory[0x81] & 0xFF;
            sum += element;
            memory[0x81] = (byte)sum;

            // Increment data pointer
            dataPtr++;

            // Increment X (counter)
            memory[0x80]++;
        }

        // Calculate average: sum / length
        int totalSum = memory[0x81] & 0xFF;
        int count = memory[0x82];

        int average = totalSum / count;

        Console.WriteLine($"Sum: {totalSum}");
        Console.WriteLine($"Count: {count}");
        Console.WriteLine($"Average: {average}");
    }
}