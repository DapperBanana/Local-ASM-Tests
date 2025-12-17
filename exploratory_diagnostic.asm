// C# code simulating a 6502 assembly program to find and print the smallest prime greater than a given number
using System;

class PrimeFinder6502Simulation
{
    static void Main()
    {
        int startNumber = 100; // example starting number
        int result = FindNextPrime(startNumber);
        Console.WriteLine($"Smallest prime greater than {startNumber} is {result}");
    }

    static int FindNextPrime(int number)
    {
        int candidate = number + 1;

        while (true)
        {
            if (IsPrime(candidate))
                return candidate;

            candidate++;
        }
    }

    static bool IsPrime(int num)
    {
        if (num < 2) return false;

        int sqrt = (int)Math.Sqrt(num);
        for (int i = 2; i <= sqrt; i++)
        {
            if (num % i == 0)
                return false;
        }
        return true;
    }
}