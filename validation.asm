// Note: This C# code simulates a simple text-based blackjack game with logic inspired by a 6502 assembly style.
// It doesn't directly run on a 6502 processor, but illustrates the core game logic in a way similar to assembly programming.

using System;

class Blackjack6502Simulation
{
    static Random rand = new Random();

    static void Main()
    {
        int playerScore = 0;
        int dealerScore = 0;
        bool gameOver = false;

        Console.WriteLine("Welcome to Basic Text-Based Blackjack!");

        // Initialize hands
        playerScore = DrawCard() + DrawCard();
        dealerScore = DrawCard() + DrawCard();

        // Player's turn
        while (true)
        {
            Console.WriteLine($"Your total: {playerScore}");
            Console.Write("Hit or Stay? (h/s): ");
            char choice = Console.ReadLine().ToLower()[0];

            if (choice == 'h')
            {
                int card = DrawCard();
                playerScore += card;
                Console.WriteLine($"You drew a {card}. New total: {playerScore}");

                if (playerScore > 21)
                {
                    Console.WriteLine("Bust! You lose.");
                    gameOver = true;
                    break;
                }
            }
            else if (choice == 's')
            {
                break;
            }
            else
            {
                Console.WriteLine("Invalid input. Please enter 'h' or 's'.");
            }
        }

        if (gameOver)
        {
            Console.WriteLine("Game over.");
            return;
        }

        // Dealer's turn
        Console.WriteLine($"Dealer's total: {dealerScore}");
        while (dealerScore < 17)
        {
            int card = DrawCard();
            dealerScore += card;
            Console.WriteLine($"Dealer draws a {card}. Total now: {dealerScore}");
        }

        if (dealerScore > 21)
        {
            Console.WriteLine("Dealer busts! You win!");
        }
        else
        {
            // Compare hands
            Console.WriteLine($"Your total: {playerScore}");
            Console.WriteLine($"Dealer's total: {dealerScore}");

            if (playerScore > dealerScore)
            {
                Console.WriteLine("You win!");
            }
            else if (playerScore < dealerScore)
            {
                Console.WriteLine("Dealer wins!");
            }
            else
            {
                Console.WriteLine("It's a tie!");
            }
        }
    }

    // Simulate drawing a card, values 1-11 to reflect typical blackjack cards
    static int DrawCard()
    {
        int card = rand.Next(1, 12); // 1 to 11 inclusive
        return card;
    }
}