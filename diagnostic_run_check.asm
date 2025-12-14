using MongoDB.Bson;
using MongoDB.Driver;
using System;
using System.Collections.Generic;

namespace MongoDBExample
{
    class Program
    {
        static void Main(string[] args)
        {
            // Connection string to MongoDB server
            var connectionString = "mongodb://localhost:27017";

            // Create a client and connect to the server
            var client = new MongoClient(connectionString);

            // Get a reference to the database
            var database = client.GetDatabase("testdb");

            // Get a reference to the collection
            var collection = database.GetCollection<BsonDocument>("testcollection");

            // CREATE: Insert a new document
            var newDocument = new BsonDocument
            {
                { "name", "Alice" },
                { "age", 30 },
                { "city", "Wonderland" }
            };
            collection.InsertOne(newDocument);
            Console.WriteLine("Inserted document: " + newDocument);

            // READ: Find documents
            var filter = Builders<BsonDocument>.Filter.Eq("name", "Alice");
            var foundDocuments = collection.Find(filter).ToList();

            Console.WriteLine("Found documents:");
            foreach (var doc in foundDocuments)
            {
                Console.WriteLine(doc.ToJson());
            }

            // UPDATE: Update document(s)
            var updateFilter = Builders<BsonDocument>.Filter.Eq("name", "Alice");
            var updateDefinition = Builders<BsonDocument>.Update.Set("age", 31);
            var updateResult = collection.UpdateOne(updateFilter, updateDefinition);
            Console.WriteLine($"Matched {updateResult.MatchedCount} documents and modified {updateResult.ModifiedCount}.");

            // READ after update
            var updatedDocument = collection.Find(updateFilter).FirstOrDefault();
            Console.WriteLine("Updated document: " + updatedDocument?.ToJson());

            // DELETE: Remove document(s)
            var deleteFilter = Builders<BsonDocument>.Filter.Eq("name", "Alice");
            var deleteResult = collection.DeleteOne(deleteFilter);
            Console.WriteLine($"Deleted {deleteResult.DeletedCount} document(s).");
        }
    }
}