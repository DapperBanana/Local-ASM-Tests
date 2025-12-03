using System;

class TicTacToe
{
    static char[] board = new char[9];
    static char currentPlayer;

    static void Main()
    {
        InitializeBoard();
        currentPlayer = 'X';

        while (true)
        {
            Console.Clear();
            DrawBoard();
            Console.WriteLine($"Player {currentPlayer}, enter your move (1-9):");
            int move = GetPlayerMove();

            if (IsValidMove(move))
            {
                MakeMove(move);
                if (CheckWin())
                {
                    Console.Clear();
                    DrawBoard();
                    Console.WriteLine($"Player {currentPlayer} wins!");
                    break;
                }
                else if (IsBoardFull())
                {
                    Console.Clear();
                    DrawBoard();
                    Console.WriteLine("It's a draw!");
                    break;
                }
                SwitchPlayer();
            }
            else
            {
                Console.WriteLine("Invalid move. Try again.");
                Console.ReadLine();
            }
        }
    }

    static void InitializeBoard()
    {
        for (int i = 0; i < 9; i++)
        {
            board[i] = (i + 1).ToString()[0];
        }
    }

    static void DrawBoard()
    {
        Console.WriteLine($" {board[0]} | {board[1]} | {board[2]} ");
        Console.WriteLine("---+---+---");
        Console.WriteLine($" {board[3]} | {board[4]} | {board[5]} ");
        Console.WriteLine("---+---+---");
        Console.WriteLine($" {board[6]} | {board[7]} | {board[8]} ");
    }

    static int GetPlayerMove()
    {
        int move;
        string input = Console.ReadLine();
        if (int.TryParse(input, out move))
        {
            return move;
        }
        return -1;
    }

    static bool IsValidMove(int move)
    {
        return move >= 1 && move <= 9 && board[move - 1] != 'X' && board[move - 1] != 'O';
    }

    static void MakeMove(int move)
    {
        board[move - 1] = currentPlayer;
    }

    static void SwitchPlayer()
    {
        currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
    }

    static bool CheckWin()
    {
        int[][] winConditions = new int[][]
        {
            new int[]{0,1,2},
            new int[]{3,4,5},
            new int[]{6,7,8},
            new int[]{0,3,6},
            new int[]{1,4,7},
            new int[]{2,5,8},
            new int[]{0,4,8},
            new int[]{2,4,6}
        };

        foreach (var condition in winConditions)
        {
            if (board[condition[0]] == currentPlayer &&
                board[condition[1]] == currentPlayer &&
                board[condition[2]] == currentPlayer)
            {
                return true;
            }
        }
        return false;
    }

    static bool IsBoardFull()
    {
        foreach (char c in board)
        {
            if (c != 'X' && c != 'O')
            {
                return false;
            }
        }
        return true;
    }
}