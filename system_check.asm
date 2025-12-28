using System;

class Program
{
    static void Main()
    {
        string input = "Hello, world! This is a test: does it work?";
        char[] outputChars = new char[input.Length];
        int outputIndex = 0;

        for (int i = 0; i < input.Length; i++)
        {
            char c = input[i];

            // Check if character is punctuation (assuming ASCII)
            if (!IsPunctuation(c))
            {
                outputChars[outputIndex++] = c;
            }
        }

        string result = new string(outputChars, 0, outputIndex);
        Console.WriteLine(result);
    }

    static bool IsPunctuation(char c)
    {
        // Define punctuation characters (basic set)
        // You can expand this as needed
        char[] punctuation = new char[]
        {
            '.', ',', '!', '?', ';', ':', '-', '\'', '\"', '(', ')', '[', ']', '{', '}', '/', '\\', '@', '#', '$', '%', '^', '&', '*', '_', '+', '=', '<', '>', '|', '~', '`'
        };
        return Array.Exists(punctuation, p => p == c);
    }
}