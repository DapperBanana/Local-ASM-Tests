using System;

class Program
{
    static void Main()
    {
        // Input: length of the side
        double sideLength = 1.0; // You can change this value for different side lengths

        // Constants
        double n = 9.0; // Number of sides
        double pi = Math.PI;

        // Calculate the area using the formula:
        // Area = (1/4) * n * s^2 / tan(pi / n)
        double area = (n * Math.Pow(sideLength, 2)) / (4 * Math.Tan(pi / n));

        Console.WriteLine($"Area of a regular nonagon with side length {sideLength} is {area}");
    }
}