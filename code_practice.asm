byte[] memory = new byte[65536];

// Define the list of elements in memory
byte[] list = { 10, 20, 30, 40, 50 };
int listStartAddress = 0x1000;  // Arbitrary starting address
for (int i = 0; i < list.Length; i++)
{
    memory[listStartAddress + i] = list[i];
}

// Initialize registers
int A = 0;      // Accumulator
int X = 0;      // Index register
int sum = 0;

// Initialize the pointer to start of list
int ptr = listStartAddress;

// Loop to sum all elements
while (X < list.Length)
{
    A = memory[ptr + X];  // Load element into A
    sum += A;             // Add to sum
    X++;                  // Increment index
}

// At the end, 'sum' contains the total sum of list elements
Console.WriteLine($"Sum of list elements: {sum}");