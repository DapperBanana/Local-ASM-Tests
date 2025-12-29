using System;
using System.Collections.Generic;
using System.IO;
using Newtonsoft.Json; // Make sure to include the Newtonsoft.Json NuGet package

class Program
{
    static void Main(string[] args)
    {
        string jsonFilePath = "yourfile.json"; // Specify your JSON file path here

        try
        {
            // Read the entire JSON content from the file
            string jsonContent = File.ReadAllText(jsonFilePath);

            // Deserialize JSON into a Dictionary<string, object>
            var keyValues = JsonConvert.DeserializeObject<Dictionary<string, object>>(jsonContent);

            // Print each key-value pair
            foreach (var kvp in keyValues)
            {
                Console.WriteLine($"{kvp.Key}: {kvp.Value}");
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error reading or parsing JSON: {ex.Message}");
        }
    }
}