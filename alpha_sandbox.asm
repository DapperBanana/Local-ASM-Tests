using System;

class LinearRegression
{
    static void Main()
    {
        // Sample data points (X, Y)
        double[] xData = {1, 2, 3, 4, 5};
        double[] yData = {2, 4, 5, 4, 5};
        int n = xData.Length;

        double sumX = 0;
        double sumY = 0;
        double sumXY = 0;
        double sumX2 = 0;

        // Calculate summations
        for (int i = 0; i < n; i++)
        {
            sumX += xData[i];
            sumY += yData[i];
            sumXY += xData[i] * yData[i];
            sumX2 += xData[i] * xData[i];
        }

        // Calculate slope (m) and intercept (b)
        double denominator = n * sumX2 - sumX * sumX;
        if (denominator != 0)
        {
            double m = (n * sumXY - sumX * sumY) / denominator;
            double b = (sumY - m * sumX) / n;

            Console.WriteLine($"Linear Regression Model: y = {m:F2} * x + {b:F2}");
        }
        else
        {
            Console.WriteLine("Cannot compute regression (denominator is zero).");
        }
    }
}