using System;

class RomanToInteger6502
{
    // Simulate 6502 RAM with a byte array
    static byte[] memory = new byte[256];

    // Pointers to the string and current position
    static int ptr; // Points into the string

    // Input Roman numeral string
    static string roman;

    static void Main()
    {
        // Example input
        roman = "MCMXCIV"; // 1994
        // Initialize pointer
        ptr = 0;

        // Convert string to byte array for simulation
        byte[] romanBytes = System.Text.Encoding.ASCII.GetBytes(roman);

        // Initialize 'memory' with the string
        for(int i=0; i<romanBytes.Length; i++)
        {
            memory[i] = romanBytes[i];
        }

        int result = ConvertRomanToInt();
        Console.WriteLine($"Roman numeral {roman} converts to {result}");
    }

    static int ConvertRomanToInt()
    {
        int total = 0;
        int prevValue = 0;

        while(HasMoreChars())
        {
            byte currentChar = ReadChar();

            int currentValue = RomanCharValue(currentChar);

            // If current value is greater than previous, subtract twice the previous
            if(currentValue > prevValue && prevValue != 0)
            {
                total -= 2 * prevValue;
            }

            total += currentValue;
            prevValue = currentValue;
        }

        return total;
    }

    // Checks if there are more characters to process
    static bool HasMoreChars()
    {
        return ptr < memory.Length && memory[ptr] != 0;
    }

    // Reads next character from 'memory' and advances pointer
    static byte ReadChar()
    {
        return memory[ptr++];
    }

    // Maps Roman numeral character to its integer value
    static int RomanCharValue(byte c)
    {
        switch(c)
        {
            case (byte)'I': return 1;
            case (byte)'V': return 5;
            case (byte)'X': return 10;
            case (byte)'L': return 50;
            case (byte)'C': return 100;
            case (byte)'D': return 500;
            case (byte)'M': return 1000;
            default: return 0;
        }
    }
}