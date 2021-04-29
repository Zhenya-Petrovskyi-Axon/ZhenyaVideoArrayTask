//
//  MainViewModel.swift
//  UsersYouTubeVideoLibrary
//
//  Created by Evhen Petrovskyi on 29.04.2021.
//

import Foundation

// MARK: - Link
struct Link {
    let link: String?
}

// MARK: - Link Data
struct LinkData {
    var result: [Link]?
}

// MARK: - Main protocols
protocol MainViewModelProtocol {
//    func setLinks()
    func saveLink(link: String)
}

class MainViewModel: MainViewModelProtocol {
    
    private(set) var linkData : LinkData? {
        didSet {
            self.didGetLinks()
        }
    }
    
    public var linksCount: Int {
        return linkData?.result?.count ?? 0
    }
    
    init() {
        self.setLinks()
    }
    
    // MARK: - Bind data
    var didGetLinks: (() -> Void) = { }
    
    
    func setLinks() {
    }
    
    func saveLink(link: String) {
        linkData?.result?.append(Link(link: link))
        print(linkData?.result)
    }
    
}
