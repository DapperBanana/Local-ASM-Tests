using System;

class Program
{
    static void Main()
    {
        int number = 12345; // Example input
        int result = SumDigitsUntilSingleDigit(number);
        Console.WriteLine($"The final single-digit sum is: {result}");
    }

    static int SumDigitsUntilSingleDigit(int num)
    {
        while (num >= 10)
        {
            int sum = 0;
            while (num > 0)
            {
                sum += num % 10; // add last digit
                num /= 10; // remove last digit
            }
            num = sum; // assign sum to num for next iteration
        }
        return num;
    }
}