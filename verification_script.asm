// Note: This is a simulation of 6502 assembly logic using C# for illustration.
// In a real 6502 environment, you'd write the assembly code directly.
// Here, the C# code mimics the logic for summing primes in a range.

using System;

class PrimeSum6502Simulation
{
    static void Main()
    {
        int startRange = 10; // Example start of range
        int endRange = 50;   // Example end of range
        int sum = 0;

        for (int num = startRange; num <= endRange; num++)
        {
            if (IsPrime(num))
            {
                sum += num;
            }
        }

        Console.WriteLine($"Sum of primes in range {startRange}-{endRange}: {sum}");
    }

    // Simulates the prime checking logic similar to 6502 assembly
    static bool IsPrime(int number)
    {
        if (number < 2) return false;

        for (int divisor = 2; divisor * divisor <= number; divisor++)
        {
            // In 6502 assembly, this would involve division routines
            if (number % divisor == 0)
                return false;
        }
        return true;
    }
}