using System;
using System.Collections.Generic;

class Program
{
    static void Main()
    {
        // Example data: dictionary of label and value
        var data = new Dictionary<string, int>
        {
            { "A", 5 },
            { "B", 8 },
            { "C", 3 },
            { "D", 6 }
        };

        Console.WriteLine("; 6502 Assembly to generate a simple bar chart");
        Console.WriteLine("; Assume character display to screen via memory mapped or console output routine");
        Console.WriteLine();
        Console.WriteLine(".org $6000"); // starting address

        // Loop through data and generate assembly code for each bar
        int baseAddress = 0x6000;
        int labelAddress = 0x6100; // some label address for referencing labels
        int currentAddress = baseAddress;

        foreach (var kvp in data)
        {
            string label = kvp.Key;
            int value = kvp.Value;

            // Store label string
            Console.WriteLine($"; Label {label}");
            Console.WriteLine($".ac " + $"\"{label}\"");
            Console.WriteLine($".label_{label}:");
            // Assume routines to print label here, skipping actual implementation

            // Generate code to output 'value' number of '#' characters
            Console.WriteLine($"; Drawing bar for {label} with length {value}");
            // Load value into A
            Console.WriteLine($"LDA #{value}");
            Console.WriteLine("STA $00F0 ; store count temporarily");
            // Initialize counter
            Console.WriteLine("LDY #0");
            Console.WriteLine("loop_" + label + ":");
            // Compare Y with value to control loop
            Console.WriteLine("LDX $00F0");
            Console.WriteLine("CPY #0");
            Console.WriteLine("BEQ end_" + label);
            // Output '#' character
            Console.WriteLine("JSR PrintHash");
            // Decrement counter
            Console.WriteLine("DEY");
            Console.WriteLine("BNE loop_" + label);
            Console.WriteLine("end_" + label + ":");
            Console.WriteLine();
        }

        // Routine to print '#' character
        Console.WriteLine("; Routine to print '#' character");
        Console.WriteLine("PrintHash:");
        // Pseudo code: send '#' to output port or display routine
        Console.WriteLine("LDA #35"); // ASCII '#' character
        Console.WriteLine("JSR OutputChar");
        Console.WriteLine("RTS");
        Console.WriteLine();

        // Placeholder for OutputChar routine
        Console.WriteLine("; Routine to output character in A");
        Console.WriteLine("OutputChar:");
        // Implementation depends on system; here, just return
        Console.WriteLine("RTS");
    }
}