//
//  PopupViewModel.swift
//  UsersYouTubeVideoLibrary
//
//  Created by Evhen Petrovskyi on 05.05.2021.
//

import UIKit
import CoreData

enum URLValidationError: Error {
    case urlIsNotValid
}

protocol PopupViewModelProtocol {
    var onError: (String) -> Void { get set }
    func saveLink(urlString: String, title: String)
    func isUrlValid(url: String?) -> Bool
}

class PopupViewModel {
    
    private let service: LinkDataServiceProtocol!
    
    private let regexURLCondition = "(?i)https?://(?:www\\.)?\\S+(?:/|\\b)"
    
    init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        service = CoreDataLinkService(context: context)
    }
    
    // MARK: - Save link to core data & main array
    func saveLink(urlString: String, title: String) throws {
        guard isValid(urlString) else {
            throw URLValidationError.urlIsNotValid
        }
        try service.saveLink(urlString: urlString, title: title)
    }
    
    // MARK: - URL Validation
    func isValid(_ url: String?) -> Bool {
        let predicate = NSPredicate(format:"SELF MATCHES %@", regexURLCondition)
        return predicate.evaluate(with: url)
    }
    
}
