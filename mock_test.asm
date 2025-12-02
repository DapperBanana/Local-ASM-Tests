using System;

class MagicTorusChecker
{
    public static bool IsMagicTorus(int[,] matrix)
    {
        int n = matrix.GetLength(0);
        if (n != matrix.GetLength(1))
            return false; // Not a square matrix
        
        int targetSum = 0;
        for (int j = 0; j < n; j++)
        {
            targetSum += matrix[0, j]; // Sum of first row as target
        }

        // Check rows
        for (int i = 0; i < n; i++)
        {
            int rowSum = 0;
            for (int j = 0; j < n; j++)
            {
                rowSum += matrix[i, j];
            }
            if (rowSum != targetSum)
                return false;
        }

        // Check columns with toroidal wrap-around
        for (int j = 0; j < n; j++)
        {
            int colSum = 0;
            for (int i = 0; i < n; i++)
            {
                int rowIdx = (i + j) % n; // Wrap index for toroidality
                colSum += matrix[rowIdx, j];
            }
            if (colSum != targetSum)
                return false;
        }

        // Check main diagonal (top-left to bottom-right) with wrap-around
        int diag1Sum = 0;
        for (int i = 0; i < n; i++)
        {
            int rowIdx = (i + i) % n; // Wrap diagonally
            diag1Sum += matrix[rowIdx, i];
        }
        if (diag1Sum != targetSum)
            return false;

        // Check anti-diagonal (top-right to bottom-left) with wrap-around
        int diag2Sum = 0;
        for (int i = 0; i < n; i++)
        {
            int rowIdx = (i + (n - i - 1)) % n;
            diag2Sum += matrix[rowIdx, i];
        }
        if (diag2Sum != targetSum)
            return false;

        return true;
    }

    static void Main()
    {
        int[,] sampleMatrix = {
            { 1, 2, 3 },
            { 3, 1, 2 },
            { 2, 3, 1 }
        };

        Console.WriteLine("Is magic torus: " + IsMagicTorus(sampleMatrix));
    }
}