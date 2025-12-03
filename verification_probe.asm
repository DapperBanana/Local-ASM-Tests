using System;

class SudokuValidator6502
{
    // Example Sudoku solution to validate
    static int[] sudoku = new int[81]
    {
        5,3,4,6,7,8,9,1,2,
        6,7,2,1,9,5,3,4,8,
        1,9,8,3,4,2,5,6,7,
        8,5,9,7,6,1,4,2,3,
        4,2,6,8,5,3,7,9,1,
        7,1,3,9,2,4,8,5,6,
        9,6,1,5,3,7,2,8,4,
        2,8,7,4,1,9,6,3,5,
        3,4,5,2,8,6,1,7,9
    };

    static void Main()
    {
        if (ValidateSudoku(sudoku))
        {
            Console.WriteLine("Sudoku solution is valid!");
        }
        else
        {
            Console.WriteLine("Sudoku solution is invalid.");
        }
    }

    static bool ValidateSudoku(int[] grid)
    {
        // Validate rows
        for (int row = 0; row < 9; row++)
        {
            bool[] seen = new bool[10];
            for (int col = 0; col < 9; col++)
            {
                int value = grid[row * 9 + col];
                if (!IsValidNumber(value) || seen[value])
                {
                    return false;
                }
                seen[value] = true;
            }
        }

        // Validate columns
        for (int col = 0; col < 9; col++)
        {
            bool[] seen = new bool[10];
            for (int row = 0; row < 9; row++)
            {
                int value = grid[row * 9 + col];
                if (!IsValidNumber(value) || seen[value])
                {
                    return false;
                }
                seen[value] = true;
            }
        }

        // Validate 3x3 subgrids
        for (int boxRow = 0; boxRow < 3; boxRow++)
        {
            for (int boxCol = 0; boxCol < 3; boxCol++)
            {
                bool[] seen = new bool[10];
                for (int row = 0; row < 3; row++)
                {
                    for (int col = 0; col < 3; col++)
                    {
                        int r = boxRow * 3 + row;
                        int c = boxCol * 3 + col;
                        int value = grid[r * 9 + c];
                        if (!IsValidNumber(value) || seen[value])
                        {
                            return false;
                        }
                        seen[value] = true;
                    }
                }
            }
        }

        // All checks passed
        return true;
    }

    static bool IsValidNumber(int n)
    {
        return n >= 1 && n <= 9;
    }
}