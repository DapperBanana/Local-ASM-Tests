using System;
using System.Collections.Generic;

class Program
{
    static void Main()
    {
        byte[] listA = { 1, 2, 3, 4, 5 };
        byte[] listB = { 3, 4, 5, 6, 7 };

        List<byte> commonElements = FindCommonElements(listA, listB);

        Console.WriteLine("Common elements:");
        foreach (byte element in commonElements)
        {
            Console.WriteLine(element);
        }
    }

    static List<byte> FindCommonElements(byte[] listA, byte[] listB)
    {
        List<byte> result = new List<byte>();

        // For each element in listA
        for (int i = 0; i < listA.Length; i++)
        {
            byte aElement = listA[i];

            // Check if aElement is in listB
            for (int j = 0; j < listB.Length; j++)
            {
                if (aElement == listB[j])
                {
                    // Avoid duplicates in result
                    if (!result.Contains(aElement))
                    {
                        result.Add(aElement);
                    }
                    break; // Break inner loop once match is found
                }
            }
        }
        return result;
    }
}