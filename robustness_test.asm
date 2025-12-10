using System;
using System.Net.Http;
using System.Threading.Tasks;

class WebScraper
{
    static async Task Main(string[] args)
    {
        string url = "https://example.com"; // Replace with target URL
        string htmlContent = await FetchPageAsync(url);
        ExtractInformation(htmlContent);
    }

    static async Task<string> FetchPageAsync(string url)
    {
        using (HttpClient client = new HttpClient())
        {
            try
            {
                // Fetch HTML content from the website
                string content = await client.GetStringAsync(url);
                return content;
            }
            catch (HttpRequestException e)
            {
                Console.WriteLine($"Error fetching the page: {e.Message}");
                return string.Empty;
            }
        }
    }

    static void ExtractInformation(string html)
    {
        if (string.IsNullOrEmpty(html))
        {
            Console.WriteLine("No HTML content to parse.");
            return;
        }

        // Example: Extract all titles enclosed in <title> tags
        string startTag = "<title>";
        string endTag = "</title>";

        int startIndex = html.IndexOf(startTag);
        int endIndex = html.IndexOf(endTag);

        if (startIndex != -1 && endIndex != -1 && endIndex > startIndex)
        {
            startIndex += startTag.Length;
            string title = html.Substring(startIndex, endIndex - startIndex);
            Console.WriteLine($"Page Title: {title}");
        }
        else
        {
            Console.WriteLine("Title tag not found.");
        }
    }
}