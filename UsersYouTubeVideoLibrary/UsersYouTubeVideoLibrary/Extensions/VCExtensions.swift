//
//  PlayerClass.swift
//  UsersYouTubeVideoLibrary
//
//  Created by Evhen Petrovskyi on 07.05.2021.
//

import UIKit
import AVKit

protocol Replayable {
    func playerItemDidReachEnd(vc: AVPlayerViewController, notification: NSNotification)
}

extension Replayable {
    func playerItemDidReachEnd(vc: AVPlayerViewController, notification: NSNotification) {
        vc.player?.seek(to: CMTime.zero)
        vc.player?.play()
    }
}

// MARK: - Use with all UIVIewController Extensions needed
extension UIViewController: Replayable {
    func playVideo(_ url: String) {
        guard let urlToPlay = URL(string: url) else {
            self.showAlert(text: "Url is invalid")
            return
        }
        let player = AVPlayer(url: urlToPlay)
        let vc = AVPlayerViewController()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: nil)
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
