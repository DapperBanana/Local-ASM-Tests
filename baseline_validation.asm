using System;

class Program
{
    static void Main()
    {
        string input = "0-306-40615-2"; // Example ISBN, replace as needed
        Console.WriteLine($"Is valid ISBN: {IsValidISBN10(input)}");
    }

    static bool IsValidISBN10(string isbn)
    {
        // Remove hyphens
        string cleaned = isbn.Replace("-", "").ToUpper();

        // Check length
        if (cleaned.Length != 10)
            return false;

        int sum = 0;

        for (int i = 0; i < 10; i++)
        {
            char c = cleaned[i];

            int digit;

            if (i == 9 && c == 'X')
            {
                // 'X' can be used only as the checksum character
                digit = 10;
            }
            else if (char.IsDigit(c))
            {
                digit = c - '0';
            }
            else
            {
                // Invalid character
                return false;
            }

            // Calculate checksum based on position
            sum += (10 - i) * digit;
        }

        // Valid if checksum mod 11 == 0
        return (sum % 11 == 0);
    }
}