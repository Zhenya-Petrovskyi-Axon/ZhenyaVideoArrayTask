//
//  PlayerClass.swift
//  UsersYouTubeVideoLibrary
//
//  Created by Evhen Petrovskyi on 07.05.2021.
//

import UIKit
import AVKit

// MARK: - Use with all UIVIewController Extensions needed
extension UIViewController {
    /// Play video from URL with UIKit
    func playVideo(_ url: String) {
        guard let urlToPlay = URL(string: url) else {
            self.showAlert(text: "Url is invalid")
            return
        }
        let player = AVPlayer(url: urlToPlay)
        let vc = AVPlayerViewController()
        vc.player = player
        self.present(vc, animated: true, completion: {
            vc.player?.play()
        })
    }
    /// Show allert to user if error occures
    func showAlert(text: String) {
        let alert  = UIAlertController(title: "Important!", message: text, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (_) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
