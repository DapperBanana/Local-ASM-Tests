using System;

class DecagonAreaCalculator
{
    static void Main()
    {
        // Prompt user for the length of a side
        Console.Write("Enter the length of a side of the decagon: ");
        double sideLength;
        if (!double.TryParse(Console.ReadLine(), out sideLength) || sideLength <= 0)
        {
            Console.WriteLine("Invalid input. Please enter a positive number.");
            return;
        }

        // Calculate area
        double area = CalculateDecagonArea(sideLength);

        // Output the result
        Console.WriteLine($"The area of the regular decagon with side length {sideLength} is {area:F4}");
    }

    static double CalculateDecagonArea(double a)
    {
        // Constants
        const double pi = Math.PI;

        // cot(pi/10) = 1 / tan(pi/10)
        double cotPiOver10 = 1.0 / Math.Tan(pi / 10);

        // Area formula: (5/2) * a^2 * cot(pi/10)
        return (5.0 / 2.0) * a * a * cotPiOver10;
    }
}