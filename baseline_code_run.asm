// Caesar cipher encryption and decryption
using System;

class CaesarCipher6502
{
    // Encrypts input text using the given shift
    public static string Encrypt(string input, int shift)
    {
        char[] buffer = new char[input.Length];
        for (int i = 0; i < input.Length; i++)
        {
            buffer[i] = EncryptChar(input[i], shift);
        }
        return new string(buffer);
    }

    // Decrypts input text using the given shift
    public static string Decrypt(string input, int shift)
    {
        // To decrypt, shift in the opposite direction
        return Encrypt(input, 26 - (shift % 26));
    }

    // Encrypts a single character
    private static char EncryptChar(char ch, int shift)
    {
        if (ch >= 'A' && ch <= 'Z')
        {
            // Uppercase letter
            return (char)((((ch - 'A') + shift) % 26) + 'A');
        }
        else if (ch >= 'a' && ch <= 'z')
        {
            // Lowercase letter
            return (char)((((ch - 'a') + shift) % 26) + 'a');
        }
        else
        {
            // Non-alphabetic characters unchanged
            return ch;
        }
    }

    static void Main()
    {
        string plaintext = "Hello, World!";
        int shift = 3; // Caesar shift

        string encrypted = Encrypt(plaintext, shift);
        Console.WriteLine("Encrypted: " + encrypted);

        string decrypted = Decrypt(encrypted, shift);
        Console.WriteLine("Decrypted: " + decrypted);
    }
}