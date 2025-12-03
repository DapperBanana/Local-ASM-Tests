// This C# code simulates a basic text-based RPG game that could be inspired by 6502 Assembly logic.
// It demonstrates game flow, player choices, simple combat, and game state management.
// Note: The code is written in C# for ease of understanding and execution, mimicking a text-based RPG.

using System;

class BasicTextRPG
{
    static int playerHP = 100;
    static int enemyHP = 50;
    static int playerAttack = 20;
    static int enemyAttack = 10;
    static Random rand = new Random();

    static void Main()
    {
        Console.WriteLine("Welcome to the Text-Based RPG!");

        bool gameRunning = true;

        while (gameRunning)
        {
            Console.WriteLine("\nA wild enemy appears!");
            enemyHP = 50; // Reset enemy HP for each encounter
            
            // Fight loop
            while (enemyHP > 0 && playerHP > 0)
            {
                Console.WriteLine($"\nYour HP: {playerHP}");
                Console.WriteLine($"Enemy HP: {enemyHP}");
                Console.WriteLine("Choose an action:");
                Console.WriteLine("1. Attack");
                Console.WriteLine("2. Run");
                Console.Write("Enter choice: ");
                string choice = Console.ReadLine();

                if (choice == "1")
                {
                    // Player attacks
                    int damageToEnemy = playerAttack + rand.Next(0, 6);
                    enemyHP -= damageToEnemy;
                    Console.WriteLine($"You dealt {damageToEnemy} damage to the enemy!");

                    if (enemyHP <= 0)
                    {
                        Console.WriteLine("Enemy defeated!");
                        break;
                    }

                    // Enemy attacks
                    int damageToPlayer = enemyAttack + rand.Next(0, 4);
                    playerHP -= damageToPlayer;
                    Console.WriteLine($"Enemy dealt {damageToPlayer} damage to you!");

                    if (playerHP <= 0)
                    {
                        Console.WriteLine("You have been defeated...");
                        gameRunning = false;
                        break;
                    }
                }
                else if (choice == "2")
                {
                    // Running away
                    Console.WriteLine("You run away safely.");
                    break;
                }
                else
                {
                    Console.WriteLine("Invalid choice. Try again.");
                }
            }

            if (playerHP <= 0)
            {
                Console.WriteLine("Game Over!");
                break;
            }

            // Post-battle options
            Console.WriteLine("\nWhat would you like to do next?");
            Console.WriteLine("1. Continue fighting");
            Console.WriteLine("2. Exit game");
            Console.Write("Enter choice: ");
            string nextChoice = Console.ReadLine();

            if (nextChoice == "2")
            {
                Console.WriteLine("Thanks for playing!");
                gameRunning = false;
            }
            // else, continue loop for next fight
        }

        Console.WriteLine("Game ended. Goodbye!");
    }
}