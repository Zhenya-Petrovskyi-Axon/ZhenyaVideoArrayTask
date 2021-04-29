//
//  MainViewModel.swift
//  UsersYouTubeVideoLibrary
//
//  Created by Evhen Petrovskyi on 29.04.2021.
//

import Foundation

// MARK: - Main protocols
protocol MainViewModelProtocol {
//    func setLinks()
    func saveLink(link: String)
}

class MainViewModel: MainViewModelProtocol {
    
    private(set) var links: [Link] = [] {
        didSet {
            self.didGetLinks()
        }
    }
    
    public var linksCount: Int {
        return links.count
    }
    
    init() { }
    
    // MARK: - Bind data
    var didGetLinks: (() -> Void) = { }
    
    func setLinks() {
    }
    
    func saveLink(link: String) {
        links.append(Link(url: link))
        print("Succes in saving url: \(link)")
    }
    
}
