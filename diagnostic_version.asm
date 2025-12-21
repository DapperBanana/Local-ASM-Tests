// C# implementation simulating 6502 Assembly logic for Caesar cipher encryption/decryption

using System;

class CaesarCipher6502
{
    static void Main()
    {
        // Sample plaintext
        string plaintext = "HELLO WORLD";
        // Shift amount for Caesar cipher
        byte shift = 3;

        // Convert to uppercase ASCII bytes
        byte[] inputBytes = System.Text.Encoding.ASCII.GetBytes(plaintext.ToUpper());

        // Encrypt
        byte[] encryptedBytes = new byte[inputBytes.Length];
        for (int i = 0; i < inputBytes.Length; i++)
        {
            byte ch = inputBytes[i];

            // Check if character is uppercase alphabetical (ASCII 65-90)
            if (ch >= 65 && ch <= 90)
            {
                // Simulate 6502 Assembly: Apply Caesar shift with wrap-around
                ch = (byte)((ch - 65 + shift) % 26 + 65);
            }
            // Else leave it as is (spaces, punctuation, etc.)
            encryptedBytes[i] = ch;
        }

        string encryptedText = System.Text.Encoding.ASCII.GetString(encryptedBytes);
        Console.WriteLine("Encrypted: " + encryptedText);

        // Decrypt
        byte[] decryptedBytes = new byte[encryptedBytes.Length];
        for (int i = 0; i < encryptedBytes.Length; i++)
        {
            byte ch = encryptedBytes[i];

            if (ch >= 65 && ch <= 90)
            {
                // Apply reverse shift with wrap-around
                ch = (byte)((ch - 65 - shift + 26) % 26 + 65);
            }
            decryptedBytes[i] = ch;
        }

        string decryptedText = System.Text.Encoding.ASCII.GetString(decryptedBytes);
        Console.WriteLine("Decrypted: " + decryptedText);
    }
}