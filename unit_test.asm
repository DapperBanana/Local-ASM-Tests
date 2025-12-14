using System;

class VirtualPet6502Simulation
{
    static void Main()
    {
        // Define memory (simulated 6502 RAM)
        byte[] memory = new byte[256];

        // Initialize pet's attributes in memory
        const int happinessAddr = 0;   // Pet's happiness
        const int hungerAddr = 1;      // Pet's hunger
        const int nameAddr = 2;        // Pet's name starting address
        const int nameLength = 10;     // Max name length

        // Default pet data
        byte[] defaultName = { (byte)'F', (byte)'i', (byte)'d', (byte)'o', (byte)' ', (byte)' ', (byte)' ', (byte)' ', (byte)' ', (byte)' ' };

        Array.Copy(defaultName, 0, memory, nameAddr, nameLength);
        memory[happinessAddr] = 5; // Happiness 0-10
        memory[hungerAddr] = 5;    // Hunger 0-10

        // Helper functions
        void SetPetName()
        {
            Console.WriteLine("Enter a name for your pet (max 10 characters):");
            string input = Console.ReadLine();
            byte[] nameBytes = new byte[nameLength];

            for (int i = 0; i < nameLength; i++)
            {
                if (i < input.Length)
                {
                    nameBytes[i] = (byte)input[i];
                }
                else
                {
                    nameBytes[i] = (byte)' ';
                }
            }
            Array.Copy(nameBytes, 0, memory, nameAddr, nameLength);
        }

        string GetPetName()
        {
            return System.Text.Encoding.ASCII.GetString(memory, nameAddr, nameLength).Trim();
        }

        void DisplayStatus()
        {
            Console.WriteLine($"Pet's Name: {GetPetName()}");
            Console.WriteLine($"Happiness: {memory[happinessAddr]}");
            Console.WriteLine($"Hunger: {memory[hungerAddr]}");
            Console.WriteLine();
        }

        void SimulateTimePassage()
        {
            // Decrease happiness, increase hunger
            if (memory[happinessAddr] > 0)
                memory[happinessAddr]--;
            if (memory[hungerAddr] < 10)
                memory[hungerAddr]++;
        }

        void FeedPet()
        {
            if (memory[hungerAddr] > 0)
            {
                memory[hungerAddr]--;
                Console.WriteLine($"{GetPetName()} enjoyed the food!");
            }
            else
            {
                Console.WriteLine($"{GetPetName()} is not hungry.");
            }
        }

        void PlayWithPet()
        {
            if (memory[happinessAddr] < 10)
            {
                memory[happinessAddr]++;
                Console.WriteLine($"{GetPetName()} had fun!");
            }
            else
            {
                Console.WriteLine($"{GetPetName()}'s happiness is already maxed out.");
            }
        }

        // Initialize pet
        SetPetName();

        while (true)
        {
            Console.WriteLine("Choose an action:");
            Console.WriteLine("1. View Status");
            Console.WriteLine("2. Feed");
            Console.WriteLine("3. Play");
            Console.WriteLine("4. Rename");
            Console.WriteLine("5. Exit");
            string choice = Console.ReadLine();
            Console.WriteLine();

            switch (choice)
            {
                case "1":
                    DisplayStatus();
                    break;
                case "2":
                    FeedPet();
                    break;
                case "3":
                    PlayWithPet();
                    break;
                case "4":
                    SetPetName();
                    break;
                case "5":
                    Console.WriteLine("Goodbye!");
                    return;
                default:
                    Console.WriteLine("Invalid choice.");
                    break;
            }

            // Simulate time passing after each action
            SimulateTimePassage();
            Console.WriteLine();
        }
    }
}