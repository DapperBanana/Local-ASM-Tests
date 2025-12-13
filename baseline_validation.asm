// Note: This is a sample implementation of a 6502 assembly program that checks for a palindrome.
// Since the request is to return only C# code, we will simulate the logic in C# to illustrate the process.
// The assembly logic can be translated from this approach, but here is a high-level C# implementation:

using System;

class Program
{
    static void Main()
    {
        string input = "racecar"; // change this to test other strings
        bool isPalindrome = IsPalindrome(input);
        Console.WriteLine($"Is '{input}' a palindrome? {isPalindrome}");
    }

    static bool IsPalindrome(string str)
    {
        int start = 0;
        int end = str.Length - 1;
        while (start < end)
        {
            if (str[start] != str[end])
                return false;
            start++;
            end--;
        }
        return true;
    }
}