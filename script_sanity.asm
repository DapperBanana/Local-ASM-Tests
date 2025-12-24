// C# code that generates 6502 assembly to convert a decimal number to binary
using System;
using System.Text;

class Program
{
    static void Main()
    {
        StringBuilder asm = new StringBuilder();

        asm.AppendLine("; Convert decimal number in A to binary");
        asm.AppendLine("; Result stored in memory starting at $0200");
        asm.AppendLine("        LDX #0          ; Clear index register X");
        asm.AppendLine("        STZ $0200       ; Clear memory location for binary result");
        asm.AppendLine("        LDY #8          ; Loop counter for 8 bits");
        asm.AppendLine("ConvertLoop:");
        asm.AppendLine("        ASL             ; Shift left A (high bit moves to carry)");
        asm.AppendLine("        ROL $0200       ; Rotate left memory, store bit in memory");
        asm.AppendLine("        DEX             ; Decrement counter");
        asm.AppendLine("        BNZ ConvertLoop ; Loop until all bits processed");

        string assemblyCode = asm.ToString();

        Console.WriteLine(assemblyCode);
    }
}