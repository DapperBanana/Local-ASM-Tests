using System;

class LongestCommonSubsequence
{
    // Function to find the length of LCS and the subsequence
    public static (int length, string subsequence) FindLCS(string s1, string s2)
    {
        int m = s1.Length;
        int n = s2.Length;

        // Create DP table
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
                else if (s1[i - 1] == s2[j - 1])
                {
                    dp[i, j] = dp[i - 1, j - 1] + 1;
                }
                else
                {
                    dp[i, j] = Math.Max(dp[i - 1, j], dp[i, j - 1]);
                }
            }
        }

        // Reconstruct the LCS string from the DP table
        int index = dp[m, n];
        char[] lcsChars = new char[index];

        int i_index = m;
        int j_index = n;

        while (i_index > 0 && j_index > 0)
        {
            if (s1[i_index - 1] == s2[j_index - 1])
            {
                lcsChars[index - 1] = s1[i_index - 1];
                i_index--;
                j_index--;
                index--;
            }
            else if (dp[i_index - 1, j_index] > dp[i_index, j_index - 1])
            {
                i_index--;
            }
            else
            {
                j_index--;
            }
        }

        return (dp[m, n], new string(lcsChars));
    }

    static void Main()
    {
        string str1 = "AGGTAB";
        string str2 = "GXTXAYB";

        var (length, subsequence) = FindLCS(str1, str2);
        Console.WriteLine($"Length of LCS: {length}");
        Console.WriteLine($"LCS: {subsequence}");
    }
}