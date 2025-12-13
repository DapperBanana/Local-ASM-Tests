using System;
using System.Collections.Generic;

class Program
{
    static void Main()
    {
        // Define a simple dictionary for translation (English to Spanish)
        var translator = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase)
        {
            { "hello", "hola" },
            { "world", "mundo" },
            { "cat", "gato" },
            { "dog", "perro" },
            { "goodbye", "adiós" }
        };

        Console.WriteLine("Enter a sentence to translate (English to Spanish):");
        string input = Console.ReadLine();

        // Split the input into words
        string[] words = input.Split(' ', StringSplitOptions.RemoveEmptyEntries);
        var translatedWords = new List<string>();

        foreach (var word in words)
        {
            if (translator.TryGetValue(word, out string translated))
            {
                translatedWords.Add(translated);
            }
            else
            {
                // If word not found, keep it as is
                translatedWords.Add(word);
            }
        }

        // Output the translated sentence
        Console.WriteLine("Translated sentence:");
        Console.WriteLine(string.Join(" ", translatedWords));
    }
}