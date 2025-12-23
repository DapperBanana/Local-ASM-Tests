using System;

class HeptagonAreaCalculator
{
    static void Main()
    {
        // Input: side length of the heptagon
        Console.WriteLine("Enter the side length of the heptagon:");
        double a;
        if(!double.TryParse(Console.ReadLine(), out a) || a <= 0)
        {
            Console.WriteLine("Please enter a valid positive number for the side length.");
            return;
        }
        
        // Calculate the area
        double area = CalculateHeptagonArea(a);
        
        // Output the result
        Console.WriteLine($"The area of the heptagon with side length {a} is: {area}");
    }
    
    static double CalculateHeptagonArea(double side)
    {
        // Use the formula: (7/4) * a^2 * cot(pi/7)
        double piOver7 = Math.PI / 7;
        double cotPiOver7 = 1.0 / Math.Tan(piOver7);
        double area = (7.0 / 4.0) * side * side * cotPiOver7;
        return area;
    }
}