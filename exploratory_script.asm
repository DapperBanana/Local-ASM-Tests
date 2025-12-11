using System;

class RockPaperScissors
{
    static void Main()
    {
        string[] choices = { "Rock", "Paper", "Scissors" };
        Random rand = new Random();

        while (true)
        {
            Console.WriteLine("Choose: 0 = Rock, 1 = Paper, 2 = Scissors. Other to exit.");
            string input = Console.ReadLine();

            if (!int.TryParse(input, out int userChoice) || userChoice < 0 || userChoice > 2)
            {
                Console.WriteLine("Exiting game.");
                break;
            }

            int computerChoice = rand.Next(0, 3);

            Console.WriteLine($"You chose {choices[userChoice]}");
            Console.WriteLine($"Computer chose {choices[computerChoice]}");

            int result = (3 + userChoice - computerChoice) % 3;

            if (result == 0)
            {
                Console.WriteLine("It's a draw!");
            }
            else if (result == 1)
            {
                Console.WriteLine("You win!");
            }
            else
            {
                Console.WriteLine("Computer wins!");
            }
        }
    }
}