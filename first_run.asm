using System;
using System.Collections.Generic;

class Program
{
    static void Main()
    {
        // Sample data dictionary
        Dictionary<string, int> data = new Dictionary<string, int>
        {
            { "A", 5 },
            { "B", 3 },
            { "C", 8 },
            { "D", 2 },
            { "E", 6 }
        };

        // Find the maximum value for scaling
        int maxValue = 0;
        foreach (var value in data.Values)
        {
            if (value > maxValue)
                maxValue = value;
        }

        // Define the maximum width of the bar
        int maxBarWidth = 50;

        Console.WriteLine("Bar Chart:\n");

        foreach (var kvp in data)
        {
            string label = kvp.Key;
            int value = kvp.Value;

            // Calculate scaled bar length
            int barLength = (int)((value / (double)maxValue) * maxBarWidth);

            // Generate the bar string
            string bar = new string('#', barLength);

            // Output the label and bar
            Console.WriteLine($"{label.PadRight(3)} | {bar} ({value})");
        }
    }
}