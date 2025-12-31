using System;

class CubeSurfaceAreaCalculator
{
    static void Main()
    {
        // Assume side length of the cube
        int sideLength = 5; // You can change this value

        // Calculate surface area = 6 * sideLength^2
        int surfaceArea = CalculateSurfaceArea(sideLength);

        Console.WriteLine($"Surface Area of the cube with side length {sideLength} is {surfaceArea}");
    }

    static int CalculateSurfaceArea(int side)
    {
        // Calculate side^2
        int squared = Multiply(side, side);

        // Multiply by 6 to get surface area
        int surfaceArea = Multiply(squared, 6);

        return surfaceArea;
    }

    static int Multiply(int a, int b)
    {
        int result = 0;
        for (int i = 0; i < b; i++)
        {
            result += a;
        }
        return result;
    }
}