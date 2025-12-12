using System;
using System.IO;

class WordCounter
{
    static void Main(string[] args)
    {
        // Check if filename is provided
        if (args.Length != 1)
        {
            Console.WriteLine("Usage: WordCounter <filename>");
            return;
        }

        string filename = args[0];

        try
        {
            // Read all text from the file
            string text = File.ReadAllText(filename);

            // Split the text into words based on whitespace
            string[] words = text.Split(new char[] { ' ', '\t', '\r', '\n' }, StringSplitOptions.RemoveEmptyEntries);

            // Count the words
            int wordCount = words.Length;

            Console.WriteLine($"Number of words in '{filename}': {wordCount}");
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error reading file: {ex.Message}");
        }
    }
}