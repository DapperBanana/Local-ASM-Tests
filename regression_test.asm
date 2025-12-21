using System;

class Program
{
    static void Main()
    {
        int length = 12; // desired password length
        string password = GeneratePassword(length);
        Console.WriteLine(password);
    }

    static string GeneratePassword(int length)
    {
        const string charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+-=[]{}|;:,.<>?";
        char[] password = new char[length];
        Random rand = new Random();

        for (int i = 0; i < length; i++)
        {
            int index = rand.Next(charset.Length);
            password[i] = charset[index];
        }

        return new string(password);
    }
}