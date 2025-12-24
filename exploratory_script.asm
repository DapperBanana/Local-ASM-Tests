// This C# code simulates a 6502 assembly program that finds common characters between two strings.
// It demonstrates the core logic by interpreting the steps typically performed in assembly.

using System;

class Program
{
    static void Main()
    {
        string strA = "HELLO";
        string strB = "WORLD";

        // Convert strings to uppercase character arrays for simplicity
        char[] aChars = strA.ToCharArray();
        char[] bChars = strB.ToCharArray();

        // Result list to store common characters
        var commonChars = new System.Collections.Generic.List<char>();

        // Simulate nested loops like in 6502 assembly
        for (int i = 0; i < aChars.Length; i++)
        {
            char aChar = aChars[i];
            for (int j = 0; j < bChars.Length; j++)
            {
                char bChar = bChars[j];

                // Compare characters
                if (aChar == bChar)
                {
                    if (!commonChars.Contains(aChar))
                    {
                        commonChars.Add(aChar);
                    }
                }
            }
        }

        // Output the common characters
        Console.WriteLine("Common characters:");
        foreach (var ch in commonChars)
        {
            Console.WriteLine(ch);
        }
    }
}