using System;
using System.Collections.Generic;
using System.Text;

class Program
{
    static void Main()
    {
        // Example data: categories with their values
        var data = new Dictionary<string, int>
        {
            {"A", 5},
            {"B", 3},
            {"C", 8},
            {"D", 2}
        };

        // Generate 6502 assembly code
        StringBuilder asm = new StringBuilder();

        // Define some constants and label references (assuming a simple video memory setup)
        asm.AppendLine("; 6502 Assembly code to draw a bar chart");
        asm.AppendLine("; Assuming starting at memory location $0200");
        asm.AppendLine("        .org $0200");
        asm.AppendLine();

        // Storage for data: each entry name and value
        asm.AppendLine("; Data table");
        int index = 0;
        foreach (var kvp in data)
        {
            // Store the string name (as ASCII) and value
            asm.AppendLine($"; {kvp.Key}");
            // Store value in memory (for simplicity, store inline)
            // For the demo, store data as bytes in a data table
            asm.AppendLine($".byte \"{kvp.Key}\", 0, {kvp.Value}");
        }
        asm.AppendLine();

        // Set up pointers
        asm.AppendLine("; Load address of data table");
        asm.AppendLine("LDL data_table");
        asm.AppendLine();

        // Initialize pointer to data table start
        asm.AppendLine("LDX #0"); // index for categories

        // Loop over data
        asm.AppendLine("loop_start:");
        // Load category string label address (simulate)
        // For simplicity, we'll just iterate over the data values
        // Here, real 6502 code would handle strings differently,
        // but for illustration, we'll just process values

        // Load value from data at current index
        // For demonstration, assigning values directly
        // In real code, you'd load from a data table or memory

        // For this demo, we'll assume data in a fixed array
        // Since we can't dynamically generate code here,
        // we'll generate code for each data point

        // Instead, generate code explicitly for each data point
        // For each data point, draw a bar proportionally

        // Final output: show code that "draws" bars by setting pixels
        // For this example, just simulate setting a number of pixels per value

        // Let's generate code for each data point:
        asm.Clear();

        int barStartX = 10; // starting x position for the bar
        int barStartY = 10; // starting y position

        int barWidthPerUnit = 2;  // width per unit value

        int currentY = barStartY;
        foreach (var kvp in data)
        {
            int barHeight = kvp.Value * 2; // scale height for visibility
            // For each bar, generate code to draw editor
            asm.AppendLine($"; Drawing bar for {kvp.Key} with height {barHeight}");
            asm.AppendLine($"LDY #$00");
            asm.AppendLine($"LDX #${barStartX}");
            asm.AppendLine($"# drawBar_{kvp.Key}");
            asm.AppendLine($"drawBar_{kvp.Key}_loop:");
            asm.AppendLine($"     STY $00"); // Store current Y
            asm.AppendLine($"     ; draw pixel at (X, Y)");
            asm.AppendLine($"     LDA #$FF  ; pixel color");
            asm.AppendLine($"     STA $2000,X,Y"); // hypothetical video addr
            asm.AppendLine($"     INY");
            asm.AppendLine($"     CPY #${barHeight}");
            asm.AppendLine($"     BNE drawBar_{kvp.Key}_loop");
            asm.AppendLine();

            barStartX += barWidthPerUnit;
        }

        // Note: The above code is simplified and illustrative, as real 6502 graphics drawing requires proper memory addresses and routines.

        Console.WriteLine(asm.ToString());
    }
}