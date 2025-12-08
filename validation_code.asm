// This C# code simulates a 6502 assembly program to calculate the correlation coefficient
// between two lists of numbers. It provides a clear and educational mapping from assembly
// logic to C# with detailed comments.

using System;

class Program
{
    static void Main()
    {
        // Example lists of numbers
        double[] listX = { 1.0, 2.0, 3.0, 4.0, 5.0 };
        double[] listY = { 2.0, 4.0, 6.0, 8.0, 10.0 };

        double correlation = CalculateCorrelationCoefficient(listX, listY);
        Console.WriteLine($"Correlation Coefficient: {correlation}");
    }

    static double CalculateCorrelationCoefficient(double[] x, double[] y)
    {
        if (x.Length != y.Length || x.Length == 0)
            throw new ArgumentException("Lists must be of the same non-zero length.");

        int n = x.Length;

        // Initialize sums
        double sumX = 0.0;
        double sumY = 0.0;
        double sumX2 = 0.0;
        double sumY2 = 0.0;
        double sumXY = 0.0;

        // Loop to process each pair
        for (int i = 0; i < n; i++)
        {
            double xi = x[i];
            double yi = y[i];

            sumX += xi;
            sumY += yi;

            sumX2 += xi * xi;
            sumY2 += yi * yi;

            sumXY += xi * yi;
        }

        // Compute numerator and denominator
        double numerator = (n * sumXY) - (sumX * sumY);
        double denominatorPartX = (n * sumX2) - (sumX * sumX);
        double denominatorPartY = (n * sumY2) - (sumY * sumY);

        double denominator = Math.Sqrt(denominatorPartX * denominatorPartY);

        if (denominator == 0)
            return 0; // Or handle as needed

        return numerator / denominator;
    }
}