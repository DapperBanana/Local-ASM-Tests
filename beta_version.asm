using System;

class PersonalityQuiz
{
    static void Main()
    {
        Console.WriteLine("Welcome to the personality quiz!\n");

        int scoreA = 0;
        int scoreB = 0;

        // Question 1
        Console.WriteLine("Question 1: What's your favorite activity?");
        Console.WriteLine("1. Reading a book");
        Console.WriteLine("2. Going outdoors");
        Console.Write("Enter 1 or 2: ");
        string answer = Console.ReadLine();
        if (answer == "1")
            scoreA++;
        else if (answer == "2")
            scoreB++;
        else
            Console.WriteLine("Invalid input, moving on...");

        // Question 2
        Console.WriteLine("\nQuestion 2: Which color do you prefer?");
        Console.WriteLine("1. Blue");
        Console.WriteLine("2. Red");
        Console.Write("Enter 1 or 2: ");
        answer = Console.ReadLine();
        if (answer == "1")
            scoreA++;
        else if (answer == "2")
            scoreB++;
        else
            Console.WriteLine("Invalid input, moving on...");

        // Question 3
        Console.WriteLine("\nQuestion 3: What's your favorite time of day?");
        Console.WriteLine("1. Morning");
        Console.WriteLine("2. Night");
        Console.Write("Enter 1 or 2: ");
        answer = Console.ReadLine();
        if (answer == "1")
            scoreA++;
        else if (answer == "2")
            scoreB++;
        else
            Console.WriteLine("Invalid input, moving on...");

        // Determine personality
        Console.WriteLine("\nCalculating your personality type...");
        if (scoreA >= 2)
            Console.WriteLine("You are an Introvert!");
        else if (scoreB >= 2)
            Console.WriteLine("You are an Extrovert!");
        else
            Console.WriteLine("You have a balanced personality!");

        Console.WriteLine("\nThank you for taking the quiz!");
    }
}