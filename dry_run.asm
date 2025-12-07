using System;

class LongestCommonSubsequence
{
    public static string GetLCS(string a, string b)
    {
        int m = a.Length;
        int n = b.Length;

        // Create a DP table to store lengths of LCS
        int[,] dp = new int[m + 1, n + 1];

        // Fill the DP table
        for (int i = 0; i <= m; i++)
        {
            for (int j = 0; j <= n; j++)
            {
                if (i == 0 || j == 0)
                {
                    dp[i, j] = 0;
                }
                else if (a[i - 1] == b[j - 1])
                {
                    dp[i, j] = dp[i - 1, j - 1] + 1;
                }
                else
                {
                    dp[i, j] = Math.Max(dp[i - 1, j], dp[i, j - 1]);
                }
            }
        }

        // Reconstruct LCS from the DP table
        int index = dp[m, n];
        char[] lcsChars = new char[index];

        int x = m, y = n;
        while (x > 0 && y > 0)
        {
            if (a[x - 1] == b[y - 1])
            {
                lcsChars[index - 1] = a[x - 1];
                x--;
                y--;
                index--;
            }
            else if (dp[x - 1, y] > dp[x, y - 1])
            {
                x--;
            }
            else
            {
                y--;
            }
        }

        return new string(lcsChars);
    }

    static void Main()
    {
        string str1 = "AGGTAB";
        string str2 = "GXTXAYB";

        string lcs = GetLCS(str1, str2);
        Console.WriteLine($"Longest Common Subsequence: {lcs}");
    }
}