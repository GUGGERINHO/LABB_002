

using LABB_002;
using LABB_002.Model;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Internal;

using var db = new BokhandelContext();

while (true)
{
    Console.WriteLine("1. List all stores and their inventory");
    Console.WriteLine("2. Add book to a store");
    Console.WriteLine("3. Remove book from a store");
    Console.WriteLine("4. Update inventory for a store");
    Console.WriteLine("0. Exit");
    var input = Console.ReadLine();
    switch (input)
    {
        case "1":
            BokhandelOperations.ListStoresAndInventory(db);
            break;
        case "2":
            int storeId = BokhandelOperations.ChooseStore(db);
            if(storeId == 0)
            {
                Console.WriteLine("Invalid store input");
                break;
            }
            string isbn13 = BokhandelOperations.ChooseBook(db);
            if(isbn13 == null)
            {
                Console.WriteLine("Invalid book input");
                break;
            }
            Console.WriteLine("How many copies would you like to add?");
            if(!int.TryParse(Console.ReadLine(), out int quantity))
            {
                Console.WriteLine("Invalid quantity input");
                break;
            }
            BokhandelOperations.AddBookToStore(db, storeId, isbn13, quantity);
            break;
    }
}