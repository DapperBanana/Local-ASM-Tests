using System;

class RockPaperScissors
{
    static void Main()
    {
        string[] choices = { "Rock", "Paper", "Scissors" };
        Random rand = new Random();

        while (true)
        {
            Console.WriteLine("Enter your choice (Rock, Paper, Scissors) or 'exit' to quit:");
            string userInput = Console.ReadLine().Trim();

            if (userInput.Equals("exit", StringComparison.OrdinalIgnoreCase))
                break;

            int userChoice = Array.FindIndex(choices, c => c.Equals(userInput, StringComparison.OrdinalIgnoreCase));

            if (userChoice == -1)
            {
                Console.WriteLine("Invalid choice. Try again.");
                continue;
            }

            int computerChoice = rand.Next(0, 3);
            Console.WriteLine($"Computer chose: {choices[computerChoice]}");

            // Determine the result
            int result = (userChoice - computerChoice + 3) % 3;

            if (result == 0)
            {
                Console.WriteLine("It's a tie!");
            }
            else if (result == 1)
            {
                Console.WriteLine("You win!");
            }
            else
            {
                Console.WriteLine("You lose!");
            }
        }
    }
}