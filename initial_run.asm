// Note: C# code implementing a 6502 assembly idea for checking if a string is an isogram is a bit unconventional since C# is high-level.
// But assuming you want a C# code that simulates what a 6502 assembly program might do for this task,
// here is a possible implementation:

using System;

class IsogramChecker
{
    public static bool IsIsogram(string input)
    {
        if (string.IsNullOrEmpty(input))
            return true;

        // Create an array to track occurrences of letters (assuming ASCII lowercase letters)
        // We'll handle case-insensitivity by converting all to lowercase.
        bool[] seen = new bool[128]; // ASCII range

        string normalized = input.ToLower();

        foreach (char c in normalized)
        {
            if (c >= 'a' && c <= 'z')
            {
                int index = c; // ASCII code
                if (seen[index])
                {
                    // Letter has been seen before
                    return false;
                }
                seen[index] = true;
            }
            // Ignore non-letter characters
        }

        return true;
    }

    static void Main()
    {
        string[] testStrings = {
            "Dermatoglyphics",
            "Alphabet",
            "background",
            "12345",
            "hello",
            "world",
            "robber",
            ""
        };

        foreach (var s in testStrings)
        {
            Console.WriteLine($"'{s}': {IsIsogram(s)}");
        }
    }
}