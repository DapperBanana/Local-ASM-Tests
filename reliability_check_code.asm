using System;

class DecagonAreaCalculator
{
    static void Main()
    {
        // Length of each side
        double sideLength = 1.0; // you can change this value

        int n = 10; // number of sides for a decagon

        // Calculate the area
        double area = (n * Math.Pow(sideLength, 2)) / (4 * Math.Tan(Math.PI / n));

        Console.WriteLine($"The area of a regular decagon with side length {sideLength} is {area}");
    }
}