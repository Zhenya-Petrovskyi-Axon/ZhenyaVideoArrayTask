//
//  PopupViewModel.swift
//  UsersYouTubeVideoLibrary
//
//  Created by Evhen Petrovskyi on 05.05.2021.
//

import UIKit
import CoreData

protocol PopupViewModelDelegate: AnyObject {
    func needToShowAnAllert(text: String)
}

protocol PopupViewModelProtocol {
    func saveLink(urlString: String, title: String)
    func isUrlValid(url: String?) -> Bool
}

class PopupViewModel {
    
    private let service: LinkDataServiceProtocol!
    
    weak var delegate: PopupViewModelDelegate!
    
    private let regexURLCondition = "(?i)https?://(?:www\\.)?\\S+(?:/|\\b)"
    
    init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        service = CoreDataLinkService(context: context)
    }
    
    // MARK: - Save link to core data & main array
    func saveLink(urlString: String, title: String) {
        do {
            try service.saveLink(urlString: urlString, title: title)
        }
        catch let error as NSError {
            delegate.needToShowAnAllert(text: "\(error.localizedDescription)")
        }
    }
    
    // MARK: - URL Validation
    func isUrlValid(url: String?) -> Bool {
        let predicate = NSPredicate(format:"SELF MATCHES %@", regexURLCondition)
        return predicate.evaluate(with: url)
    }
    
}
