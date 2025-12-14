// Note: This C# code is a simulation of what a 6502 Assembly program would do for converting an image to grayscale.
// It creates a byte array representing image pixel data, then runs a simulated "assembly" routine that processes each pixel.
// The focus is on demonstrating the logic in C# similar to how it would be implemented in 6502 Assembly.

using System;

class Program
{
    static void Main()
    {
        // Example image pixel data: each pixel is RGB (3 bytes)
        // Let's create a small image with 4 pixels for illustration
        byte[] imagePixels = new byte[]
        {
            // Pixel 1: R=120, G=200, B=150
            120, 200, 150,
            // Pixel 2: R=60, G=80, B=90
            60, 80, 90,
            // Pixel 3: R=255, G=0, B=0
            255, 0, 0,
            // Pixel 4: R=0, G=0, B=255
            0, 0, 255
        };

        Console.WriteLine("Original Pixels:");
        PrintPixels(imagePixels);

        // Convert to grayscale using a simulated 6502 assembly routine
        ConvertToGrayscale(imagePixels);

        Console.WriteLine("\nConverted to Grayscale:");
        PrintPixels(imagePixels);
    }

    // Function to simulate a 6502 assembly routine for grayscale conversion
    static void ConvertToGrayscale(byte[] pixels)
    {
        // Each pixel has 3 bytes (R, G, B)
        for (int i = 0; i < pixels.Length; i += 3)
        {
            byte r = pixels[i];
            byte g = pixels[i + 1];
            byte b = pixels[i + 2];

            // Calculate luminance: grayscale value
            // Using common NTSC formula:
            // grayscale = 0.299*R + 0.587*G + 0.114*B
            // Since 6502 Assembly lacks floating point, use integer math:
            // grayscale = (30 * R + 59 * G + 11 * B) / 100
            int grayscale = (30 * r + 59 * g + 11 * b) / 100;

            // Clamp to 0-255 if necessary
            byte grayByte = (byte)Math.Min(Math.Max(grayscale, 0), 255);

            // Set R, G, B to grayscale
            pixels[i] = grayByte;
            pixels[i + 1] = grayByte;
            pixels[i + 2] = grayByte;
        }
    }

    static void PrintPixels(byte[] pixels)
    {
        for (int i = 0; i < pixels.Length; i += 3)
        {
            Console.WriteLine($"Pixel {(i / 3) + 1}: R={pixels[i]}, G={pixels[i + 1]}, B={pixels[i + 2]}");
        }
    }
}