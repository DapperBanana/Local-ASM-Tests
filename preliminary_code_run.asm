class Program
{
    // Define a linked list node
    class ListNode
    {
        public int Data;
        public ListNode Next;

        public ListNode(int data)
        {
            Data = data;
            Next = null;
        }
    }

    static void Main()
    {
        // Initialize the linked list
        ListNode head = null;

        // Simulate adding nodes (like Assembly linked list build)
        head = AddNode(head, 10);
        head = AddNode(head, 20);
        head = AddNode(head, 30);

        // Traverse the list and print data
        TraverseList(head);
    }

    static ListNode AddNode(ListNode head, int data)
    {
        // Create a new node
        ListNode newNode = new ListNode(data);

        if (head == null)
        {
            // List is empty, new node becomes head
            return newNode;
        }
        else
        {
            // Traverse to the end and add the new node
            ListNode current = head;
            while (current.Next != null)
            {
                current = current.Next;
            }
            current.Next = newNode;
            return head;
        }
    }

    static void TraverseList(ListNode head)
    {
        ListNode current = head;
        while (current != null)
        {
            System.Console.WriteLine($"Node Data: {current.Data}");
            current = current.Next;
        }
    }
}