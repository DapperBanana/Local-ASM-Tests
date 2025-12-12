using System;

class Program
{
    // Function to compute the Greatest Common Divisor (GCD) using Euclidean algorithm
    static int GCD(int a, int b)
    {
        while (b != 0)
        {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    // Function to compute the Least Common Multiple (LCM)
    static int LCM(int a, int b)
    {
        if (a == 0 || b == 0) return 0; // LCM of zero is zero
        int gcd = GCD(a, b);
        return Math.Abs(a * b) / gcd;
    }

    static void Main()
    {
        Console.Write("Enter the first number: ");
        int num1 = int.Parse(Console.ReadLine());

        Console.Write("Enter the second number: ");
        int num2 = int.Parse(Console.ReadLine());

        int lcm = LCM(num1, num2);

        Console.WriteLine($"LCM of {num1} and {num2} is {lcm}");
    }
}