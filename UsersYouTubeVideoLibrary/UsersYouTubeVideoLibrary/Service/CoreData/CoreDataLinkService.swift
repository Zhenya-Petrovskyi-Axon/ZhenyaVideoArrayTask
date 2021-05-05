//
//  CoreDataLinkService.swift
//  UsersYouTubeVideoLibrary
//
//  Created by Evhen Petrovskyi on 05.05.2021.
//

import UIKit
import CoreData

class CoreDataLinkService: LinkDataServiceProtocol {
    
    private let context: NSManagedObjectContext!
    
    private let appDelegate =
        UIApplication.shared.delegate as? AppDelegate
    
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
    
    func getLinks(completion: (([Link]) -> Void)) {
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "LinkCoreData")
        
        do {
            let result = try context.fetch(fetchRequest) as? [Link] ?? []
            print(result)
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    
    func removeLink(id: String) {
        
    }
}
