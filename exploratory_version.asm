using System;

class HeptagonAreaCalculator
{
    // Function to calculate the area of a regular heptagon
    public static double CalculateHeptagonArea(double side)
    {
        // Constants for the formula: (7/4) * s^2 * cot(pi/7)
        double numerator = 7.0;
        double denominator = 4.0;
        double angle = Math.PI / 7;        // pi/7
        double cotangent = 1.0 / Math.Tan(angle);

        double area = (numerator / denominator) * side * side * cotangent;
        return area;
    }

    static void Main()
    {
        Console.Write("Enter the length of the side of the heptagon: ");
        string input = Console.ReadLine();

        if (double.TryParse(input, out double sideLength) && sideLength > 0)
        {
            double area = CalculateHeptagonArea(sideLength);
            Console.WriteLine($"The area of the heptagon with side {sideLength} is: {area}");
        }
        else
        {
            Console.WriteLine("Invalid input. Please enter a positive numeric value.");
        }
    }
}