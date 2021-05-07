//
//  PlayerClass.swift
//  UsersYouTubeVideoLibrary
//
//  Created by Evhen Petrovskyi on 07.05.2021.
//

import UIKit
import AVKit

protocol PlayerClassProtocol {
    func playVideo(view: UIViewController,url: String)
}

class PlayerClass {
    
    // MARK: - Main videoPlayer func to play video
    func playVideo(view: UIViewController,url: String) {
        
        guard let urlToPlay = URL(string: url) else {return}
        let player = AVPlayer(url: urlToPlay)
        let vc = AVPlayerViewController()
        vc.player = player
        
        view.present(vc, animated: true, completion: {
            vc.player?.play()
        })
    }
    
}
