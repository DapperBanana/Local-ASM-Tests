using System;

class Program
{
    static void Main()
    {
        // Define the length of the password
        int passwordLength = 12;

        // Characters: 0-9, A-Z, a-z
        string chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";

        // Initialize the random number generator
        Random rng = new Random();

        char[] password = new char[passwordLength];

        for (int i = 0; i < passwordLength; i++)
        {
            // Simulate fetching a random byte
            int randByte = rng.Next(0, 256);

            // Mimic 6502's modulo operation for selection
            int index = randByte % chars.Length;

            // Select character
            password[i] = chars[index];
        }

        // Output the generated password
        Console.WriteLine("Generated Password: " + new string(password));
    }
}