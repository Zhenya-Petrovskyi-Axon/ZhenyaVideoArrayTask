//
//  MainViewModel.swift
//  UsersYouTubeVideoLibrary
//
//  Created by Evhen Petrovskyi on 29.04.2021.
//

import UIKit
import CoreData

// MARK: - Main protocols
protocol MainViewModelProtocol {
    var onError: (String) -> Void { get set }
    var linksCount: Int { get }
    var didGetLinks: () -> Void { get set }
    func viewModelForCell(_ indexPath: IndexPath) -> CellViewModel
    func getLinks()
    func removeLink(_ indexPath: IndexPath)
    func videoUrl(at indexPath: IndexPath) -> String
}

// MARK: - MainVC Model
class MainViewModel: MainViewModelProtocol {
    
    private var service: LinkDataServiceProtocol!
    
    private(set) var arrayOfLinks: [Link] = [] {
        didSet {
            didGetLinks()
        }
    }
    
    // MARK: - Array capacity counter
    var linksCount: Int { arrayOfLinks.count }
    
    // MARK: - Bind data
    var didGetLinks = { }
    
    // MARK: - Use to show an alert description
    var onError: (String) -> Void = { _ in }
    
    init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        service = CoreDataLinkService(context: context)
        getLinks()
    }
    
    // MARK: - Sort links in alphabetical order
    func sortLinks() {
        arrayOfLinks.sort(by: { $0.title < $1.title })
    }
    
    // MARK: - Refresh view
    func getLinks() {
        service.getLinks { links in
            switch links {
            case .failure(let error):
                switch error {
                case .fetchingDataFailed:
                    onError("Failed to fetch link's")
                }
            case .success(let links):
                self.arrayOfLinks = links
                sortLinks()
            }
        }
    }
    
    // MARK: - Remove link data from LinkCoreData
    func removeLink(_ indexPath: IndexPath) {
        let id = arrayOfLinks[indexPath.row].id
        do {
            try service.removeLink(id: id)
        } catch let error {
            onError("Failed to remove link due to \(error.localizedDescription)")
        }
    }
    
    // MARK: - Get Video URL
    func videoUrl(at indexPath: IndexPath) -> String {
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
