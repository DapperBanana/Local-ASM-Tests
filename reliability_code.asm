using System;

class StockTradingSystem
{
    static void Main()
    {
        int cash = 1000; // Starting cash
        int stock = 0;   // Number of stocks owned
        const int stockPrice = 50; // Fixed stock price for simplicity
        string input;

        Console.WriteLine("Welcome to the Basic Stock Trading System");
        Console.WriteLine($"You start with ${cash} cash and 0 stocks.\n");

        while (true)
        {
            Console.WriteLine($"Current cash: ${cash}");
            Console.WriteLine($"Current stocks: {stock}");
            Console.WriteLine($"Stock price: ${stockPrice}");
            Console.Write("Enter command (buy/sell/exit): ");
            input = Console.ReadLine().Trim().ToLower();

            if (input == "buy")
            {
                Console.Write("How many stocks do you want to buy? ");
                if (int.TryParse(Console.ReadLine(), out int qty))
                {
                    int cost = qty * stockPrice;
                    if (cost <= cash)
                    {
                        cash -= cost;
                        stock += qty;
                        Console.WriteLine($"Bought {qty} stocks for ${cost}.\n");
                    }
                    else
                    {
                        Console.WriteLine("Not enough cash to buy that many.\n");
                    }
                }
                else
                {
                    Console.WriteLine("Invalid quantity.\n");
                }
            }
            else if (input == "sell")
            {
                Console.Write("How many stocks do you want to sell? ");
                if (int.TryParse(Console.ReadLine(), out int qty))
                {
                    if (qty <= stock)
                    {
                        int revenue = qty * stockPrice;
                        cash += revenue;
                        stock -= qty;
                        Console.WriteLine($"Sold {qty} stocks for ${revenue}.\n");
                    }
                    else
                    {
                        Console.WriteLine("You don't have that many stocks.\n");
                    }
                }
                else
                {
                    Console.WriteLine("Invalid quantity.\n");
                }
            }
            else if (input == "exit")
            {
                Console.WriteLine("Exiting the trading system. Final holdings:");
                Console.WriteLine($"Cash: ${cash}");
                Console.WriteLine($"Stocks: {stock}");
                Console.WriteLine($"Total value: ${cash + (stock * stockPrice)}");
                break;
            }
            else
            {
                Console.WriteLine("Invalid command. Please enter buy, sell, or exit.\n");
            }

            Console.WriteLine();
        }
    }
}