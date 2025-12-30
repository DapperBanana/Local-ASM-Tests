using System;
using System.Collections.Generic;

class MazeGeneratorSolver
{
    const int width = 20;   // maze width
    const int height = 20;  // maze height
    static int[,] maze = new int[width, height];
    static bool[,] visited = new bool[width, height];
    static Random rand = new Random();

    static void Main()
    {
        GenerateMaze();
        Console.WriteLine("Generated Maze:");
        PrintMaze();

        Console.WriteLine("\nSolving Maze:");
        if (SolveMaze(0, 0))
        {
            PrintSolution();
        }
        else
        {
            Console.WriteLine("No solution found.");
        }
    }

    static void GenerateMaze()
    {
        // Initialize maze with walls
        for (int x = 0; x < width; x++)
            for (int y = 0; y < height; y++)
                maze[x, y] = 1; // wall

        // Recursive backtracking for maze generation
        CarvePassagesFrom(0, 0);
    }

    static void CarvePassagesFrom(int cx, int cy)
    {
        int[] dx = { 1, -1, 0, 0 };
        int[] dy = { 0, 0, 1, -1 };

        var dirs = new List<int> { 0, 1, 2, 3 };
        // Shuffle directions
        for (int i = 0; i < dirs.Count; i++)
        {
            int swapIdx = rand.Next(i, dirs.Count);
            int temp = dirs[i];
            dirs[i] = dirs[swapIdx];
            dirs[swapIdx] = temp;
        }

        foreach (int dir in dirs)
        {
            int nx = cx + dx[dir] * 2;
            int ny = cy + dy[dir] * 2;

            if (nx >= 0 && ny >= 0 && nx < width && ny < height && maze[nx, ny] == 1)
            {
                maze[cx + dx[dir], cy + dy[dir]] = 0; // remove wall between
                maze[nx, ny] = 0; // carve passage
                CarvePassagesFrom(nx, ny);
            }
        }
    }

    static bool[] cameFromX = new bool[width * height];
    static bool[] cameFromY = new bool[width * height];
    static bool[] visitedSolve = new bool[width * height];
    static List<(int, int)> path = new List<(int, int)>();

    static bool SolveMaze(int startX, int startY)
    {
        // Breadth-first search
        Queue<(int x, int y)> queue = new Queue<(int, int)>();
        bool[,] visitedBFS = new bool[width, height];
        (int, int)[] directions = { (1, 0), (-1, 0), (0, 1), (0, -1) };
        int startIdx = startX * height + startY;

        visitedBFS[startX, startY] = true;
        queue.Enqueue((startX, startY));

        (int x, int y) endPoint = (width - 1, height - 1);
        bool found = false;

        while (queue.Count > 0)
        {
            var (x, y) = queue.Dequeue();
            if (x == endPoint.x && y == endPoint.y)
            {
                // Reconstruct path
                PathReconstruction(x, y);
                return true;
            }

            foreach (var (dx, dy) in directions)
            {
                int nx = x + dx;
                int ny = y + dy;

                if (nx >= 0 && ny >= 0 && nx < width && ny < height)
                {
                    if (!visitedBFS[nx, ny] && maze[nx, ny] == 0)
                    {
                        visitedBFS[nx, ny] = true;
                        queue.Enqueue((nx, ny));
                        // Store previous cell for path reconstruction
                        cameFromX[nx * height + ny] = x;
                        cameFromY[nx * height + ny] = y;
                    }
                }
            }
        }

        return false;
    }

    static void PathReconstruction(int endX, int endY)
    {
        path.Clear();
        int x = endX;
        int y = endY;
        while (!(x == 0 && y == 0))
        {
            path.Add((x, y));
            int prevX = cameFromX[x * height + y] ? x : 0;
            int prevY = cameFromY[x * height + y] ? y : 0;

            int tempX = x;
            x = cameFromX[tempX * height + y];
            y = cameFromY[tempX * height + y];
        }
        path.Add((0, 0));
        path.Reverse();
    }

    static void PrintMaze()
    {
        for (int y = 0; y < height; y++)
        {
            for (int x = 0; x < width; x++)
            {
                Console.Write(maze[x, y] == 1 ? "#" : " ");
            }
            Console.WriteLine();
        }
    }

    static void PrintSolution()
    {
        char[,] display = new char[width, height];

        for (int x = 0; x < width; x++)
            for (int y = 0; y < height; y++)
                display[x, y] = maze[x, y] == 1 ? '#' : ' ';

        foreach (var (x, y) in path)
        {
            if (x >= 0 && y >= 0 && x < width && y < height)
                display[x, y] = '*';
        }

        for (int y = 0; y < height; y++)
        {
            for (int x = 0; x < width; x++)
            {
                Console.Write(display[x, y]);
            }
            Console.WriteLine();
        }
    }
}