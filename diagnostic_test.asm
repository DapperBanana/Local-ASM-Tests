// This is a conceptual translation: the actual 6502 Assembly programming is not directly translatable to C#.
// However, below is a C# simulation of reversing a string as if it were done in 6502 Assembly.
using System;

class Program
{
    static void Main()
    {
        // Example string to reverse
        string input = "Hello, World!";
        char[] strArray = input.ToCharArray();

        // Simulate 6502 Assembly string reversal
        int start = 0;
        int end = strArray.Length - 1;

        while (start < end)
        {
            // Swap characters
            char temp = strArray[start];
            strArray[start] = strArray[end];
            strArray[end] = temp;

            start++;
            end--;
        }

        string reversed = new string(strArray);
        Console.WriteLine(reversed); // Output: !dlroW ,olleH
    }
}