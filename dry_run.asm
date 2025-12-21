using System;

class Program
{
    // Define the size of the matrix
    static int size = 3;

    static void Main()
    {
        // Example matrix (replace with your matrix)
        double[,] matrix = {
            { 1, 0, 0 },
            { 0, 0, -1 },
            { 0, 1, 0 }
        };

        bool isOrthogonal = IsOrthogonal(matrix);
        Console.WriteLine($"Is the matrix orthogonal? {isOrthogonal}");
    }

    static bool IsOrthogonal(double[,] matrix)
    {
        // Compute transpose
        double[,] transpose = Transpose(matrix);

        // Multiply matrix * transpose
        double[,] product = Multiply(matrix, transpose);

        // Check if product is identity matrix
        return IsIdentity(product);
    }

    static double[,] Transpose(double[,] matrix)
    {
        int n = matrix.GetLength(0);
        int m = matrix.GetLength(1);
        double[,] transposed = new double[m, n];

        for (int i = 0; i < n; i++)
            for (int j = 0; j < m; j++)
                transposed[j, i] = matrix[i, j];

        return transposed;
    }

    static double[,] Multiply(double[,] a, double[,] b)
    {
        int n = a.GetLength(0);
        int m = a.GetLength(1);
        int p = b.GetLength(1);
        double[,] result = new double[n, p];

        for (int i = 0; i < n; i++)
            for (int j = 0; j < p; j++)
            {
                double sum = 0;
                for (int k = 0; k < m; k++)
                {
                    sum += a[i, k] * b[k, j];
                }
                result[i, j] = sum;
            }

        return result;
    }

    static bool IsIdentity(double[,] matrix)
    {
        int n = matrix.GetLength(0);
        int m = matrix.GetLength(1);

        if (n != m)
            return false;

        const double epsilon = 1e-6; // Tolerance for floating point

        for (int i = 0; i < n; i++)
            for (int j = 0; j < m; j++)
            {
                if (i == j)
                {
                    if (Math.Abs(matrix[i, j] - 1) > epsilon)
                        return false;
                }
                else
                {
                    if (Math.Abs(matrix[i, j]) > epsilon)
                        return false;
                }
            }

        return true;
    }
}