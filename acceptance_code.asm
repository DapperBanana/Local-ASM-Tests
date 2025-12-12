using System;
using System.Collections.Generic;

namespace PlaylistManager
{
    class Program
    {
        static List<string> playlist = new List<string>();

        static void Main(string[] args)
        {
            bool exit = false;

            Console.WriteLine("Welcome to the Text-Based Playlist Manager!");

            while (!exit)
            {
                Console.WriteLine("\nSelect an option:");
                Console.WriteLine("1. Add track");
                Console.WriteLine("2. Remove track");
                Console.WriteLine("3. View playlist");
                Console.WriteLine("4. Exit");
                Console.Write("Choice: ");
                string choice = Console.ReadLine();

                switch (choice)
                {
                    case "1":
                        AddTrack();
                        break;
                    case "2":
                        RemoveTrack();
                        break;
                    case "3":
                        ViewPlaylist();
                        break;
                    case "4":
                        exit = true;
                        Console.WriteLine("Goodbye!");
                        break;
                    default:
                        Console.WriteLine("Invalid choice. Please select 1-4.");
                        break;
                }
            }
        }

        static void AddTrack()
        {
            Console.Write("Enter track name: ");
            string track = Console.ReadLine();

            if (!string.IsNullOrWhiteSpace(track))
            {
                playlist.Add(track);
                Console.WriteLine($"'{track}' added to playlist.");
            }
            else
            {
                Console.WriteLine("Track name cannot be empty.");
            }
        }

        static void RemoveTrack()
        {
            if (playlist.Count == 0)
            {
                Console.WriteLine("Playlist is empty.");
                return;
            }

            ViewPlaylist();
            Console.Write("Enter number of track to remove: ");
            if (int.TryParse(Console.ReadLine(), out int index))
            {
                if (index >= 1 && index <= playlist.Count)
                {
                    string removed = playlist[index - 1];
                    playlist.RemoveAt(index - 1);
                    Console.WriteLine($"'{removed}' removed from playlist.");
                }
                else
                {
                    Console.WriteLine("Invalid track number.");
                }
            }
            else
            {
                Console.WriteLine("Please enter a valid number.");
            }
        }

        static void ViewPlaylist()
        {
            if (playlist.Count == 0)
            {
                Console.WriteLine("Playlist is empty.");
                return;
            }

            Console.WriteLine("\nCurrent Playlist:");
            for (int i = 0; i < playlist.Count; i++)
            {
                Console.WriteLine($"{i + 1}. {playlist[i]}");
            }
        }
    }
}