//
//  PlayerClass.swift
//  UsersYouTubeVideoLibrary
//
//  Created by Evhen Petrovskyi on 07.05.2021.
//

import UIKit
import AVKit

extension UIViewController {
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
}
