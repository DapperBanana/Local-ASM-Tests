// This is a C# implementation that simulates a 6502 assembly program
// to check if a given string is a valid email address.
// Note: This is a high-level interpretation, as 6502 assembly is not directly
// translatable into C#, but the logic follows a similar approach.

using System;

public class EmailValidator6502
{
    public static bool IsValidEmail(string email)
    {
        // Initialize variables
        int atIndex = -1;
        int dotIndex = -1;
        int len = email.Length;

        // Check for presence of '@' and record its position
        for (int i = 0; i < len; i++)
        {
            if (email[i] == '@')
            {
                atIndex = i;
                break;
            }
        }

        // If '@' not found or at start/end, invalid
        if (atIndex <= 0 || atIndex >= len - 1)
            return false;

        // Check for '.' after '@'
        for (int i = atIndex + 1; i < len; i++)
        {
            if (email[i] == '.')
            {
                dotIndex = i;
                break;
            }
        }

        // '.' must come after '@' and not be immediately after '@' or at the end
        if (dotIndex <= atIndex + 1 || dotIndex >= len - 1)
            return false;

        // Basic checks passed, return true
        return true;
    }

    // Example usage
    public static void Main()
    {
        string[] testEmails = {
            "user@example.com",
            "user@domain",
            "@domain.com",
            "user@.com",
            "user@domain.co.uk",
            "user@domain.c",
            "user@domain..com",
            "user@@domain.com",
            "user@domain.com."
        };

        foreach (var email in testEmails)
        {
            Console.WriteLine($"{email} is valid: {IsValidEmail(email)}");
        }
    }
}