using System.Text.Json;
using System.Text.Unicode;

internal static class Program
{
    static void Main(string[] args)
    {
        Stream file = File.OpenRead(args[0]);
        Stream stdout = Console.OpenStandardOutput();
        Utf8JsonWriter writer =
            new(
                stdout,
                new JsonWriterOptions
                {
                    Indented = true,
                    Encoder = System.Text.Encodings.Web.JavaScriptEncoder.Create(UnicodeRanges.All)
                }
            );
        JsonDocument
            .Parse(
                file,
                new JsonDocumentOptions
                {
                    CommentHandling = JsonCommentHandling.Skip,
                    AllowTrailingCommas = true,
                }
            )
            .WriteTo(writer);
        writer.Flush();
        // JsonNode doc = JsonNode.Parse(jsonString);
        // Console.WriteLine(doc.ToJsonString(opts));
    }
}
