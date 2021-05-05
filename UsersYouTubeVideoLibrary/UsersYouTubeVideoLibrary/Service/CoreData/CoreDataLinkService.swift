//
//  CoreDataLinkService.swift
//  UsersYouTubeVideoLibrary
//
//  Created by Evhen Petrovskyi on 05.05.2021.
//

import Foundation
import CoreData

class CoreDataLinkService: LinkDataServiceProtocol {
    
    private let context: NSManagedObjectContext!
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func saveLink(link: String) {
        
    }
    
    func getLinks(completion: (([Link]) -> Void)) {
        
    }
    
    func removeLink(id: String) {
        
    }
    
    
}
