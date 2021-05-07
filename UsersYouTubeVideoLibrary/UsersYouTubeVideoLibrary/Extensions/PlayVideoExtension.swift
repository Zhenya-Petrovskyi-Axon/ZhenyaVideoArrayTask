//
//  PlayerClass.swift
//  UsersYouTubeVideoLibrary
//
//  Created by Evhen Petrovskyi on 07.05.2021.
//

import UIKit
import AVKit

extension UIViewController {
    func playVideo(url: String) {
        guard let urlToPlay = URL(string: url) else {
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
