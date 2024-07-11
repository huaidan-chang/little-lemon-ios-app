import CoreData
import Foundation

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ExampleDatabase")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
            //            container.viewContext.automaticallyMergesChangesFromParent = true
        }
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func clear() {
        // Delete all dishes from the store
        //        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Dish")
        //        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        //        let _ = try? container.persistentStoreCoordinator.execute(deleteRequest, with: container.viewContext)
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Dish")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try container.viewContext.execute(deleteRequest)
            try container.viewContext.save()  // Commit the deletion
            print("Data cleared successfully.")
        } catch {
            print("Failed to clear CoreData: \(error.localizedDescription)")
        }
    }
    
    func debugCheckData() {
        let fetchRequest: NSFetchRequest<Dish> = Dish.fetchRequest()
        do {
            let results = try container.viewContext.fetch(fetchRequest)
            print("Data count after clear: \(results.count)")
        } catch {
            print("Error fetching data after clear: \(error.localizedDescription)")
        }
    }
}
