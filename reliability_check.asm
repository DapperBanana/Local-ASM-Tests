using System;

class BasicTextCalendar
{
    // Days in each month for a non-leap year
    static int[] daysInMonth = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
    static string[] monthNames = { "January", "February", "March", "April", "May", "June",
                                   "July", "August", "September", "October", "November", "December" };

    static void Main()
    {
        int year = 2023; // Example year
        Console.WriteLine("Calendar for {0}\n", year);

        // Loop through each month
        for (int month = 0; month < 12; month++)
        {
            PrintMonth(year, month);
        }
    }

    static void PrintMonth(int year, int month)
    {
        Console.WriteLine("     {0} {1}", monthNames[month], year);
        Console.WriteLine("Su Mo Tu We Th Fr Sa");

        int totalDays = daysInMonth[month];

        // Check for leap year in February
        if (month == 1 && IsLeapYear(year))
        {
            totalDays = 29;
        }

        // Calculate the day of week for the first day of the month
        int firstDayOfWeek = GetDayOfWeek(year, month + 1, 1); // months are 1-based in calculation

        // Print leading spaces
        for(int i=0; i<firstDayOfWeek; i++)
        {
            Console.Write("   ");
        }

        // Print days
        for(int day=1; day <= totalDays; day++)
        {
            Console.Write("{0,2} ", day);
            if ((firstDayOfWeek + day) % 7 == 0)
            {
                Console.WriteLine();
            }
        }
        Console.WriteLine("\n");
    }

    static bool IsLeapYear(int year)
    {
        if (year % 400 == 0) return true;
        if (year % 100 == 0) return false;
        return year % 4 == 0;
    }

    // Zeller's Congruence algorithm for calculating day of week
    // Returns 0=Sunday, 1=Monday, ..., 6=Saturday
    static int GetDayOfWeek(int year, int month, int day)
    {
        if (month < 3)
        {
            month += 12;
            year -=1;
        }
        int K = year % 100;
        int J = year / 100;

        int h = (day + (13 * (month + 1)) / 5 + K + (K / 4) + (J / 4) + 5 * J) % 7;
        // Convert to 0=Sunday, 1=Monday,...
        int dayOfWeek = (h + 6) %7;
        return dayOfWeek;
    }
}