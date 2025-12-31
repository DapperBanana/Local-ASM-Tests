using System;

class NonagonAreaCalculator
{
    static void Main()
    {
        // Number of sides of the regular polygon
        int n = 9;
        // Length of one side
        double s = 1.0; // Change this value as needed

        // Calculate cotangent of pi / n
        double angle = Math.PI / n;
        double cotangent = 1.0 / Math.Tan(angle);

        // Calculate area
        double area = (n * s * s * cotangent) / 4.0;

        Console.WriteLine($"The area of the regular nonagon with side length {s} is: {area}");
    }
}