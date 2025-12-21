// Simulating a 6502 assembly program logic for a text-based weather forecast system in C#
using System;

class Program
{
    static void Main()
    {
        // Initialize system memory (simulating 6502 memory with simple variables)
        string[] weatherConditions = { "Sunny", "Cloudy", "Rainy", "Snowy", "Windy" };
        Random rand = new Random();

        // Simulate reading a weather code (0-4)
        int weatherCode = rand.Next(0, weatherConditions.Length);

        // Simulate 6502 assembly: Load weather code into accumulator (A register)
        int A = weatherCode; // Load weather code

        // Simulate a switch based on weather code (using if-else for simplicity)
        string forecast;
        if (A == 0)
        {
            forecast = "The forecast is Sunny. Enjoy your day!";
        }
        else if (A == 1)
        {
            forecast = "The forecast is Cloudy. Maybe take a jacket.";
        }
        else if (A == 2)
        {
            forecast = "The forecast is Rainy. Don't forget your umbrella.";
        }
        else if (A == 3)
        {
            forecast = "The forecast is Snowy. Stay warm!";
        }
        else if (A == 4)
        {
            forecast = "The forecast is Windy. Hold onto your hat!";
        }
        else
        {
            forecast = "Weather unknown.";
        }

        // Simulate output (printing the forecast)
        Console.WriteLine(forecast);
    }
}