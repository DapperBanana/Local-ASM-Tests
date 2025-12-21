// Note: This C# code simulates a basic text-based fantasy sports manager
// and is modeled to illustrate core functionalities similar to a 6502 Assembly program.
// It is not actual assembly code, but a high-level analog in C# for clarity.

using System;
using System.Collections.Generic;

class FantasySportsManager
{
    // Player class to hold player info
    class Player
    {
        public string Name;
        public int Score;

        public Player(string name)
        {
            Name = name;
            Score = 0;
        }
    }

    static List<Player> team = new List<Player>();
    static Random rand = new Random();

    static void Main()
    {
        Console.WriteLine("Welcome to the Fantasy Sports Manager!");

        bool running = true;
        while (running)
        {
            Console.WriteLine("\nSelect an option:");
            Console.WriteLine("1. Add Player");
            Console.WriteLine("2. Remove Player");
            Console.WriteLine("3. View Team");
            Console.WriteLine("4. Simulate Game Week");
            Console.WriteLine("5. Exit");

            Console.Write("Enter choice: ");
            string input = Console.ReadLine();

            switch (input)
            {
                case "1":
                    AddPlayer();
                    break;
                case "2":
                    RemovePlayer();
                    break;
                case "3":
                    ViewTeam();
                    break;
                case "4":
                    SimulateWeek();
                    break;
                case "5":
                    running = false;
                    Console.WriteLine("Exiting the Fantasy Sports Manager. Goodbye!");
                    break;
                default:
                    Console.WriteLine("Invalid choice. Please select again.");
                    break;
            }
        }
    }

    static void AddPlayer()
    {
        Console.Write("Enter player's name: ");
        string name = Console.ReadLine();
        if (!string.IsNullOrWhiteSpace(name))
        {
            team.Add(new Player(name));
            Console.WriteLine($"Player '{name}' added to your team.");
        }
        else
        {
            Console.WriteLine("Invalid name. Player not added.");
        }
    }

    static void RemovePlayer()
    {
        if (team.Count == 0)
        {
            Console.WriteLine("Your team is empty.");
            return;
        }

        Console.WriteLine("Current team members:");
        for (int i = 0; i < team.Count; i++)
        {
            Console.WriteLine($"{i + 1}. {team[i].Name}");
        }
        Console.Write("Enter the number of the player to remove: ");
        if (int.TryParse(Console.ReadLine(), out int index) && index >= 1 && index <= team.Count)
        {
            Console.WriteLine($"Removing {team[index - 1].Name}.");
            team.RemoveAt(index - 1);
        }
        else
        {
            Console.WriteLine("Invalid selection.");
        }
    }

    static void ViewTeam()
    {
        if (team.Count == 0)
        {
            Console.WriteLine("Your team is empty.");
            return;
        }

        Console.WriteLine("Your team:");
        foreach (var player in team)
        {
            Console.WriteLine($"{player.Name} - Score: {player.Score}");
        }
    }

    static void SimulateWeek()
    {
        if (team.Count == 0)
        {
            Console.WriteLine("Your team is empty. Add players before simulating a game week.");
            return;
        }

        Console.WriteLine("Simulating game week...");
        foreach (var player in team)
        {
            // Randomly assign scores between 0 and 20
            int weeklyScore = rand.Next(0, 21);
            player.Score += weeklyScore;
            Console.WriteLine($"{player.Name} scored {weeklyScore} points this week. Total: {player.Score}");
        }
    }
}