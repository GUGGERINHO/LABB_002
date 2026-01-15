

using LABB_002.Model;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Internal;

using var db = new BokhandelContext();

var stores = db.Stores.ToList();

foreach  (var store in stores)
{
    Console.WriteLine($"Store: {store.Name}");

    var storeInventory = db.Inventories
        .Where(i => i.StoreId == store.Id)
        .Join(
            db.Books,
            i => i.Isbn13,
            b => b.Isbn13,
            (i, b) => new { Book = b, i.Quantity }
        )
        .ToList();

    foreach (var item in storeInventory)
    {
        Console.WriteLine($"{item.Book.Title} | Quantity: {item.Quantity}");
    }
    Console.WriteLine();
}
