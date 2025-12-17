// Note: This C# code simulates a 6502 assembly program to reverse the words in a sentence.
// It demonstrates the logic of reversing word order using assembly-like steps in C#.

using System;
using System.Text;

public class AssemblyWordReversal
{
    public static void Main()
    {
        // Input sentence (null-terminated string simulation)
        string input = "This is a sample sentence";
        // Convert to byte array for simulation (ASCII encoding)
        byte[] inputBytes = Encoding.ASCII.GetBytes(input + '\0');

        // We'll process the sentence as a byte array to simulate memory.
        // Buffer to hold the reversed sentence
        byte[] buffer = new byte[inputBytes.Length];

        // Step 1: Find the length of the sentence (excluding null terminator)
        int length = 0;
        while (length < inputBytes.Length && inputBytes[length] != 0)
        {
            length++;
        }

        // 1. Reverse the entire string
        for (int i = 0; i < length; i++)
        {
            buffer[i] = inputBytes[length - 1 - i];
        }
        buffer[length] = 0;

        // Now, buffer contains the reversed string
        // Step 2: Reverse individual words to restore their proper form
        int start = 0;
        for (int i = 0; i <= length; i++)
        {
            if (i == length || buffer[i] == ' ')
            {
                // Reverse the word from 'start' to 'i - 1'
                int end = i - 1;
                while (start < end)
                {
                    // Swap characters
                    byte temp = buffer[start];
                    buffer[start] = buffer[end];
                    buffer[end] = temp;
                    start++;
                    end--;
                }
                start = i + 1;
            }
        }

        // Convert the buffer back to a string
        string output = Encoding.ASCII.GetString(buffer, 0, length);
        Console.WriteLine(output);
        // Expected output: "sentence a is This"
    }
}