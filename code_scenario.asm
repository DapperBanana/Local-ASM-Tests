// Note: The following C# code simulates the logic of a 6502 assembly program
// that checks if a given string is a valid email address. Since the 6502
// assembly is low-level and not directly translatable here, this C# code
// mimics the approach, focusing on core validation steps.

public class EmailValidator6502
{
    public static bool IsValidEmail(string email)
    {
        if (string.IsNullOrEmpty(email))
            return false;

        int length = email.Length;
        int atCount = 0;
        int atPosition = -1;

        // Check for exactly one '@' symbol
        for (int i = 0; i < length; i++)
        {
            if (email[i] == '@')
            {
                atCount++;
                atPosition = i;
            }
        }

        if (atCount != 1 || atPosition == 0 || atPosition == length - 1)
            return false;

        // Split into local and domain parts
        string localPart = email.Substring(0, atPosition);
        string domainPart = email.Substring(atPosition + 1);

        // Validate local part: must be non-empty and contain only valid characters
        if (string.IsNullOrEmpty(localPart))
            return false;

        foreach (char c in localPart)
        {
            if (!IsValidLocalChar(c))
                return false;
        }

        // Validate domain part: must contain at least one '.' not at the start or end
        int dotIndex = domainPart.IndexOf('.');
        if (dotIndex <= 0 || dotIndex == domainPart.Length - 1)
            return false;

        // Domain must be alphanumeric labels separated by dots
        string[] domainLabels = domainPart.Split('.');

        foreach (string label in domainLabels)
        {
            if (string.IsNullOrEmpty(label))
                return false;
            foreach (char c in label)
            {
                if (!IsValidDomainChar(c))
                    return false;
            }
        }

        return true;
    }

    private static bool IsValidLocalChar(char c)
    {
        // Simplified check: alphanumeric and common symbols
        return char.IsLetterOrDigit(c) || c == '.' || c == '_' || c == '-';
    }

    private static bool IsValidDomainChar(char c)
    {
        // Simplified check: alphanumeric
        return char.IsLetterOrDigit(c);
    }

    // Example usage:
    public static void Main()
    {
        string[] testEmails = {
            "user@example.com",
            "user.name@sub.domain.org",
            "invalid@domain",
            "@missinglocal.com",
            "missingatsign.com",
            "user@.com",
            "user@domain.",
            "user@domain.c"
        };

        foreach (var email in testEmails)
        {
            bool isValid = IsValidEmail(email);
            System.Console.WriteLine($"{email}: {(isValid ? "Valid" : "Invalid")}");
        }
    }
}