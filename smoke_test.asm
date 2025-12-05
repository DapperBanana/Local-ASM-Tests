using System;

class Program
{
    // Function to compute GCD (Greatest Common Divisor) using Euclidean Algorithm
    static int GCD(int a, int b)
    {
        while (b != 0)
        {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return Math.Abs(a);
    }

    // Function to compute LCM of two numbers
    static int LCM(int a, int b)
    {
        return Math.Abs(a * b) / GCD(a, b);
    }

    // Function to compute LCM of a list of numbers
    static int ComputeLCM(int[] numbers)
    {
        if (numbers == null || numbers.Length == 0)
            throw new ArgumentException("The list of numbers must not be empty.");

        int lcm = numbers[0];
        for (int i = 1; i < numbers.Length; i++)
        {
            lcm = LCM(lcm, numbers[i]);
        }
        return lcm;
    }

    static void Main()
    {
        int[] numbers = { 4, 6, 8, 12 };
        int lcm = ComputeLCM(numbers);
        Console.WriteLine($"LCM of {string.Join(", ", numbers)} is {lcm}");
    }
}