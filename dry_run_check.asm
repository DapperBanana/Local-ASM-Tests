using System;

class Program
{
    static void Main()
    {
        // Example number
        int number = 12345;
        int sumOfDigits = SumDigits(number);
        Console.WriteLine($"Sum of digits in {number} is {sumOfDigits}");
    }

    static int SumDigits(int num)
    {
        int sum = 0;

        // We will simulate the 6502 approach:
        // Repeatedly extract the last digit and add it to sum
        while (num > 0)
        {
            // Get the last digit
            int digit = num % 10;

            // Add to sum
            sum += digit;

            // Remove the last digit
            num /= 10;
        }

        return sum;
    }
}