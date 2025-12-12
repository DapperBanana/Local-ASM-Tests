using System;

class Program
{
    static void Main()
    {
        const int passwordLength = 12; // Length of the desired password
        char[] password = new char[passwordLength];

        // Seed the pseudo-random generator with current milliseconds (simulating a seed)
        int seed = DateTime.Now.Millisecond;
        Random rng = new Random(seed);

        // Alphanumeric characters (A-Z, a-z, 0-9)
        const string charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

        for (int i = 0; i < passwordLength; i++)
        {
            int index = rng.Next(charset.Length);
            password[i] = charset[index];
        }

        Console.WriteLine(new string(password));
    }
}