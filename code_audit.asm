using System;

class BlackjackGame
{
    static Random rng = new Random();

    static void Main()
    {
        Console.WriteLine("Welcome to Basic Blackjack!");

        while (true)
        {
            int[] deck = CreateDeck();
            ShuffleDeck(deck);

            int playerScore = 0;
            int dealerScore = 0;

            // Deal initial two cards to player and dealer
            int playerCard1 = DrawCard(deck);
            int playerCard2 = DrawCard(deck);
            int dealerCard1 = DrawCard(deck);
            int dealerCard2 = DrawCard(deck);

            playerScore = GetCardValue(playerCard1) + GetCardValue(playerCard2);
            dealerScore = GetCardValue(dealerCard1) + GetCardValue(dealerCard2);

            Console.WriteLine($"Your cards: {CardName(playerCard1)} and {CardName(playerCard2)} (Total: {playerScore})");
            Console.WriteLine($"Dealer shows: {CardName(dealerCard1)}");

            // Player turn
            while (true)
            {
                Console.Write("Hit or stay? (h/s): ");
                string input = Console.ReadLine().ToLower();
                if (input == "h")
                {
                    int newCard = DrawCard(deck);
                    playerScore += GetCardValue(newCard);
                    Console.WriteLine($"You drew: {CardName(newCard)} (Total: {playerScore})");
                    if (playerScore > 21)
                    {
                        Console.WriteLine("Bust! You lose.");
                        break;
                    }
                }
                else if (input == "s")
                {
                    Console.WriteLine($"You stay with total: {playerScore}");
                    break;
                }
                else
                {
                    Console.WriteLine("Invalid input, please enter 'h' or 's'.");
                }
            }

            // Dealer turn
            if (playerScore <= 21)
            {
                Console.WriteLine($"Dealer's hidden card was: {CardName(dealerCard2)} (Total: {dealerScore})");
                while (dealerScore < 17)
                {
                    int newCard = DrawCard(deck);
                    dealerScore += GetCardValue(newCard);
                    Console.WriteLine($"Dealer draws: {CardName(newCard)} (Total: {dealerScore})");
                }

                if (dealerScore > 21)
                {
                    Console.WriteLine("Dealer busts! You win!");
                }
                else
                {
                    Console.WriteLine($"Final scores - You: {playerScore}, Dealer: {dealerScore}");
                    if (playerScore > dealerScore)
                        Console.WriteLine("You win!");
                    else if (playerScore < dealerScore)
                        Console.WriteLine("Dealer wins!");
                    else
                        Console.WriteLine("It's a tie!");
                }
            }

            Console.Write("Play again? (y/n): ");
            if (Console.ReadLine().ToLower() != "y")
                break;

            Console.WriteLine();
        }
        Console.WriteLine("Thanks for playing!");
    }

    static int[] CreateDeck()
    {
        int[] deck = new int[52];
        for (int i = 0; i < 52; i++)
        {
            deck[i] = i;
        }
        return deck;
    }

    static void ShuffleDeck(int[] deck)
    {
        for (int i = 0; i < deck.Length; i++)
        {
            int j = rng.Next(i, deck.Length);
            int temp = deck[i];
            deck[i] = deck[j];
            deck[j] = temp;
        }
    }

    static int DrawCard(int[] deck)
    {
        static int index = 0;
        if (index >= deck.Length) throw new InvalidOperationException("Deck is empty");
        return deck[index++];
    }

    static int GetCardValue(int card)
    {
        int rank = card % 13;
        if (rank >= 0 && rank <= 8) // cards 2-10
            return rank + 2;
        else if (rank >= 9 && rank <= 11) // Jack, Queen, King
            return 10;
        else // Ace
            return 11;
    }

    static string CardName(int card)
    {
        string[] ranks = { "2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace" };
        string[] suits = { "♠", "♥", "♦", "♣" };
        string rankName = ranks[card % 13];
        string suitName = suits[card / 13];
        return $"{rankName} of {suitName}";
    }
}