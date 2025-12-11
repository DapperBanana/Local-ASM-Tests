using System;

class Program
{
    // Checks if 'n' is a Carmichael number
    public static void Main()
    {
        Console.WriteLine("Enter a number:");
        string input = Console.ReadLine();
        if (ulong.TryParse(input, out ulong n))
        {
            bool result = IsCarmichael(n);
            Console.WriteLine($"{n} is {(result ? "" : "not ")}a Carmichael number.");
        }
        else
        {
            Console.WriteLine("Invalid input.");
        }
    }

    // Determine if 'n' is a Carmichael number
    public static bool IsCarmichael(ulong n)
    {
        if (n < 3 || IsPrime(n))
            return false;

        for (ulong b = 2; b < n; b++)
        {
            if (GCD(b, n) == 1)
            {
                if (ModPow(b, n - 1, n) != 1)
                    return false;
            }
        }
        return true;
    }

    // Compute GCD using Euclidean algorithm
    public static ulong GCD(ulong a, ulong b)
    {
        while (b != 0)
        {
            ulong temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    // Check if number is prime
    public static bool IsPrime(ulong n)
    {
        if (n < 2)
            return false;
        if (n == 2 || n == 3)
            return true;
        if (n % 2 == 0)
            return false;

        ulong sqrtN = (ulong)Math.Sqrt(n);
        for (ulong i = 3; i <= sqrtN; i += 2)
        {
            if (n % i == 0)
                return false;
        }
        return true;
    }

    // Modular exponentiation
    public static ulong ModPow(ulong baseNum, ulong exponent, ulong modulus)
    {
        ulong result = 1;
        ulong baseMod = baseNum % modulus;

        while (exponent > 0)
        {
            if ((exponent & 1) == 1)
            {
                result = (result * baseMod) % modulus;
            }
            baseMod = (baseMod * baseMod) % modulus;
            exponent >>= 1;
        }
        return result;
    }
}