// Note: This is a conceptual C# implementation inspired by 6502 assembly logic
// that checks if a graph is a tree. The actual 6502 assembly code would be quite complex
// and lengthy, but here is a high-level translation as per the request.

using System;
using System.Collections.Generic;

public class GraphChecker
{
    // Number of nodes in the graph
    int nodeCount;
    // Edges represented as adjacency list
    List<int>[] adjacency;

    public GraphChecker(int n, int[][] edges)
    {
        nodeCount = n;
        adjacency = new List<int>[n];
        for (int i = 0; i < n; i++)
            adjacency[i] = new List<int>();

        // Build the adjacency list
        foreach (var edge in edges)
        {
            int u = edge[0];
            int v = edge[1];
            adjacency[u].Add(v);
            adjacency[v].Add(u);
        }
    }

    // Check if the graph is a tree
    public bool IsTree()
    {
        // Edge count should be exactly n-1
        int edgeCount = 0;
        for (int i = 0; i < nodeCount; i++)
            edgeCount += adjacency[i].Count;
        edgeCount /= 2; // since undirected

        if (edgeCount != nodeCount - 1)
            return false; // Not the right number of edges for a tree

        bool[] visited = new bool[nodeCount];
        // BFS or DFS to check connectivity and absence of cycles
        Queue<int> queue = new Queue<int>();
        queue.Enqueue(0);
        visited[0] = true;
        int visitedCount = 1;

        while (queue.Count > 0)
        {
            int current = queue.Dequeue();
            foreach (var neighbor in adjacency[current])
            {
                if (!visited[neighbor])
                {
                    visited[neighbor] = true;
                    visitedCount++;
                    queue.Enqueue(neighbor);
                }
                else if (neighbor != current) // Ignore self-loop / parent check not needed here
                {
                    // In an undirected graph, need to detect cycles
                    // But since BFS, detecting a visited node not parent indicates cycle
                    // To do that properly, need parent info; simplified here
                }
            }
        }

        // Check if all nodes are visited
        return visitedCount == nodeCount;
    }
}

// Usage example:
// int n = 5;
// int[][] edges = new int[][] { new int[] {0,1}, new int[] {0,2}, new int[] {1,3}, new int[] {1,4} };
// var graphChecker = new GraphChecker(n, edges);
// Console.WriteLine(graphChecker.IsTree() ? "Graph is a tree" : "Graph is not a tree");