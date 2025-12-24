using System;

class IcosahedronAreaCalculator
{
    static void Main()
    {
        // Edge length of the icosahedron
        double edgeLength = 1.0; // You can change this value to any positive number

        // Calculate the surface area
        double area = CalculateIcosahedronSurfaceArea(edgeLength);

        Console.WriteLine($"Surface Area of the icosahedron with edge length {edgeLength} is: {area}");
    }

    static double CalculateIcosahedronSurfaceArea(double edge)
    {
        // The formula for the surface area of a regular icosahedron is:
        // Area = 5 * √3 * (edge)^2
        return 5.0 * Math.Sqrt(3.0) * edge * edge;
    }
}