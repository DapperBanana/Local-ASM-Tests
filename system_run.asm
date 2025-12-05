/* Note: The following is a C# representation that simulates 6502 assembly logic.
   It does not execute 6502 assembly but illustrates how such logic would be implemented in C#.
   If actual 6502 assembly code is needed, please specify. */

byte IsEvenOrOdd(byte number)
{
    // In 6502 assembly, to determine if a number is even or odd,
    // you perform a AND with 1. If the result is 0, the number is even; if 1, odd.
    byte result = (byte)(number & 0x01);
    if (result == 0)
        return 0; // Even
    else
        return 1; // Odd
}