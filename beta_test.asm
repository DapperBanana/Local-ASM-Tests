using System;

class EducationalQuiz
{
    static void Main()
    {
        string[] questions = {
            "What is the capital of France?",
            "What is 2 + 2?",
            "Who wrote 'Romeo and Juliet'?"
        };

        string[] answers = {
            "Paris",
            "4",
            "Shakespeare"
        };

        int score = 0;

        Console.WriteLine("Welcome to the Educational Quiz!");
        Console.WriteLine("--------------------------------\n");

        for (int i = 0; i < questions.Length; i++)
        {
            Console.WriteLine($"Question {i + 1}: {questions[i]}");
            Console.Write("Your Answer: ");
            string userAnswer = Console.ReadLine().Trim();

            if (string.Equals(userAnswer, answers[i], StringComparison.OrdinalIgnoreCase))
            {
                Console.WriteLine("Correct!\n");
                score++;
            }
            else
            {
                Console.WriteLine($"Incorrect. The correct answer is: {answers[i]}\n");
            }
        }

        Console.WriteLine($"Quiz Complete! You scored {score} out of {questions.Length}.");
        Console.WriteLine("Thank you for participating!");
    }
}