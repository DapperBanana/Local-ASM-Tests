using System;
using System.Collections.Generic;

class LanguageTranslator
{
    // Define a simple dictionary for translation
    static Dictionary<string, string> englishToSpanish = new Dictionary<string, string>
    {
        {"hello", "hola"},
        {"goodbye", "adios"},
        {"please", "por favor"},
        {"thank you", "gracias"},
        {"yes", "sí"},
        {"no", "no"}
    };

    static void Main()
    {
        Console.WriteLine("Enter a phrase to translate (English):");
        string input = Console.ReadLine();

        // Split input into words
        string[] words = input.Split(new char[] { ' ', '.', ',', '!', '?' }, StringSplitOptions.RemoveEmptyEntries);

        List<string> translatedWords = new List<string>();

        // Translate each word
        foreach (var word in words)
        {
            string lowerWord = word.ToLower();
            if (englishToSpanish.ContainsKey(lowerWord))
            {
                translatedWords.Add(englishToSpanish[lowerWord]);
            }
            else
            {
                // If not found, keep original word
                translatedWords.Add(word);
            }
        }

        // Output the translated phrase
        Console.WriteLine("Translated (Spanish):");
        Console.WriteLine(string.Join(" ", translatedWords));
    }
}