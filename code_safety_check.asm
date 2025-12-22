using System;
using System.Drawing;

class RandomImageGenerator
{
    static void Main()
    {
        int width = 256;
        int height = 256;
        Random rand = new Random();

        using (Bitmap bmp = new Bitmap(width, height))
        {
            for (int y = 0; y < height; y++)
            {
                for (int x = 0; x < width; x++)
                {
                    Color randomColor = Color.FromArgb(
                        rand.Next(256),
                        rand.Next(256),
                        rand.Next(256)
                    );
                    bmp.SetPixel(x, y, randomColor);
                }
            }

            bmp.Save("random_image.png", System.Drawing.Imaging.ImageFormat.Png);
        }

        Console.WriteLine("Random image generated and saved as random_image.png");
    }
}