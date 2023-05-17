using System.Text.Json.Nodes;
using System.Text.Json;
using System.IO;

internal static class Program
{
    static void Main(string[] args)
    {
        StreamReader file = File.OpenText(args[0]);
        string jsonString = (file.ReadToEnd());
        // var nodeOpts = new JsonNodeOptions {PropertyNameCaseInsensitive }
        JsonNode doc = JsonNode.Parse(jsonString);
        var opts = new JsonSerializerOptions
        {
            WriteIndented = true,
            ReadCommentHandling = JsonCommentHandling.Allow,
            AllowTrailingCommas = true
        };
        Console.WriteLine(doc.ToJsonString(opts));
    }
}
