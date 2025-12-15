using System;

class Program
{
    static void Main()
    {
        int year = 2024; // Example year
        bool isLeap = IsLeapYear(year);
        Console.WriteLine($"Year {year} is a leap year: {isLeap}");
    }

    static bool IsLeapYear(int year)
    {
        // A year is a leap year if:
        // 1. It is divisible by 4 AND
        // 2. It is NOT divisible by 100 unless it is divisible by 400.

        if (year % 4 != 0)
            return false;
        if (year % 100 != 0)
            return true;
        if (year % 400 == 0)
            return true;
        return false;
    }
}