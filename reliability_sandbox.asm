using System;

class JwtValidator
{
    // Checks if the input resembles a valid JWT
    public static bool IsValidJwt(string token)
    {
        if (string.IsNullOrEmpty(token))
            return false;

        // Split the token into parts separated by '.'
        var parts = token.Split('.');

        // A JWT should have exactly three parts
        if (parts.Length != 3)
            return false;

        // Basic validation: ensure each part is non-empty
        return !string.IsNullOrEmpty(parts[0]) &&
               !string.IsNullOrEmpty(parts[1]) &&
               !string.IsNullOrEmpty(parts[2]);

        // Additional validation (like Base64 decoding, checking structure, etc.)
        // can be added here for more thorough validation.
    }

    static void Main()
    {
        Console.WriteLine("Enter a JWT:");
        string input = Console.ReadLine();

        if (IsValidJwt(input))
            Console.WriteLine("Valid JWT format.");
        else
            Console.WriteLine("Invalid JWT format.");
    }
}