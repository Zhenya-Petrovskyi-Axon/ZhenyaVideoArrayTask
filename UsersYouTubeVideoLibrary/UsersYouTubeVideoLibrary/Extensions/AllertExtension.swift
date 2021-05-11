//
//  Allert.swift
//  UsersYouTubeVideoLibrary
//
//  Created by Evhen Petrovskyi on 07.05.2021.
//

import UIKit

extension UIViewController {
    func showAlert(text: String) {
        let alert  = UIAlertController(title: "Important!", message: text, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (_) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
