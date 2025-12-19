using System;

class BinarySearchExample
{
    static void Main()
    {
        int[] sortedArray = { 1, 3, 5, 7, 9, 11, 13, 15, 17, 19 };
        int target = 7;

        int index = BinarySearch(sortedArray, target);

        if (index != -1)
        {
            Console.WriteLine($"Found {target} at index {index}.");
        }
        else
        {
            Console.WriteLine($"{target} not found in array.");
        }
    }

    static int BinarySearch(int[] arr, int target)
    {
        int low = 0;
        int high = arr.Length - 1;

        while (low <= high)
        {
            int mid = low + (high - low) / 2;

            if (arr[mid] == target)
            {
                return mid;
            }
            else if (arr[mid] < target)
            {
                low = mid + 1;
            }
            else
            {
                high = mid - 1;
            }
        }

        return -1; // Not found
    }
}