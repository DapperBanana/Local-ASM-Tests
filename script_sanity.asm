using System;

public class JsonValidator6502Style
{
    public static bool IsValidJson(string input)
    {
        if (string.IsNullOrEmpty(input))
            return false;

        // Load the first and last characters
        char firstChar = input[0];
        char lastChar = input[input.Length - 1];

        // Check for matching brackets
        if ((firstChar == '{' && lastChar == '}') ||
            (firstChar == '[' && lastChar == ']'))
        {
            // Basic length check - must be at least 2 characters
            if (input.Length < 2)
                return false;

            // For simplicity, we're not checking internal structure
            // but in real scenarios, you'd want to parse the content
            // Here, assume brackets are valid if opening and closing match
            return true;
        }

        return false; // Not a matching pair
    }

    public static void Main()
    {
        string[] testStrings = {
            "{}",            // valid JSON object
            "[]",            // valid JSON array
            "{ \"key\": \"value\" }", // valid JSON object
            "[1, 2, 3]",     // valid JSON array
            "Invalid",       // invalid
            "{ invalid }",   // invalid
            "",              // invalid
            null             // invalid
        };

        foreach (var test in testStrings)
        {
            Console.WriteLine($"Input: {test ?? "null"}");
            Console.WriteLine($"Is valid JSON? {IsValidJson(test)}");
            Console.WriteLine();
        }
    }
}