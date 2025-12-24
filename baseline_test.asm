using System;

class PyramidCalculations
{
    static void Main()
    {
        // Input: base area and height
        Console.Write("Enter the base area of the pyramid: ");
        double baseArea = double.Parse(Console.ReadLine());

        Console.Write("Enter the height of the pyramid: ");
        double height = double.Parse(Console.ReadLine());

        // Calculate volume of the pyramid
        double volume = (1.0 / 3.0) * baseArea * height;

        // Output the result
        Console.WriteLine($"The volume of the pyramid is: {volume}");
    }
}