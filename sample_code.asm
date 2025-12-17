using System;

class Program
{
    static void Main()
    {
        // Define the questions, options, and correct answers
        string[] questions = {
            "What is the capital of France?",
            "Which planet is known as the Red Planet?",
            "What is 2 + 2?"
        };

        string[][] options = {
            new string[] { "A. Paris", "B. London", "C. Berlin", "D. Madrid" },
            new string[] { "A. Earth", "B. Mars", "C. Jupiter", "D. Saturn" },
            new string[] { "A. 3", "B. 4", "C. 5", "D. 6" }
        };

        char[] answers = { 'A', 'B', 'B' }; // Correct answers

        int score = 0;

        Console.WriteLine("Welcome to the Basic Quiz!\n");

        for (int i = 0; i < questions.Length; i++)
        {
            Console.WriteLine($"Question {i + 1}: {questions[i]}");
            foreach (var option in options[i])
            {
                Console.WriteLine(option);
            }

            Console.Write("Your answer (A-D): ");
            char userAnswer = Console.ReadLine().ToUpper()[0];

            // Validate input
            if (userAnswer < 'A' || userAnswer > 'D')
            {
                Console.WriteLine("Invalid input. Moving to next question.\n");
                continue;
            }

            if (userAnswer == answers[i])
            {
                Console.WriteLine("Correct!\n");
                score++;
            }
            else
            {
                Console.WriteLine($"Wrong! The correct answer was {answers[i]}.\n");
            }
        }

        Console.WriteLine($"Quiz complete! Your score: {score} out of {questions.Length}");
    }
}