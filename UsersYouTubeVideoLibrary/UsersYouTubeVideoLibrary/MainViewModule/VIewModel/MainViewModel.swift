//
//  MainViewModel.swift
//  UsersYouTubeVideoLibrary
//
//  Created by Evhen Petrovskyi on 29.04.2021.
//

import UIKit
import CoreData

// Mark: - Core data link service protocol
protocol LinkDataServiceProtocol {
    func saveLink(link: String)
    func getLinks(completion: (([Link]) -> Void))
    func removeLink(id: String)
}

// MARK: - Main protocols
protocol MainViewModelProtocol {
//    func saveLink(link: String)
//    func getLinksFromCoreData()
}

// MARK: - MainVC Model
class MainViewModel: MainViewModelProtocol {
    
    private var urlCoreDataArray: [NSManagedObject] = []
    
    private(set) var links: [Link] = [] {
        didSet {
            self.didGetLinks()
        }
    }
    
    // MARK: - Array capacity counter
    public var linksCount: Int {
        return links.count
    }
    
    init() { }
    
    // MARK: - Bind data
    var didGetLinks: (() -> Void) = { }
    
    // MARK: - Bind to set-up Cell
    func viewModelForCell(_ indexPath: IndexPath) -> CellViewModel {
        let video = links[indexPath.row].url
        return CellViewModel(cellModel: CellModel(videoLink: video))
    }
    
    // MARK: - Save link to core data
    func saveToCoreData(url: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "URL", in: managedContext)!
        let url = NSManagedObject(entity: entity, insertInto: managedContext)
        url.setValue(url, forKeyPath: "url")
        
        do {
            try managedContext.save()
            urlCoreDataArray.append(url)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}
