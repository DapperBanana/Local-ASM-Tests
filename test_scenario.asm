using System;

class BaseConverter6502
{
    static void Main()
    {
        // Example input
        string inputNumber = "1011"; // binary for 11
        int fromBase = 2;             // source base
        int toBase = 10;              // target base

        string result = ConvertBase(inputNumber, fromBase, toBase);
        Console.WriteLine($"Number {inputNumber} from base {fromBase} to base {toBase} is {result}");
    }

    static string ConvertBase(string number, int fromBase, int toBase)
    {
        // Emulate 6502-like manual processing
        int decimalValue = 0;

        // Simulate processing each digit like in Assembly
        foreach (char digitChar in number)
        {
            int digit = CharToDigit(digitChar);

            // Validate digit
            if (digit >= fromBase)
                throw new ArgumentException($"Invalid digit '{digitChar}' for base {fromBase}");

            // decimalValue = decimalValue * fromBase + digit
            // since 6502 lacks multiplication, can simulate via repeated addition
            decimalValue = MultiplyAndAdd(decimalValue, fromBase, digit);
        }

        // Convert decimal to target base
        return DecimalToBase(decimalValue, toBase);
    }

    static int CharToDigit(char c)
    {
        if (c >= '0' && c <= '9')
            return c - '0';
        else if (c >= 'A' && c <= 'Z')
            return c - 'A' + 10;
        else
            throw new ArgumentException($"Invalid character: {c}");
    }

    static int DigitToChar(int d)
    {
        if (d >= 0 && d <= 9)
            return d;
        else
            throw new ArgumentException($"Invalid digit: {d}");
    }

    static int MultiplyAndAdd(int value, int multiplier, int digit)
    {
        // Emulate multiplication by repeated addition
        int result = 0;
        for (int i = 0; i < multiplier; i++)
        {
            result = Add(result, value);
        }
        result = Add(result, digit);
        return result;
    }

    static int Add(int a, int b)
    {
        // Simple addition, in real Assembly would be just add
        return a + b;
    }

    static string DecimalToBase(int decimalNumber, int baseToConvert)
    {
        if (decimalNumber == 0)
            return "0";

        char[] digits = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ".ToCharArray();
        string result = "";

        // Emulate division and remainder extraction
        while (decimalNumber > 0)
        {
            int remainder = Modulo(decimalNumber, baseToConvert);
            decimalNumber = Divide(decimalNumber, baseToConvert);
            result = digits[remainder] + result;
        }
        return result;
    }

    static int Divide(int dividend, int divisor)
    {
        // Emulate division without using division operator, using repeated subtraction
        int quotient = 0;
        while (Subtraction(dividend, divisor) >= 0)
        {
            dividend = Subtraction(dividend, divisor);
            quotient++;
        }
        return quotient;
    }

    static int Modulo(int dividend, int divisor)
    {
        // Emulate modulo by repeated subtraction
        int remainder = dividend;
        while (Subtraction(remainder, divisor) >= 0)
        {
            remainder = Subtraction(remainder, divisor);
        }
        return remainder;
    }

    static int Subtraction(int a, int b)
    {
        // No subtraction operator, simulate via addition of negatives
        // But for simplicity, here directly subtract
        return a - b;
    }
}