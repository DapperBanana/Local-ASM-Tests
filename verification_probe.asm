// C# code simulating 6502 assembly logic to sum elements of a list
byte[] memory = new byte[] {
    3,  // Number of elements
    10,
    20,
    30
};

// Pointer to the start of the list (index 0)
int listLength = memory[0];
int sum = 0;

for (int i = 1; i <= listLength; i++)
{
    sum += memory[i];
}

// Output the result
Console.WriteLine($"Sum of list elements: {sum}");