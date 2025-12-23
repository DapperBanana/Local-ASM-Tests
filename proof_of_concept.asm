using System;

public class MedianFinder
{
    public static int FindMedian(int[] data)
    {
        int length = data.Length;
        int[] sorted = new int[length];
        Array.Copy(data, sorted, length);

        // Simple Bubble Sort (similar to assembly style sorting)
        for (int i = 0; i < length - 1; i++)
        {
            for (int j = 0; j < length - i - 1; j++)
            {
                if (sorted[j] > sorted[j + 1])
                {
                    // Swap
                    int temp = sorted[j];
                    sorted[j] = sorted[j + 1];
                    sorted[j + 1] = temp;
                }
            }
        }

        // Return median based on odd or even length
        if (length % 2 == 1)
        {
            // Odd length: middle element
            return sorted[length / 2];
        }
        else
        {
            // Even length: average of two middle elements
            int mid1 = sorted[(length / 2) - 1];
            int mid2 = sorted[length / 2];
            return (mid1 + mid2) / 2;
        }
    }

    public static void Main()
    {
        int[] numbers = { 7, 2, 9, 4, 5 };
        int median = FindMedian(numbers);
        Console.WriteLine("Median: " + median);
    }
}