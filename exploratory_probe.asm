using System;

class TextBasedCalendar
{
    // Days in months for a non-leap year
    static int[] daysInMonth = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };

    static void Main()
    {
        // Choose a year and month for the calendar
        int year = 2023;
        int month = 1; // January

        // Adjust February for leap years
        if (IsLeapYear(year))
            daysInMonth[1] = 29;
        else
            daysInMonth[1] = 28;

        // Calculate the weekday of the first day of the month
        int startDay = CalculateWeekday(year, month, 1); // 0=Sunday, 1=Monday,...

        Console.WriteLine($"Calendar for {GetMonthName(month)} {year}");
        Console.WriteLine("Su Mo Tu We Th Fr Sa");

        // Print initial spaces
        for (int i = 0; i < startDay; i++)
        {
            Console.Write("   ");
        }

        int days = daysInMonth[month - 1];

        for (int day = 1; day <= days; day++)
        {
            Console.Write($"{day,2} ");
            startDay++;
            if (startDay % 7 == 0)
            {
                Console.WriteLine();
            }
        }
        Console.WriteLine();
    }

    static bool IsLeapYear(int year)
    {
        // Leap year rule
        return (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
    }

    static int CalculateWeekday(int year, int month, int day)
    {
        // Zeller's Congruence algorithm
        if (month < 3)
        {
            month += 12;
            year--;
        }

        int K = year % 100;
        int J = year / 100;

        int h = (day + 13 * (month + 1) / 5 + K + K / 4 + J / 4 + 5 * J) % 7;

        // 0=Saturday, so adjust to 0=Sunday
        int dayOfWeek = (h + 6) % 7;

        return dayOfWeek;
    }

    static string GetMonthName(int month)
    {
        string[] months = { "January", "February", "March", "April", "May", "June",
                            "July", "August", "September", "October", "November", "December" };
        return months[month - 1];
    }
}