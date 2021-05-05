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
    func saveLink(urlString: String, title: String)
    func getLinks(completion: (([Link]) -> Void))
    func removeLink(id: String)
}

// MARK: - Main protocols
protocol MainViewModelProtocol {
    func viewModelForCell(_ indexPath: IndexPath) -> CellViewModel
}

// MARK: - MainVC Model
class MainViewModel: MainViewModelProtocol {
    
    let service: LinkDataServiceProtocol!
    
    public var links: [Link] = [] {
        didSet {
            self.didGetLinks()
            print("Did get links")
        }
    }
    
    // MARK: - Array capacity counter
    public var linksCount: Int {
        return links.count
    }
    
    init() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        service = CoreDataLinkService(context: context)
        service.getLinks { links in
            self.links = links
            
        }
    }
    
    // MARK: - Bind data
    var didGetLinks: (() -> Void) = { }
    
    // MARK: - Bind to set-up Cell
    func viewModelForCell(_ indexPath: IndexPath) -> CellViewModel {
        
        let url = links[indexPath.row].urlString
        let id = links[indexPath.row].id
        let title = links[indexPath.row].title
        
        return CellViewModel(cellModel: CellModel(id: id, urlString: url, title: title))
    }
}
