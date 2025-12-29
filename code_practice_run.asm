using System;

class Program
{
    static void Main()
    {
        // Input dimensions
        double a = 3.0; // first base of trapezoid
        double b = 5.0; // second base of trapezoid
        double h = 4.0; // height of trapezoid
        double l = 10.0; // length of the prism (depth)
        double w = 6.0; // width of the prism

        // Calculate the area of the trapezoid base
        double baseArea = ((a + b) / 2) * h;

        // Calculate the slant height for the sides of the trapezoid
        double sideLength = Math.Sqrt(Math.Pow((b - a) / 2, 2) + Math.Pow(h, 2));

        // Calculate lateral surface areas
        double side1Area = sideLength * l; // lateral face on one side
        double side2Area = sideLength * w; // lateral face on the other side
        double topArea = b * l; // top face
        double bottomArea = a * w; // bottom face

        // Total surface area
        double totalArea = 2 * baseArea + side1Area + side2Area + topArea + bottomArea;

        Console.WriteLine($"Surface area of the trapezoidal prism: {totalArea}");
    }
}