//
//  CoreDataLinkService.swift
//  UsersYouTubeVideoLibrary
//
//  Created by Evhen Petrovskyi on 05.05.2021.
//

import UIKit
import CoreData

// MARK: - Main Coredata service
class CoreDataLinkService: LinkDataServiceProtocol {
    
    private let context: NSManagedObjectContext!
    
    private let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    // MARK: - Save link to core data
    func saveLink(urlString: String, title: String) {
        
        let entity = NSEntityDescription.entity(forEntityName: "LinkCoreData", in: context)!
        let url = NSManagedObject(entity: entity, insertInto: context)
        
        url.setValue(urlString, forKeyPath: "urlString")
        url.setValue(title, forKey: "title")
        url.setValue(UUID().uuidString, forKey: "identifier")
        
        do {
            try context.save()
            print("Success in saving \(url)")
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - Get links from core Data
    func getLinks(completion: (([Link]) -> Void)) {
        
        let fetchRequest =
            NSFetchRequest<LinkCoreData>(entityName: "LinkCoreData")
        
        do {
            let result = try context.fetch(fetchRequest).map { Link(id: $0.identifier, urlString: $0.urlString, title: $0.title) }
            print(result.first ?? "Did get empty data in succeeded request")
            completion(result)
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - Remove links from core data
    func removeLink(id: String) {
        
        let fetchRequest = NSFetchRequest<LinkCoreData>(entityName: "LinkCoreData")
        fetchRequest.predicate = NSPredicate.init(format: "identifier==\(id)")
        
        do {
            if let result = try? context.fetch(fetchRequest) {
                for object in result {
                    context.delete(object)
                }
            }
            
            try context.save()
            
        } catch let error as NSError {
            print("Unable to delete with error - \(error.localizedDescription)")
        }
    }
    
    
}