using System;
using System.Collections.Generic;

class Program
{
    static void Main()
    {
        // Sample translation dictionary
        var translations = new Dictionary<string, string>
        {
            { "hello", "hola" },
            { "world", "mundo" },
            { "goodbye", "adios" },
            { "thank", "gracias" },
            { "you", "tú" }
        };

        Console.WriteLine("Enter text to translate:");
        string input = Console.ReadLine();

        // Process input and translate
        string[] words = input.Split(' ', StringSplitOptions.RemoveEmptyEntries);
        for (int i = 0; i < words.Length; i++)
        {
            string key = words[i].ToLower().Trim(new char[] { '.', ',', '!', '?' });
            if (translations.ContainsKey(key))
            {
                // Replace with translation
                words[i] = words[i].Replace(key, translations[key]);
            }
        }

        string translatedText = string.Join(' ', words);
        Console.WriteLine("Translated text:");
        Console.WriteLine(translatedText);
    }
}