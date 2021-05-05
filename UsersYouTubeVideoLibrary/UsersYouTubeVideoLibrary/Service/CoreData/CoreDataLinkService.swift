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
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    // MARK: - Save link to core data
    func saveLink(link: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "LinkCoreData", in: context)!
        let url = NSManagedObject(entity: entity, insertInto: context)
        url.setValue(link, forKeyPath: "urlString")
        
        do {
            try context.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getLinks(completion: (([Link]) -> Void)) {
        
    }
    
    func removeLink(id: String) {
        
    }
}
