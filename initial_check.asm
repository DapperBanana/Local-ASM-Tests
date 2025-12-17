using System;
using System.Collections.Generic;

public class Graph
{
    private int nodes;
    private List<int>[] adj;

    public Graph(int n)
    {
        nodes = n;
        adj = new List<int>[n];
        for (int i = 0; i < n; i++)
        {
            adj[i] = new List<int>();
        }
    }

    public void AddEdge(int u, int v)
    {
        adj[u].Add(v);
        adj[v].Add(u);
    }

    public bool IsTree()
    {
        bool[] visited = new bool[nodes];

        // Check for cycles starting from node 0
        if (HasCycle(0, -1, visited))
            return false;

        // Check if all nodes are connected
        for (int i = 0; i < nodes; i++)
        {
            if (!visited[i])
                return false;
        }

        // Valid tree if no cycles and all nodes are connected
        return true;
    }

    private bool HasCycle(int current, int parent, bool[] visited)
    {
        visited[current] = true;

        foreach (var neighbor in adj[current])
        {
            if (!visited[neighbor])
            {
                if (HasCycle(neighbor, current, visited))
                    return true;
            }
            else if (neighbor != parent)
            {
                // Found a cycle
                return true;
            }
        }
        return false;
    }
}

// Example usage:
class Program
{
    static void Main()
    {
        // Create a graph with 5 nodes
        Graph g = new Graph(5);

        // Add edges
        g.AddEdge(0, 1);
        g.AddEdge(1, 2);
        g.AddEdge(2, 3);
        g.AddEdge(3, 4);
        // Uncomment the following line to introduce a cycle
        // g.AddEdge(4, 1);

        Console.WriteLine($"Is the graph a tree? {g.IsTree()}");
    }
}