// Note: The following C# code mimics a 6502 assembly program approach to check if a string is a valid URL.
// It demonstrates core logic similar to what a 6502 assembly might implement.

using System;

class URLValidator6502
{
    static void Main()
    {
        string testString = "http://example.com";

        bool isValid = IsValidURL(testString);
        Console.WriteLine($"URL: {testString}");
        Console.WriteLine($"Is valid URL: {isValid}");
    }

    static bool IsValidURL(string url)
    {
        int ptr = 0;
        int length = url.Length;

        // Check scheme: must start with "http://" or "https://"
        if (length < 7)
            return false;

        // Read first 4 characters
        char c1 = url.Length >= 4 ? url[0] : '\0';
        char c2 = url.Length >= 5 ? url[1] : '\0';
        char c3 = url.Length >= 6 ? url[2] : '\0';
        char c4 = url.Length >= 7 ? url[3] : '\0';

        string scheme = url.Substring(0, 7); // "http://"

        if (scheme.Equals("http://", StringComparison.OrdinalIgnoreCase))
        {
            ptr = 7;
        }
        else
        {
            // Check for "https://"
            if (length >= 8 && url.Substring(0,8).Equals("https://", StringComparison.OrdinalIgnoreCase))
            {
                ptr = 8;
            }
            else
            {
                return false; // Invalid scheme
            }
        }

        // Check for domain part: should contain at least one '.' after scheme
        int domainStart = ptr;
        int dotIndex = url.IndexOf('.', domainStart);
        if (dotIndex == -1 || dotIndex == domainStart)
            return false; // No '.' in domain

        // Validate characters in domain (simple check: alphanumeric or '.')
        for (int i = domainStart; i <= dotIndex; i++)
        {
            if (!IsValidDomainChar(url[i]))
                return false;
        }

        // Check path/query (optional)
        // For simplicity, accept URLs with at least domain and '.'
        // Further checks can be added for path/query validation

        return true;
    }

    static bool IsValidDomainChar(char c)
    {
        if (char.IsLetterOrDigit(c))
            return true;
        if (c == '.')
            return true;
        return false;
    }
}