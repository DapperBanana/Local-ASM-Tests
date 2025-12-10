using System;
using System.Collections.Generic;

class InventorySystem
{
    class Item
    {
        public string Name { get; set; }
        public int Quantity { get; set; }

        public Item(string name, int quantity)
        {
            Name = name;
            Quantity = quantity;
        }
    }

    static List<Item> inventory = new List<Item>();

    static void Main()
    {
        bool running = true;
        while (running)
        {
            Console.WriteLine("\nInventory Management System");
            Console.WriteLine("1. Add Item");
            Console.WriteLine("2. Remove Item");
            Console.WriteLine("3. Display Inventory");
            Console.WriteLine("4. Exit");
            Console.Write("Select an option: ");
            var choice = Console.ReadLine();

            switch (choice)
            {
                case "1":
                    AddItem();
                    break;
                case "2":
                    RemoveItem();
                    break;
                case "3":
                    DisplayInventory();
                    break;
                case "4":
                    running = false;
                    break;
                default:
                    Console.WriteLine("Invalid selection. Try again.");
                    break;
            }
        }
    }

    static void AddItem()
    {
        Console.Write("Enter item name: ");
        string name = Console.ReadLine();
        Console.Write("Enter quantity: ");
        if (int.TryParse(Console.ReadLine(), out int qty) && qty > 0)
        {
            var existingItem = inventory.Find(item => item.Name.Equals(name, StringComparison.OrdinalIgnoreCase));
            if (existingItem != null)
            {
                existingItem.Quantity += qty;
                Console.WriteLine($"Updated {name} quantity to {existingItem.Quantity}.");
            }
            else
            {
                inventory.Add(new Item(name, qty));
                Console.WriteLine($"Added {name} with quantity {qty}.");
            }
        }
        else
        {
            Console.WriteLine("Invalid quantity.");
        }
    }

    static void RemoveItem()
    {
        Console.Write("Enter item name to remove: ");
        string name = Console.ReadLine();
        var item = inventory.Find(i => i.Name.Equals(name, StringComparison.OrdinalIgnoreCase));
        if (item != null)
        {
            Console.Write("Enter quantity to remove: ");
            if (int.TryParse(Console.ReadLine(), out int qty) && qty > 0)
            {
                if (qty >= item.Quantity)
                {
                    inventory.Remove(item);
                    Console.WriteLine($"{name} removed from inventory.");
                }
                else
                {
                    item.Quantity -= qty;
                    Console.WriteLine($"{qty} removed. {name} now has {item.Quantity}.");
                }
            }
            else
            {
                Console.WriteLine("Invalid quantity.");
            }
        }
        else
        {
            Console.WriteLine($"Item '{name}' not found.");
        }
    }

    static void DisplayInventory()
    {
        Console.WriteLine("\nCurrent Inventory:");
        if (inventory.Count == 0)
        {
            Console.WriteLine("Inventory is empty.");
        }
        else
        {
            foreach (var item in inventory)
            {
                Console.WriteLine($"{item.Name} - Quantity: {item.Quantity}");
            }
        }
    }
}