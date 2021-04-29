//
//  MainViewModel.swift
//  UsersYouTubeVideoLibrary
//
//  Created by Evhen Petrovskyi on 29.04.2021.
//

import Foundation

// MARK: - Main protocols
protocol MainViewModelProtocol {
    func saveLink(link: String)
}

// MARK: - MainVC Model
class MainViewModel: MainViewModelProtocol {
    
    private(set) var links: [Link] = [] {
        didSet {
            self.didGetLinks()
        }
    }
    
    // MARK: - Array capacity counter
    public var linksCount: Int {
        return links.count
    }
    
    init() {  }
    
    // MARK: - Bind data
    var didGetLinks: (() -> Void) = { }
    
    // MARK: - Used to
    func saveLink(link: String) {
        links.append(Link(url: link))
        print("Succes in saving url: \(link)")
    }
    
    // MARK: - Bind to set-up Cell
    func viewModelForCell(_ indexPath: IndexPath) -> CellViewModel {
        let video = links[indexPath.row].url
        return CellViewModel(cellModel: CellModel(videoLink: video))
    }
    
}
