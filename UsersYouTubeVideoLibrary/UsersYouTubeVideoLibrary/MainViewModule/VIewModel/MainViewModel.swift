//
//  MainViewModel.swift
//  UsersYouTubeVideoLibrary
//
//  Created by Evhen Petrovskyi on 29.04.2021.
//

import UIKit
import CoreData

// MARK: - Show allert of handled errors to user
protocol MainViewModelDelegate: AnyObject {
    func needToShowAnAllert(text: String)
}

// MARK: - Core data link service protocol
protocol LinkDataServiceProtocol {
    func saveLink(urlString: String, title: String) throws
    func getLinks(completion: ([Link]) -> Void) throws
    func removeLink(id: String) throws
}

// MARK: - Main protocols
protocol MainViewModelProtocol {
    func viewModelForCell(_ indexPath: IndexPath) -> CellViewModel
    func getLinks()
    func removeLink(_ indexPath: IndexPath)
}

// MARK: - MainVC Model
class MainViewModel: MainViewModelProtocol {
    
    private var service: LinkDataServiceProtocol!
    
    weak var delegate: MainViewModelDelegate?
    
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
        do {
            try service.getLinks { links in
                self.arrayOfLinks = links
            }
        } catch let error as NSError {
            delegate?.needToShowAnAllert(text: "Sorry, unable to get array of links due to  \(error.localizedDescription)")
        }
    }
    
    // MARK: - Remove link data from LinkCoreData
    func removeLink(_ indexPath: IndexPath) {
        let id = arrayOfLinks[indexPath.row].id
        do {
            try service.removeLink(id: id)
        } catch let error as NSError {
            delegate?.needToShowAnAllert(text: "Sorry, unable to remove link due to \(error.localizedDescription)")
        }
    }
    
    // MARK: - Get Video URL
    func getVideoURL(at indexPath: IndexPath) -> String {
        let url = arrayOfLinks[indexPath.row].urlString
        return url
    }
    
    // MARK: - Bind to set-up Cell
    func viewModelForCell(_ indexPath: IndexPath) -> CellViewModel {
        let url = arrayOfLinks[indexPath.row].urlString
        let id = arrayOfLinks[indexPath.row].id
        let title = arrayOfLinks[indexPath.row].title
        return CellViewModel(CellModel(id: id, urlString: url, title: title))
    }
}
