using System;

class ConeVolumeCalculator
{
    static void Main()
    {
        // Inputs: radius and height
        Console.Write("Enter radius: ");
        double radius = Double.Parse(Console.ReadLine());

        Console.Write("Enter height: ");
        double height = Double.Parse(Console.ReadLine());

        // Conversion of 6502 assembly logic to C#
        // Volume formula: (1/3) * π * r^2 * h

        double pi = 3.141592653589793;
        double radiusSquared = radius * radius;
        double volume = (1.0 / 3.0) * pi * radiusSquared * height;

        Console.WriteLine($"Volume of the cone: {volume}");
    }
}