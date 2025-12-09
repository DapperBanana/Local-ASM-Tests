using System;
using System.Collections.Generic;

public class RomanToInteger
{
    static Dictionary<char, int> romanValues = new Dictionary<char, int>()
    {
        {'I', 1},
        {'V', 5},
        {'X', 10},
        {'L', 50},
        {'C', 100},
        {'D', 500},
        {'M', 1000}
    };

    public static int RomanToInt(string roman)
    {
        int total = 0;
        int prevValue = 0;

        // Process from right to left to handle subtractive notation
        for (int i = roman.Length - 1; i >= 0; i--)
        {
            char c = roman[i];

            if (!romanValues.TryGetValue(c, out int value))
                throw new ArgumentException($"Invalid Roman numeral character: {c}");

            if (value < prevValue)
            {
                total -= value;
            }
            else
            {
                total += value;
            }
            prevValue = value;
        }
        return total;
    }

    static void Main()
    {
        string romanNumeral = "MCMXCIV"; // Example input
        int result = RomanToInt(romanNumeral);
        Console.WriteLine($"{romanNumeral} => {result}");
    }
}