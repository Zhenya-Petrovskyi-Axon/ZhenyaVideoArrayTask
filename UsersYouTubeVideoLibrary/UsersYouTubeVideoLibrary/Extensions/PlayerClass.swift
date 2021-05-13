////
////  PlayerClass.swift
////  UsersYouTubeVideoLibrary
////
////  Created by Evhen Petrovskyi on 13.05.2021.
////
//
//import AVKit
//
//protocol VideoPlayerProtocol{
//    func play(_ view: UIViewController,_ url: String)
//}
//
//class VideoPlayer: VideoPlayerProtocol {
//    let playerViewController = AVPlayerViewController()
//    func play(_ view: UIViewController,_ url: String) {
//        guard let urlToPlay = URL(string: url) else {
//            view.showAlert(text: "Url is invalid")
//            return
//        }
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(playerItemDidReachEnd),
//                                               name: .AVPlayerItemDidPlayToEndTime,
//                                               object: nil)
//        let player = AVPlayer(url: urlToPlay)
//        playerViewController.player = player
//        view.present(playerViewController, animated: true) {
//            self.playerViewController.player?.play()
//        }
//    }
//    @objc func playerItemDidReachEnd(notification: NSNotification) {
//        playerViewController.player?.seek(to: CMTime.zero)
//        playerViewController.player?.play()
//    }
//}
