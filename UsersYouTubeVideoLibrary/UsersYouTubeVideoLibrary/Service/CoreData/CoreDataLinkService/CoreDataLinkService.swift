//
//  CoreDataLinkService.swift
//  UsersYouTubeVideoLibrary
//
//  Created by Evhen Petrovskyi on 05.05.2021.
//

import UIKit
import CoreData

enum CoreDataError: Error {
    case fetchingDataFailed
}

// MARK: - Core data link service protocol
protocol LinkDataServiceProtocol {
    func saveLink(urlString: String, title: String) throws
    func getLinks(completion: (Result<[Link], CoreDataError>) -> Void)
    func removeLink(id: String) throws
}

// MARK: - Main Coredata service
class CoreDataLinkService: LinkDataServiceProtocol {
    
    private let context: NSManagedObjectContext!
    
    private let entityName = "LinkCoreData"
    
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
        try context.save()
    }
    
    // MARK: - Get links from core Data
    func getLinks(completion: (Result<[Link], CoreDataError>) -> Void) {
        let fetchRequest = NSFetchRequest<LinkCoreData>(entityName: entityName)
        do {
            let result = try context.fetch(fetchRequest).map ({ Link(id: $0.identifier, urlString: $0.urlString, title: $0.title) })
            completion(.success(result))
        } catch {
            completion(.failure(.fetchingDataFailed))
        }
        
    }
    
    // MARK: - Remove links from core data
    func removeLink(id: String) throws {
        let fetchRequest = NSFetchRequest<LinkCoreData>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "identifier = %@", "\(id)")
        let fetchedResults = try context.fetch(fetchRequest)
        for entity in fetchedResults {
            context?.delete(entity)
            print(entity.urlString, " - is deleted from LinkCoreData")
        }
        try context.save()
    }
    
    
}
