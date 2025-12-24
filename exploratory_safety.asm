using System;
using System.Collections.Generic;

class Graph
{
    private int[,] adjacencyMatrix;
    private int vertices;

    public Graph(int vertices)
    {
        this.vertices = vertices;
        adjacencyMatrix = new int[vertices, vertices];

        // Initialize adjacency matrix with 0 (no edges)
        for (int i = 0; i < vertices; i++)
            for (int j = 0; j < vertices; j++)
                adjacencyMatrix[i, j] = 0;
    }

    public void AddEdge(int from, int to)
    {
        adjacencyMatrix[from, to] = 1; // Assuming unweighted graph
        adjacencyMatrix[to, from] = 1; // For undirected graph
    }

    public int[] BFS(int start, int end)
    {
        var visited = new bool[vertices];
        var previous = new int[vertices];
        for (int i = 0; i < vertices; i++)
            previous[i] = -1;
        
        var queue = new Queue<int>();
        visited[start] = true;
        queue.Enqueue(start);

        while (queue.Count > 0)
        {
            int current = queue.Dequeue();
            if (current == end)
                return ReconstructPath(previous, start, end);
            
            for (int neighbor = 0; neighbor < vertices; neighbor++)
            {
                if (adjacencyMatrix[current, neighbor] == 1 && !visited[neighbor])
                {
                    visited[neighbor] = true;
                    previous[neighbor] = current;
                    queue.Enqueue(neighbor);
                }
            }
        }
        // No path found
        return new int[0];
    }

    private int[] ReconstructPath(int[] previous, int start, int end)
    {
        var path = new List<int>();
        for (int at = end; at != -1; at = previous[at])
        {
            path.Add(at);
        }
        path.Reverse();

        if (path[0] == start)
            return path.ToArray();
        else
            return new int[0]; // no path
    }

    static void Main()
    {
        var graph = new Graph(6);

        // Example graph edges
        graph.AddEdge(0, 1);
        graph.AddEdge(0, 2);
        graph.AddEdge(1, 3);
        graph.AddEdge(2, 3);
        graph.AddEdge(3, 4);
        graph.AddEdge(4, 5);

        int start = 0;
        int end = 5;

        var shortestPath = graph.BFS(start, end);

        if (shortestPath.Length == 0)
            Console.WriteLine("No path found.");
        else
        {
            Console.WriteLine("Shortest path: " + string.Join(" -> ", shortestPath));
        }
    }
}