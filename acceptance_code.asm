// C# implementation mimicking what a 6502 Assembly program would do to calculate the average
using System;

class Program
{
    static void Main()
    {
        // Example list of elements
        int[] list = { 10, 20, 30, 40, 50 };
        int length = list.Length;

        int sum = 0;
        for (int i = 0; i < length; i++)
        {
            sum += list[i];
        }

        // Calculate average
        int average = sum / length;

        Console.WriteLine($"Average: {average}");
    }
}