using System;
using System.Collections.Generic;

public class LongestCommonPrefixFinder
{
    public static string FindLongestCommonPrefix(List<string> strings)
    {
        if (strings == null || strings.Count == 0)
            return "";

        int prefixLength = 0;
        bool continueChecking = true;

        while (continueChecking)
        {
            if (prefixLength >= strings[0].Length)
                break;

            // Fetch the character at current position from the first string
            char currentChar = strings[0][prefixLength];

            // Check if all strings have the same character at this position
            foreach (string s in strings)
            {
                if (prefixLength >= s.Length || s[prefixLength] != currentChar)
                {
                    continueChecking = false;
                    break;
                }
            }

            if (continueChecking)
                prefixLength++;
        }

        return strings[0].Substring(0, prefixLength);
    }

    static void Main()
    {
        var testStrings = new List<string> { "flower", "flow", "flight" };
        Console.WriteLine(FindLongestCommonPrefix(testStrings)); // Output: "fl"

        var testStrings2 = new List<string> { "dog", "racecar", "car" };
        Console.WriteLine(FindLongestCommonPrefix(testStrings2)); // Output: ""

        var testStrings3 = new List<string> { "interstellar", "internet", "interval" };
        Console.WriteLine(FindLongestCommonPrefix(testStrings3)); // Output: "int"
    }
}