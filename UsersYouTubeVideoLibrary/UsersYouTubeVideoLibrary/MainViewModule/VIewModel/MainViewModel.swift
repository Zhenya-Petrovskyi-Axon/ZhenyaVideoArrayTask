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
    func getLinks()
    func removeLink(at indexPath: IndexPath)
}

// MARK: - MainVC Model
class MainViewModel: MainViewModelProtocol {
    
    var service: LinkDataServiceProtocol!
    
    private(set) var arrayOfLinks: [Link] = [] {
        didSet {
            didGetLinks()
        }
    }
    
    // MARK: - Array capacity counter
    public var linksCount: Int { arrayOfLinks.count }
    
    // MARK: - Bind data
    var didGetLinks = { }
    
    init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        service = CoreDataLinkService(context: context)
        getLinks()
    }
    
    // MARK: - Refresh view
    func getLinks() {
        service.getLinks { links in
            self.arrayOfLinks = links
        }
    }
    
    // MARK: - Remove link data from LinkCoreData
    func removeLink(at indexPath: IndexPath) {
        let id = arrayOfLinks[indexPath.row].id
        service.removeLink(id: id)
    }
    
    // MARK: - Bind to set-up Cell
    func viewModelForCell(_ indexPath: IndexPath) -> CellViewModel {
        let url = arrayOfLinks[indexPath.row].urlString
        let id = arrayOfLinks[indexPath.row].id
        let title = arrayOfLinks[indexPath.row].title
        return CellViewModel(cellModel: CellModel(id: id, urlString: url, title: title))
    }
}
