using System;

class Program
{
    static void Main()
    {
        // Input radius and height
        double radius = 5.0; // example radius
        double height = 10.0; // example height

        // Calculate volume of the cone
        double volume = (Math.PI * radius * radius * height) / 3.0;
        Console.WriteLine($"The volume of the cone with radius {radius} and height {height} is {volume:F2}");
    }
}