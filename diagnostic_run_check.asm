using System;

public class DigitSum
{
    public static void Main()
    {
        int number = 12345; // Example number, can change as needed
        int result = SumDigitsUntilSingleDigit(number);
        Console.WriteLine($"Result: {result}");
    }

    public static int SumDigitsUntilSingleDigit(int num)
    {
        while (num > 9) // Continue until the number is a single digit
        {
            int sum = 0;
            while (num > 0)
            {
                sum += num % 10; // Add last digit
                num /= 10;       // Remove last digit
            }
            num = sum; // Set to the sum for next iteration if needed
        }
        return num;
    }
}