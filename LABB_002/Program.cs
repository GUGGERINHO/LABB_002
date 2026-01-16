

using LABB_002;
using LABB_002.Model;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Internal;

using var db = new BokhandelContext();

while (true)
{
    Console.WriteLine("\n1. List all stores and their inventory");
    Console.WriteLine("2. Add book to a store");
    Console.WriteLine("3. Delete book from a store");
    Console.WriteLine("4. Update inventory for a store");
    Console.WriteLine("0. Exit");
    var input = Console.ReadLine();
    Console.Clear();
    switch (input)
    {
        case "1":
            BokhandelOperations.ListStoresAndInventory(db);
            break;
        case "2":
            int storeId;
            while (true)
            {
                storeId = BokhandelOperations.ChooseStore(db);
                if (storeId != 0) break;
                Console.WriteLine("\nInvalid store input. try again");
            }
            string isbn;
            while (true)
            {
                isbn = BokhandelOperations.ChooseBook(db);
                if (isbn != null) break;
                Console.WriteLine("\nInvalid book input. Try again");
            }
            int quantity;
            while (true)
            {
                Console.WriteLine("\nHow many copies would you like to add?");
                if (!int.TryParse(Console.ReadLine(), out quantity) || quantity < 0)
                {
                    Console.WriteLine("\nInvalid quantity input. Try again");
                    continue;
                }
                break;
            }
            BokhandelOperations.AddBookToStore(db, storeId, isbn, quantity);
            break;
        case "3":
            int storeId2;
            while (true)
            {
                storeId2 = BokhandelOperations.ChooseStore(db);
                if (storeId2 != 0) break;
                Console.WriteLine("\nInvalid store input. Try again");
            }
            string isbn2;
            while(true)
            {
                isbn2 = BokhandelOperations.ChooseBook(db);
                if (isbn2 != null) break;
                Console.WriteLine("\nInvalid book input. Try again");
            }
            BokhandelOperations.DeleteBookFromStore(db, storeId2, isbn2);
            break;
        case "4":
            int storeId3;
            while (true)
            {
                storeId3 = BokhandelOperations.ChooseStore(db);
                if (storeId3 != 0) break;
                Console.WriteLine("\nInvalid store input. Try again");
            }
            string isbn3;
            while (true)
            {
                isbn3 = BokhandelOperations.ChooseBook(db);
                if (isbn3 != null) break;
                Console.WriteLine("\nInvalid book input. Try again");
            }
            int quantity2;
            while (true)
            {
                Console.WriteLine("\nWhat should the new quantity be?");
                string quantInput = Console.ReadLine();
                if (!int.TryParse(quantInput, out quantity2))
                {
                    Console.WriteLine("\nInvalid quantity input. Try again");
                    continue;
                }
                if(quantity2 < 0)
                {
                    Console.WriteLine("\nQuantity cannot be negative. Try again");
                    continue;
                }
                break;
            }
            BokhandelOperations.UpdateBookQuantity(db, storeId3, isbn3, quantity2);
            break;
        case "0": 
            Console.WriteLine("\nExiting app..."); 
            return; 
        default: 
            Console.WriteLine("\nInvalid menu option");
            break;
    }
}