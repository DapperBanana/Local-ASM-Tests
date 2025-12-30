using System;

class PyramidCalculator
{
    static void Main()
    {
        // Simulate loading values into registers (variables)
        double baseArea = 50.0; // example base area
        double height = 20.0;    // example height

        // Load base area and height into "registers"
        double reg_BaseArea = baseArea;
        double reg_Height = height;

        // Calculate volume: (1/3) * baseArea * height
        double reg_Volume = (1.0 / 3.0) * reg_BaseArea * reg_Height;

        // Output the result
        Console.WriteLine($"The volume of the pyramid is: {reg_Volume}");
    }
}