using System;

class LongestIncreasingSubsequence
{
    public static void Main()
    {
        int[] array = { 10, 9, 2, 5, 3, 7, 101, 18 };  // Sample array
        int n = array.Length;
        int[] dp = new int[n];
        int[] prev = new int[n];

        // Initialize DP arrays
        for (int i = 0; i < n; i++)
        {
            dp[i] = 1;
            prev[i] = -1;  // To reconstruct the sequence later
        }

        int maxLen = 1;
        int maxIndex = 0;

        // Compute LIS using dynamic programming
        for (int i = 1; i < n; i++)
        {
            for (int j = 0; j < i; j++)
            {
                if (array[j] < array[i] && dp[j] + 1 > dp[i])
                {
                    dp[i] = dp[j] + 1;
                    prev[i] = j;
                }
            }

            // Track maximum length and index
            if (dp[i] > maxLen)
            {
                maxLen = dp[i];
                maxIndex = i;
            }
        }

        // Reconstruct LIS sequence
        int[] lis = new int[maxLen];
        int currentIndex = maxIndex;
        for (int i = maxLen - 1; i >= 0; i--)
        {
            lis[i] = array[currentIndex];
            currentIndex = prev[currentIndex];
        }

        // Output the result
        Console.WriteLine("Longest Increasing Subsequence:");
        foreach (int num in lis)
        {
            Console.Write(num + " ");
        }
        Console.WriteLine();
    }
}