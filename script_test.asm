using System;
using System.Collections.Generic;

class Program
{
    static void Main()
    {
        // Example input data (simulate file content)
        byte[] inputData = { 1, 1, 1, 2, 2, 3, 3, 3, 3, 4 };
        
        // Compress the data
        byte[] compressedData = RLECompress(inputData);
        
        Console.WriteLine("Original Data: " + BitConverter.ToString(inputData));
        Console.WriteLine("Compressed Data: " + BitConverter.ToString(compressedData));

        // Decompress for verification
        byte[] decompressedData = RLEDecompress(compressedData);
        Console.WriteLine("Decompressed Data: " + BitConverter.ToString(decompressedData));
    }

    static byte[] RLECompress(byte[] data)
    {
        List<byte> compressed = new List<byte>();
        int count = 1;
        for (int i = 0; i < data.Length; i++)
        {
            // Count runs of the same byte
            while (i + 1 < data.Length && data[i] == data[i + 1] && count < 255)
            {
                count++;
                i++;
            }
            // Store run length and byte value
            compressed.Add((byte)count);
            compressed.Add(data[i]);
            count = 1;
        }
        return compressed.ToArray();
    }

    static byte[] RLEDecompress(byte[] data)
    {
        List<byte> decompressed = new List<byte>();
        for (int i = 0; i < data.Length; i += 2)
        {
            int runLength = data[i];
            byte value = data[i + 1];
            for (int j = 0; j < runLength; j++)
            {
                decompressed.Add(value);
            }
        }
        return decompressed.ToArray();
    }
}