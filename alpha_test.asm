using System;
using System.Text;

class Program
{
    static void Main()
    {
        string input = "Hello, World! This is a test... Remove punctuations: should work!";
        string output = RemovePunctuation(input);
        Console.WriteLine(output);
    }

    static string RemovePunctuation(string input)
    {
        StringBuilder result = new StringBuilder();

        foreach (char ch in input)
        {
            // Check if the character is punctuation
            if (!char.IsPunctuation(ch))
            {
                result.Append(ch);
            }
        }

        return result.ToString();
    }
}