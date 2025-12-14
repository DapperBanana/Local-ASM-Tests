using System;
using System.Drawing;

class Program
{
    static void Main()
    {
        int width = 256;
        int height = 256;

        using (var bitmap = new Bitmap(width, height))
        {
            var rand = new Random();

            for(int y = 0; y < height; y++)
            {
                for(int x = 0; x < width; x++)
                {
                    // Generate random RGB values
                    Color randomColor = Color.FromArgb(
                        rand.Next(256),
                        rand.Next(256),
                        rand.Next(256)
                    );
                    bitmap.SetPixel(x, y, randomColor);
                }
            }

            // Save the generated image
            bitmap.Save("random_image.png", System.Drawing.Imaging.ImageFormat.Png);
        }

        Console.WriteLine("Random image generated and saved as 'random_image.png'.");
    }
}