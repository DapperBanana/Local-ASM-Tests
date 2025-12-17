using System;
using System.IO;
using Newtonsoft.Json.Linq;

class Program
{
    static void Main(string[] args)
    {
        // Check if file path is provided
        if (args.Length != 1)
        {
            Console.WriteLine("Usage: program <json-file-path>");
            return;
        }

        string jsonFilePath = args[0];

        try
        {
            // Read the JSON file content
            string jsonContent = File.ReadAllText(jsonFilePath);

            // Parse JSON content
            var jsonObject = JObject.Parse(jsonContent);

            // Iterate over key-value pairs
            foreach (var property in jsonObject.Properties())
            {
                Console.WriteLine($"{property.Name}: {property.Value}");
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Error reading or parsing JSON file: {ex.Message}");
        }
    }
}