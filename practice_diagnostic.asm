using System;

class FrustumAreaCalculator
{
    // Constants for calculations
    const double PI = 3.141592653589793;

    static void Main()
    {
        // Example input: bottom radius, top radius
        double r1 = 5.0; // bottom radius
        double r2 = 3.0; // top radius

        // Step 1: Calculate r1^2 and r2^2
        double r1Squared = r1 * r1;
        double r2Squared = r2 * r2;

        // Step 2: Calculate r1 * r2
        double r1r2 = r1 * r2;

        // Step 3: Sum the squared radii and the product
        double sum = r1Squared + r2Squared + r1r2;

        // Step 4: Calculate area
        double area = PI * sum;

        Console.WriteLine($"Frustum Surface Area: {area}");
    }
}