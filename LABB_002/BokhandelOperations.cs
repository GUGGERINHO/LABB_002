using LABB_002.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static System.Reflection.Metadata.BlobBuilder;

namespace LABB_002
{
    public static class BokhandelOperations
    {
        public static void ListStoresAndInventory(BokhandelContext db)
        {
            var stores = db.Stores.ToList();

            foreach (var store in stores)
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
        }
        public static void UpdateBookQuantity(BokhandelContext db, int storeId, string isbn13, int newQuantity)
        {
            var item = db.Inventories
                .FirstOrDefault(i => i.StoreId == storeId && i.Isbn13 == isbn13);
            if(item != null)
            {
                item.Quantity = newQuantity;
                db.SaveChanges();
                Console.WriteLine("Quantity updated successfully");
            }
            else
            {
                Console.WriteLine("Inventory item not found");
            }
        }
        public static void AddBookToStore(BokhandelContext db, int storeId, string isbn13, int quantity)
        {
            var existing = db.Inventories
                .FirstOrDefault(i => i.StoreId == storeId && i.Isbn13 == isbn13);
            if(existing != null)
            {
                existing.Quantity += quantity;
                Console.WriteLine("Quantity updated successfully");
            }
            else
            {
                db.Inventories.Add(new Inventory
                {
                    StoreId = storeId,
                    Isbn13 = isbn13,
                    Quantity = quantity
                });
                Console.WriteLine("Book added successfully");
            }
            db.SaveChanges();
        }
        public static void DeleteBookFromStore(BokhandelContext db, int storeId, string isbn13)
        {
            var item = db.Inventories
                .FirstOrDefault(i=> i.StoreId == storeId&& i.Isbn13 == isbn13);
            if(item != null)
            {
                db.Inventories.Remove(item);
                db.SaveChanges();
                Console.WriteLine("Book removed successfully");
            }
            else
            {
                Console.WriteLine("Inventory item not found");
            }
        }
        public static string ChooseBook(BokhandelContext db)
        {
            var books = db.Books.ToList();

            Console.WriteLine("\nWhich book: ");
            for (int i = 0; i < books.Count; i++)
            {
                Console.WriteLine($"{i + 1}. {books[i].Title}");
            }
            if(!int.TryParse(Console.ReadLine(), out int choice) || choice < 1 || choice > books.Count)
            {
                return null;
            }
            return books[choice - 1].Isbn13;
        }
        public static int ChooseStore(BokhandelContext db)
        {
            var stores = db.Stores.ToList();
            int i = 1;
            Console.WriteLine("Which store?");
            foreach (var store in stores)
            {
                Console.WriteLine($"{i}. {store.Name}");
                i++;
            }
            if (!int.TryParse(Console.ReadLine(), out int choice) || choice < 1 || choice > stores.Count)
            {
                return 0;
            }
            else
            {
                return stores[choice - 1].Id;
            }
        }
    }
}
