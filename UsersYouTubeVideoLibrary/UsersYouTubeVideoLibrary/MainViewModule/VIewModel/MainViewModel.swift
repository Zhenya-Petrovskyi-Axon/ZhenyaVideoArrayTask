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
    func refresh()
}

// MARK: - MainVC Model
class MainViewModel: MainViewModelProtocol {
    
    var service: LinkDataServiceProtocol!
    
    public var arrayOfLinks: [Link] = [] {
        didSet {
            self.didGetLinks()
            print("arrayOfLinks did get updated with links from LinkCoreData")
        }
    }
    
    // MARK: - Array capacity counter
    public var linksCount: Int {
        return arrayOfLinks.count
    }
    
    init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        service = CoreDataLinkService(context: context)
        
        refresh()
    }
    
    // MARK: - Refresh view
    func refresh() {
        service.getLinks { links in
            self.arrayOfLinks = links
            
        }
    }
    
    // MARK: - Bind data
    var didGetLinks: (() -> Void) = { }
    
    // MARK: - Bind to set-up Cell
    func viewModelForCell(_ indexPath: IndexPath) -> CellViewModel {
        
        let url = arrayOfLinks[indexPath.row].urlString
        let id = arrayOfLinks[indexPath.row].id
        let title = arrayOfLinks[indexPath.row].title
        
        return CellViewModel(cellModel: CellModel(id: id, urlString: url, title: title))
    }
}
