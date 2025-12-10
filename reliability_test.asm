using System;

class CreditCardValidator
{
    public static void Main()
    {
        Console.WriteLine("Enter credit card number:");
        string cardNumber = Console.ReadLine().Trim();

        if (IsValidCreditCardNumber(cardNumber))
            Console.WriteLine("Valid credit card number.");
        else
            Console.WriteLine("Invalid credit card number.");
    }

    public static bool IsValidCreditCardNumber(string number)
    {
        // Remove any spaces or dashes
        number = number.Replace(" ", "").Replace("-", "");

        // Check if all characters are digits
        foreach (char c in number)
        {
            if (!char.IsDigit(c))
                return false;
        }

        int sum = 0;
        bool alternate = false;
        // Process from right to left
        for (int i = number.Length - 1; i >= 0; i--)
        {
            int n = number[i] - '0';

            if (alternate)
            {
                n *= 2;
                if (n > 9)
                    n -= 9;
            }

            sum += n;
            alternate = !alternate;
        }

        return (sum % 10 == 0);
    }
}