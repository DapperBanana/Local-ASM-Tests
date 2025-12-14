using System;

class BasicChatbot
{
    static void Main()
    {
        Console.WriteLine("Welcome to the Basic Chatbot. Type 'exit' to quit.");

        while (true)
        {
            Console.Write("You: ");
            string input = Console.ReadLine().Trim().ToLower();

            if (input == "exit")
            {
                Console.WriteLine("Chatbot: Goodbye!");
                break;
            }
            else if (input.Contains("hello") || input.Contains("hi"))
            {
                Console.WriteLine("Chatbot: Hello! How can I help you today?");
            }
            else if (input.Contains("how are you"))
            {
                Console.WriteLine("Chatbot: I'm a program, so I don't have feelings, but I'm here to help!");
            }
            else if (input.Contains("name"))
            {
                Console.WriteLine("Chatbot: I'm a simple text-based bot.");
            }
            else
            {
                Console.WriteLine("Chatbot: Sorry, I didn't understand that. Can you rephrase?");
            }
        }
    }
}