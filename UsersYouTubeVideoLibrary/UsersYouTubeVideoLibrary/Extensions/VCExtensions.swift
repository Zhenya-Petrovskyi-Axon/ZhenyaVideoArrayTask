//
//  PlayerClass.swift
//  UsersYouTubeVideoLibrary
//
//  Created by Evhen Petrovskyi on 07.05.2021.
//

import UIKit
import AVKit

// MARK: - Main Video presenter protocol
protocol VideoPresenter {
    func playVideo(_ url: String)
}

// MARK: - Playing video for UIViewcontrollers
extension VideoPresenter where Self: UIViewController {
    func playVideo(_ url: String) {
        guard let urlToPlay = URL(string: url) else {
            showAlert(text: "URl is not valid for the player")
            return
        }
        let playerVC = AVPlayerViewController()
        let player = AVPlayer(url: urlToPlay)
        playerVC.player = player
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { [ weak playerVC ] _ in
            playerVC?.player?.seek(to: CMTime.zero)
            playerVC?.player?.play()
        }
        self.present(playerVC, animated: true) {
            playerVC.player?.play()
        }
    }
}

// MARK: - Allert extension
extension UIViewController {
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
