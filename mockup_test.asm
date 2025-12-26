using System;

class AnagramChecker
{
    // Checks if two strings are anagrams
    public static bool AreAnagrams(string str1, string str2)
    {
        // Remove whitespace and convert to lowercase
        str1 = str1.Replace(" ", "").ToLower();
        str2 = str2.Replace(" ", "").ToLower();

        // Quick length check
        if (str1.Length != str2.Length)
            return false;

        // Character frequency array for ASCII
        int[] charCounts = new int[256];

        // Count characters in str1
        foreach (char c in str1)
        {
            charCounts[c]++;
        }

        // Subtract counts based on str2
        foreach (char c in str2)
        {
            charCounts[c]--;
        }

        // Check if all counts are zero
        foreach (int count in charCounts)
        {
            if (count != 0)
                return false;
        }

        return true;
    }

    static void Main()
    {
        string firstString = "listen";
        string secondString = "silent";

        bool result = AreAnagrams(firstString, secondString);
        Console.WriteLine($"Are '{firstString}' and '{secondString}' anagrams? {result}");
    }
}