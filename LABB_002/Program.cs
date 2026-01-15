

using LABB_002.Model;

using var db = new BokhandelContext();

foreach  (var book in db.Books)
{
    Console.WriteLine($"{book.Title}");
}
