//
//  PopupViewModel.swift
//  UsersYouTubeVideoLibrary
//
//  Created by Evhen Petrovskyi on 05.05.2021.
//

import UIKit
import CoreData

class PopupViewModel {
    
    private let service: LinkDataServiceProtocol!
    
    private let regexURLCondition = "(http(s)?:\\/\\/)?(www\\.|m\\.)?youtu(be\\.com|\\.be)(\\/watch\\?([&=a-z]{0,})(v=[\\d\\w]{1,}).+|\\/[\\d\\w]{1,})"
    
    init() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        service = CoreDataLinkService(context: context)
    }
    
    func saveLink(urlString: String, title: String) {
        service.saveLink(urlString: urlString, title: urlString)
    }
    
    // MARK: - URL Validation
    func isUrlValid(url: String?) -> Bool {
        let predicate = NSPredicate(format:"SELF MATCHES %@", regexURLCondition)
        return predicate.evaluate(with: url)
    }
    
}
