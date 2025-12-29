using System;

class JobApplicationSystem
{
    static void Main()
    {
        // Welcome message
        Console.WriteLine("Welcome to the Basic Job Application System\n");

        // Collect applicant's name
        Console.Write("Enter your full name: ");
        string name = Console.ReadLine();

        // Collect applicant's age
        int age = 0;
        while (true)
        {
            Console.Write("Enter your age: ");
            string ageInput = Console.ReadLine();
            if (int.TryParse(ageInput, out age) && age > 0)
            {
                break;
            }
            Console.WriteLine("Please enter a valid positive number for age.");
        }

        // Collect applicant's desired position
        Console.Write("Enter the position you are applying for: ");
        string position = Console.ReadLine();

        // Collect applicant's skills
        Console.Write("Enter your skills (separated by commas): ");
        string skillsInput = Console.ReadLine();
        string[] skills = skillsInput.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);

        // Display the summarized application
        Console.WriteLine("\n--- Application Summary ---");
        Console.WriteLine($"Name: {name}");
        Console.WriteLine($"Age: {age}");
        Console.WriteLine($"Position: {position}");
        Console.WriteLine("Skills:");
        foreach (var skill in skills)
        {
            Console.WriteLine($"- {skill.Trim()}");
        }

        // Exit message
        Console.WriteLine("\nThank you for applying! We will review your application.");
    }
}