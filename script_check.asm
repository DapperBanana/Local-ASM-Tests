using System;

class ISBNChecker
{
    public static void Main()
    {
        Console.WriteLine("Enter ISBN (10 characters, digits or 'X' at the end):");
        string input = Console.ReadLine().Trim();

        if (IsValidISBN(input))
        {
            Console.WriteLine("Valid ISBN");
        }
        else
        {
            Console.WriteLine("Invalid ISBN");
        }
    }

    static bool IsValidISBN(string isbn)
    {
        if (isbn.Length != 10)
            return false;

        int sum = 0;
        for (int i = 0; i < 10; i++)
        {
            char c = isbn[i];
            int value;

            if (i == 9 && (c == 'X' || c == 'x'))
            {
                value = 10;
            }
            else if (char.IsDigit(c))
            {
                value = c - '0';
            }
            else
            {
                return false; // Invalid character
            }

            sum += (i + 1) * value; // position (1-based) times value
        }

        return sum % 11 == 0;
    }
}