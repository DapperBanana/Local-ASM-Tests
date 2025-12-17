using System;

class Program
{
    static void Main()
    {
        // Edge length of the tetrahedron
        double a = 5.0; // Example edge length

        // Simulate 6502 Assembly logic to compute surface area
        // Step 1: Load 'a' (simulate immediate load)
        double edgeLength = a;

        // Step 2: Calculate a^2
        double aSquared = edgeLength * edgeLength;

        // Step 3: Multiply by sqrt(3)
        // Since 6502 assembly doesn't have floating point, assume fixed-point or approximate
        // Here, for simplicity, use Math.Sqrt(3)
        double area = Math.Sqrt(3) * aSquared;

        // Output the result
        Console.WriteLine($"Surface area of the tetrahedron with edge length {a} is {area}");
    }
}