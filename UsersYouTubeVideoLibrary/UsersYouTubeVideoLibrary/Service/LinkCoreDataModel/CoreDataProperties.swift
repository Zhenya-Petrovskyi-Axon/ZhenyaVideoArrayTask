//
//  CoreDataProperties.swift
//  UsersYouTubeVideoLibrary
//
//  Created by Evhen Petrovskyi on 05.05.2021.
//

import Foundation
import CoreData

extension LinkCoreData {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<LinkCoreData> {
        return NSFetchRequest<LinkCoreData>(entityName: "LinkCoreData")
    }
    
    @NSManaged public var identifier: String
    @NSManaged public var title: String
    @NSManaged public var urlString: String
    
}

extension LinkCoreData: Identifiable {
    
}
