//
//  Model.swift


import Foundation
import CoreData
public class Model{
    let managedObjectContext:NSManagedObjectContext?
    
    init(context: NSManagedObjectContext)
    {
        managedObjectContext = context
        
        // Getting a handler to the coredata managed object context
    }
    
    func findRecord(name: String) ->NSManagedObject?
    {
        // retrun data
        var match:NSManagedObject?
        // get a handler to the contact entity
        let entityDescription =
            NSEntityDescription.entity(forEntityName: "Favorite",
                                       in: managedObjectContext!)
        // create a fetch request
        let request: NSFetchRequest<Favorite> = Favorite.fetchRequest() as! NSFetchRequest<Favorite>
        
        // associate the request with contact handler
        request.entity = entityDescription
        
        // build the search request predicate (query)
        let pred = NSPredicate(format: "(name = %@)", name)
        request.predicate = pred
        
        // perform the query and process the query results
        do {
            var results =
                try managedObjectContext!.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>)
            
            if results.count > 0 {
                 match = results[0] as! NSManagedObject
                 //return match
            } else {
                //return match
            }
            
        } catch let error {
            print(error.localizedDescription )
        }
        
        return match
        
    }
    
    func clearData()
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        // performs the batch delete for the contact
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try managedObjectContext!.execute(deleteRequest)
            try managedObjectContext!.save()
            
        }
        catch let _ as NSError {
            // Handle error
        }
        
        
    }
    func SaveContext(name: String, rating: Double)
    {
        // get a handler to the Contacts entity through the managed object context
        let ent = NSEntityDescription.entity(forEntityName: "Favorite", in: self.managedObjectContext!)
        
        // create a contact object instance for insert
        let favorite = Favorite(entity: ent!, insertInto: managedObjectContext)
        
        // add data to each field in the entity
        favorite.name = name
        favorite.rating = rating
        
        // save the new entity
        do {
            try managedObjectContext!.save()
            print("Favorite Saved")
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}

