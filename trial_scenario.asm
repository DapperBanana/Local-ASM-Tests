// Note: The following C# code simulates the logic of a 6502 assembly program
// to calculate the sum of all prime numbers up to a given limit.
// It encapsulates the core logic in C# for clarity.

using System;

class PrimeSum6502Simulation
{
    static void Main()
    {
        int limit = 50; // You can change this limit as needed
        int sum = 0;

        for (int num = 2; num <= limit; num++)
        {
            bool isPrime = true;

            for (int divisor = 2; divisor * divisor <= num; divisor++)
            {
                // Simulates division check in assembly
                if (num % divisor == 0)
                {
                    isPrime = false;
                    break;
                }
            }

            if (isPrime)
            {
                sum += num;
            }
        }

        Console.WriteLine($"Sum of primes up to {limit}: {sum}");
    }
}