using System;

class FrustumAreaCalculator
{
    static void Main()
    {
        // Example input values
        double r1 = 5.0; // radius of top circle
        double r2 = 10.0; // radius of bottom circle
        double h = 7.0;   // height of the frustum

        // Calculate the slant height (l)
        double l = Math.Sqrt(Math.Pow(r2 - r1, 2) + Math.Pow(h, 2));

        // Calculate the lateral surface area
        double lateralArea = Math.PI * (r1 + r2) * l;

        // Calculate the total surface area
        double totalArea = lateralArea + Math.PI * Math.Pow(r1, 2) + Math.PI * Math.Pow(r2, 2);

        Console.WriteLine("Frustum of a cone surface area: " + totalArea);
    }
}