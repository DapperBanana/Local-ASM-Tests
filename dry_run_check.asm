using System;

class Program
{
    static void Main()
    {
        // Example string to reverse
        string original = "HELLO WORLD";

        // Convert string to char array for easy manipulation
        char[] buffer = original.ToCharArray();

        // Initialize pointers
        int start = 0;
        int end = buffer.Length - 1;

        // Reverse the string in place
        while (start < end)
        {
            // Swap characters
            char temp = buffer[start];
            buffer[start] = buffer[end];
            buffer[end] = temp;

            // Move pointers towards the center
            start++;
            end--;
        }

        // Convert back to string
        string reversed = new string(buffer);
        Console.WriteLine(reversed);
    }
}