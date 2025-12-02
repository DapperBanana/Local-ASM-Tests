using System;
using System.IO;
using System.Xml;

class XmlValidator
{
    public static bool IsValidXmlWithDtd(string xmlString)
    {
        try
        {
            // Create an XmlReaderSettings object with DTD processing enabled
            XmlReaderSettings settings = new XmlReaderSettings
            {
                DtdProcessing = DtdProcessing.Parse,
                ValidationType = ValidationType.None, // No schema validation, only DTD parsing
                IgnoreComments = true,
                IgnoreProcessingInstructions = true,
                IgnoreWhitespace = true,
            };

            // Use StringReader to read the XML string
            using (StringReader stringReader = new StringReader(xmlString))
            using (XmlReader reader = XmlReader.Create(stringReader, settings))
            {
                // Parse the XML document
                while (reader.Read()) { }
            }
            // If parsing succeeds without exceptions, XML with DTD is valid
            return true;
        }
        catch (XmlException)
        {
            // XML is invalid or DTD is not correctly processed
            return false;
        }
    }

    static void Main()
    {
        string xmlWithDtd = @"<?xml version=""1.0""?>
            <!DOCTYPE note [
                <!ELEMENT note (to, from, heading, body)>
                <!ELEMENT to (#PCDATA)>
                <!ELEMENT from (#PCDATA)>
                <!ELEMENT heading (#PCDATA)>
                <!ELEMENT body (#PCDATA)>
            ]>
            <note>
                <to>User</to>
                <from>AI</from>
                <heading>Reminder</heading>
                <body>Check if this XML is valid with DTD.</body>
            </note>";

        bool isValid = IsValidXmlWithDtd(xmlWithDtd);
        Console.WriteLine($"Is the XML document valid with DTD? {isValid}");
    }
}