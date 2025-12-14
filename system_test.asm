// Note: This C# code simulates 6502 assembly logic to determine if a number is even or odd.
class Program
{
    static void Main()
    {
        byte number = 0x37; // Example number, change as needed

        // Simulate 6502 assembly logic:
        // In 6502, to determine even/odd:
        // - Check least significant bit (bit 0)
        // - If 0 -> even, if 1 -> odd

        bool isEven;
        // Extract least significant bit (LSB)
        byte lsb = (byte)(number & 0x01);
        
        if (lsb == 0)
        {
            isEven = true;
        }
        else
        {
            isEven = false;
        }
        
        // Output result
        Console.WriteLine($"Number {number} is " + (isEven ? "even." : "odd."));
    }
}