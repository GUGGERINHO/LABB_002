

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
            int storeId = BokhandelOperations.ChooseStore(db);
            if(storeId == 0)
            {
                Console.WriteLine("\nInvalid store input");
                break;
            }
            string isbn = BokhandelOperations.ChooseBook(db);
            if(isbn == null)
            {
                Console.WriteLine("\nInvalid book input");
                break;
            }
            Console.WriteLine("\nHow many copies would you like to add?");
            if(!int.TryParse(Console.ReadLine(), out int quantity))
            {
                Console.WriteLine("\nInvalid quantity input");
                break;
            }
            BokhandelOperations.AddBookToStore(db, storeId, isbn, quantity);
            break;
        case "3":
            int storeId2 = BokhandelOperations.ChooseStore(db);
            if (storeId2 == 0)
            {
                Console.WriteLine("\nInvalid store input");
                break;
            }
            string isbn2 = BokhandelOperations.ChooseBook(db);
            if(isbn2 == null)
            {
                Console.WriteLine("\nInvalid book input");
            }
            BokhandelOperations.DeleteBookFromStore(db, storeId2, isbn2);
            break;
        case "4":
            int storeId3 = BokhandelOperations.ChooseStore(db);
            if (storeId3 == 0)
            {
                Console.WriteLine("\nInvalid store input");
                break;
            }
            string isbn3 = BokhandelOperations.ChooseBook(db);
            if (isbn3 == null)
            {
                Console.WriteLine("\nInvalid book input");
                break;
            }
            Console.WriteLine("\nWhat should the new quantity be?");
            if (!int.TryParse(Console.ReadLine(), out int quantity2))
            {
                Console.WriteLine("\nInvalid quantity input");
                break;
            }
            else if(quantity2 < 0)
            {
                Console.WriteLine("\nQuantity cannot be negative");
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