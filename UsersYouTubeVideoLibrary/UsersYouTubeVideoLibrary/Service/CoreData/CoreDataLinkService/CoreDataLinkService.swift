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
    
    let entityName = "LinkCoreData"
    
    private let context: NSManagedObjectContext!
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    // MARK: - Save link to core data
    func saveLink(urlString: String, title: String) throws {
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)!
        let url = NSManagedObject(entity: entity, insertInto: context)
        url.setValue(urlString, forKeyPath: "urlString")
        url.setValue(title, forKey: "title")
        url.setValue(UUID().uuidString, forKey: "identifier")
        do {
            try context.save()
            print("Success in saving \(urlString)")
        } catch let error as NSError {
            throw error
        }
    }
    
    // MARK: - Get links from core Data
    func getLinks(completion: ([Link]) -> Void) throws {
        let fetchRequest = NSFetchRequest<LinkCoreData>(entityName: entityName)
        do {
            let result = try context.fetch(fetchRequest).map { Link(id: $0.identifier, urlString: $0.urlString, title: $0.title) }
            try context.save()
            completion(result)
        } catch let error as NSError {
            throw error
        }
    }
    
    // MARK: - Remove links from core data
    func removeLink(id: String) {
        let fetchRequest = NSFetchRequest<LinkCoreData>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "identifier = %@", "\(id)")
        do {
            let fetchedResults = try context.fetch(fetchRequest)
            for entity in fetchedResults {
                context?.delete(entity)
                print(entity.urlString, "- is deleted from LinkCoreData")
            }
            try context.save()
        } catch let error as NSError {
            print("Unable to delete with error - \(error.localizedDescription)")
        }
    }
    
    
}
