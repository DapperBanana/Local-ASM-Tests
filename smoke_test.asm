using System;
using System.Collections.Generic;

class Program
{
    // Check if number n is prime
    static bool IsPrime(int n)
    {
        if (n <= 1) return false;
        if (n == 2) return true;
        if (n % 2 == 0) return false;
        int sqrtN = (int)Math.Sqrt(n);
        for (int i = 3; i <= sqrtN; i += 2)
        {
            if (n % i == 0) return false;
        }
        return true;
    }

    // Get prime factors of n
    static List<int> PrimeFactors(int n)
    {
        var factors = new List<int>();
        int num = n;
        for (int i = 2; i <= num / i; i++)
        {
            while (num % i == 0)
            {
                if (!factors.Contains(i))
                    factors.Add(i);
                num /= i;
            }
        }
        if (num > 1)
        {
            if (!factors.Contains(num))
                factors.Add(num);
        }
        return factors;
    }

    // Check if n is a Carmichael number via Korselt's criterion
    static bool IsCarmichael(int n)
    {
        if (n < 3) return false; // Carmichael numbers are > 1

        // Must be composite
        if (IsPrime(n)) return false;

        var factors = PrimeFactors(n);

        // For Korselt's criterion:
        // 1. n is square-free
        foreach (int p in factors)
        {
            if (n % (p * p) == 0)
                return false; // not square-free
        }

        // 2. For each prime divisor p, p - 1 divides n - 1
        foreach (int p in factors)
        {
            if ((n - 1) % (p - 1) != 0)
                return false;
        }

        // All conditions satisfied
        return true;
    }

    static void Main()
    {
        Console.WriteLine("Enter a number to check if it's a Carmichael number:");
        if (int.TryParse(Console.ReadLine(), out int number))
        {
            if (IsCarmichael(number))
                Console.WriteLine($"{number} is a Carmichael number.");
            else
                Console.WriteLine($"{number} is NOT a Carmichael number.");
        }
        else
        {
            Console.WriteLine("Invalid input.");
        }
    }
}