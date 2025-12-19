// C# code mimicking 6502 assembly logic to calculate the area of a regular decagon
using System;

class DecagonAreaCalculator
{
    // Constants (scaled for fixed-point calculations)
    // Using fixed-point with 8 fractional bits for better precision
    // 1.0 in fixed-point = 256 (1 << 8)
    const int FixedOne = 256;
    const int Pi = (int)(3.14159265 * FixedOne); // Pi scaled
    const int n = 10; // number of sides

    // Function to convert degrees to radians in fixed point
    static int DegreesToRadians(int degrees)
    {
        // radians = degrees * Pi / 180
        return (degrees * Pi) / (180);
    }

    // Fixed-point multiplication
    static int FixedMul(int a, int b)
    {
        // since both are scaled by 256, multiply and then shift right 8 bits
        return (a * b) >> 8;
    }

    // Main calculation
    static void Main()
    {
        // Input: side length (e.g., 10 units), scaled
        int sideLength = 10 * FixedOne; // 10.0 in fixed point

        // Calculate the apothem a = s / (2 * tan(π/n))
        int angle = 180 / n; // degrees
        int angleRad = DegreesToRadians(angle); // in fixed point

        // Calculate tan(angleRad) using a lookup or approximation
        // For simplicity, use Math.Tan and convert to fixed point
        double tanValue = Math.Tan(angleRad / (double)FixedOne);
        int tanFixed = (int)(tanValue * FixedOne);

        // Compute denominator = 2 * tan(angleRad)
        int denom = FixedMul(2 * FixedOne, tanFixed); // scaled

        // apothem a = s / denom
        int apothem = (sideLength * FixedOne) / denom;

        // Calculate area = (1/2) * n * s * a
        // Since s and a are scaled, need to account for scaling
        int term1 = n * sideLength; // n * s
        int term2 = (term1 * apothem) >> 8; // scale back, as apothem is fixed-point

        int areaFixed = (term2 * FixedOne) / 2; // multiply by 1/2

        // Convert fixed area back to float for output
        double area = areaFixed / (double)FixedOne;

        Console.WriteLine("Decagon with side length 10 units:");
        Console.WriteLine($"Approximate area: {area} square units");
    }
}