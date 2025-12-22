// Note: The following C# code is a simulation of a 6502 assembly program that creates a basic text-based calendar.
// It demonstrates how such logic could be translated into C# for demonstration purposes.
//
// The program prompts the user to input a year and a month, then displays the calendar for that month.

// Since the instruction was to provide the simulation in C# (not actual 6502 assembly), the code is written in C#.

using System;

class TextCalendarSimulator
{
    static void Main()
    {
        Console.Write("Enter year (e.g., 2023): ");
        int year = int.Parse(Console.ReadLine());

        Console.Write("Enter month (1-12): ");
        int month = int.Parse(Console.ReadLine());

        PrintCalendar(year, month);
    }

    static void PrintCalendar(int year, int month)
    {
        string[] months = {
            "January", "February", "March", "April", "May", "June",
            "July", "August", "September", "October", "November", "December"
        };

        int daysInMonth = GetDaysInMonth(year, month);
        int firstDayWeekday = GetFirstWeekdayOfMonth(year, month);

        Console.WriteLine($"\n     {months[month - 1]} {year}");
        Console.WriteLine("Su Mo Tu We Th Fr Sa");

        int dayCounter = 1;
        int weekdayCounter = 0;

        // Print initial spaces for the first week
        for (int i = 0; i < firstDayWeekday; i++)
        {
            Console.Write("   ");
            weekdayCounter++;
        }

        // Print days of the month
        while (dayCounter <= daysInMonth)
        {
            Console.Write($"{dayCounter,2} ");
            weekdayCounter++;
            if (weekdayCounter == 7)
            {
                Console.WriteLine();
                weekdayCounter = 0;
            }
            dayCounter++;
        }
        Console.WriteLine();
    }

    // Returns true if leap year
    static bool IsLeapYear(int year)
    {
        return (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
    }

    // Returns number of days in a given month and year
    static int GetDaysInMonth(int year, int month)
    {
        switch (month)
        {
            case 2:
                return IsLeapYear(year) ? 29 : 28;
            case 4:
            case 6:
            case 9:
            case 11:
                return 30;
            default:
                return 31;
        }
    }

    // Zeller's Congruence to compute the day of the week
    // 0 = Saturday, 1= Sunday, ..., 6=Friday
    static int GetFirstWeekdayOfMonth(int year, int month)
    {
        int q = 1; // Day of month
        int m = month;
        int y = year;
        if (m < 3)
        {
            m += 12;
            y -= 1;
        }
        int K = y % 100;
        int J = y / 100;

        int h = (q + (13 * (m + 1)) / 5 + K + (K / 4) + (J / 4) + 5 * J) % 7;

        // Convert Zeller's output to Sunday=0 ... Saturday=6
        // Zeller's h: 0=Saturday, 1=Sunday,... 6=Friday
        // So, Sunday=1, Saturday=0
        // To have Sunday=0, Saturday=6, etc.:
        int dayOfWeek = (h + 6) % 7;
        return dayOfWeek;
    }
}