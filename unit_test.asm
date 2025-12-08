// Note: The following C# code demonstrates how one might simulate a 6502 assembly program
// that calculates the volume of a cylinder given its radius and height. 
// The actual assembly code isn't provided here, but this C# serves as a conceptual 
// implementation of what such an assembly program would perform.

using System;

class CylinderVolumeCalculator
{
    public static void Main()
    {
        // Example inputs: radius and height
        ushort radius = 10; // example radius
        ushort height = 20; // example height

        // Simulate the 6502 assembly calculation
        // volume = π * r^2 * h
        // Using a fixed-point approximation for π (e.g., 3.14), scaled appropriately
        // Here, we perform calculation with integers to mimic assembly behavior

        // Fixed-point scale factor (e.g., 100 to keep two decimal places)
        int pi = 314; // 3.14 * 100

        // Calculate r^2
        int r_sq = radius * radius;

        // Calculate π * r^2
        int pi_r_sq = pi * r_sq; // scaled by 100

        // Multiply by height
        int volume_scaled = pi_r_sq * height; // scaled by 100

        // Since we scaled π by 100, and r^2, and height are integers,
        // the result is scaled by 100
        // To get the actual volume, divide by 100 * 1 (since h is integer)
        // The scale factor to get actual volume:
        // (pi * r^2 * h) / 100

        double volume = volume_scaled / 100.0;

        Console.WriteLine($"Radius: {radius}");
        Console.WriteLine($"Height: {height}");
        Console.WriteLine($"Volume of cylinder: {volume:F2}");
    }
}