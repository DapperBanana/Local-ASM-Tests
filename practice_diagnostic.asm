using System;

class WeatherForecastSystem
{
    static void Main()
    {
        string[] weatherConditions = { "Sunny", "Cloudy", "Rainy", "Snowy", "Windy" };
        string[] timesOfDay = { "Morning", "Afternoon", "Evening" };
        Random rand = new Random();

        Console.WriteLine("Welcome to the Basic Weather Forecast System");
        Console.Write("Enter your city name: ");
        string city = Console.ReadLine();

        Console.WriteLine($"\nWeather forecast for {city}:\n");

        for (int i = 0; i < timesOfDay.Length; i++)
        {
            // Generate a pseudo-random forecast
            int conditionIndex = rand.Next(weatherConditions.Length);
            string condition = weatherConditions[conditionIndex];

            // Display forecast
            Console.WriteLine($"{timesOfDay[i]}: {condition}");
        }

        Console.WriteLine("\nThank you for using the weather forecast system!");
    }
}