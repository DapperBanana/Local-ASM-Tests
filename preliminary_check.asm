using System;
using System.Collections.Generic;

public class MazeSolver6502
{
    const int Width = 20;
    const int Height = 10;
    const char Wall = '#';
    const char Path = ' ';
    const char SolutionPath = '.';

    class Cell
    {
        public bool Visited;
        public bool[] Walls = { true, true, true, true }; // top, right, bottom, left
        public bool OnSolutionPath;
    }

    static Cell[,] maze = new Cell[Width, Height];
    static Random rand = new Random();

    static void Main()
    {
        InitializeMaze();
        GenerateMaze(0, 0);
        SolveMaze(0, 0);
        PrintMaze();
    }

    static void InitializeMaze()
    {
        for (int y = 0; y < Height; y++)
            for (int x = 0; x < Width; x++)
                maze[x, y] = new Cell();
    }

    static void GenerateMaze(int startX, int startY)
    {
        // Stack for DFS
        var stack = new Stack<(int x, int y)>();
        stack.Push((startX, startY));
        maze[startX, startY].Visited = true;

        while (stack.Count > 0)
        {
            var (x, y) = stack.Peek();
            // Find unvisited neighbors
            var neighbors = new List<(int nx, int ny, int direction)>();
            // direction: 0=top,1=right,2=bottom,3=left

            if (y > 0 && !maze[x, y - 1].Visited) neighbors.Add((x, y - 1, 0));
            if (x < Width - 1 && !maze[x + 1, y].Visited) neighbors.Add((x + 1, y, 1));
            if (y < Height - 1 && !maze[x, y + 1].Visited) neighbors.Add((x, y + 1, 2));
            if (x > 0 && !maze[x - 1, y].Visited) neighbors.Add((x - 1, y, 3));

            if (neighbors.Count > 0)
            {
                // Pick a random neighbor
                var (nx, ny, dir) = neighbors[rand.Next(neighbors.Count)];
                // Remove walls between current and neighbor
                maze[x, y].Walls[dir] = false;
                maze[nx, ny].Walls[(dir + 2) % 4] = false; // Opposite wall
                maze[nx, ny].Visited = true;
                stack.Push((nx, ny));
            }
            else
            {
                stack.Pop();
            }
        }
        // Reset visited for solving
        for (int y = 0; y < Height; y++)
            for (int x = 0; x < Width; x++)
                maze[x, y].Visited = false;
    }

    static bool SolveMaze(int x, int y)
    {
        // Basic DFS for path finding
        if (x < 0 || y < 0 || x >= Width || y >= Height) return false;
        var cell = maze[x, y];

        if (cell.Visited) return false;
        cell.Visited = true;
        if (x == Width - 1 && y == Height - 1)
        {
            cell.OnSolutionPath = true;
            return true;
        }
        // Check neighbors
        for (int dir = 0; dir < 4; dir++)
        {
            if (!cell.Walls[dir])
            {
                int nx = x, ny = y;
                switch (dir)
                {
                    case 0: ny -= 1; break;
                    case 1: nx += 1; break;
                    case 2: ny += 1; break;
                    case 3: nx -= 1; break;
                }
                if (SolveMaze(nx, ny))
                {
                    cell.OnSolutionPath = true;
                    return true;
                }
            }
        }
        return false;
    }

    static void PrintMaze()
    {
        for (int y = 0; y < Height; y++)
        {
            // Print top walls
            for (int x = 0; x < Width; x++)
            {
                Console.Write("+");
                Console.Write(maze[x, y].Walls[0] ? "---" : "   ");
            }
            Console.WriteLine("+");

            // Print side walls and cells
            for (int x = 0; x < Width; x++)
            {
                Console.Write(maze[x, y].Walls[3] ? "|" : " ");
                if (maze[x, y].OnSolutionPath)
                    Console.Write(" . ");
                else
                    Console.Write("   ");
            }
            Console.WriteLine("|");
        }
        // Print bottom walls
        for (int x = 0; x < Width; x++)
        {
            Console.Write("+---");
        }
        Console.WriteLine("+");
    }
}