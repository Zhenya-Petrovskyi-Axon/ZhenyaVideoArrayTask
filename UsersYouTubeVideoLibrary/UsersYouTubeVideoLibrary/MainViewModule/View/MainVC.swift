//
//  ViewController.swift
//  UsersYouTubeVideoLibrary
//
//  Created by Evhen Petrovskyi on 28.04.2021.
//

import UIKit
import AVFoundation

class MainVC: UIViewController {
    
    @IBOutlet weak var videoTableView: UITableView!
    
    let mainViewModel = MainViewModel()
    let videoPlayer = PlayerClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupDelegates()
    }
    
    // MARK: - Setup tableView delegates
    func setupDelegates() {
        videoTableView.delegate = self
        videoTableView.dataSource = self
    }
    
    // MARK: - Binding with MainViewModel
    func setupBindings() {
        self.mainViewModel.didGetLinks = { [weak self] in
            self?.updateDataSource()
        }
    }
    
    // MARK: - Update Data Source
    func updateDataSource() {
        DispatchQueue.main.async { [weak self] in
            self?.videoTableView.reloadData()
            print("Did update dataSource")
        }
    }
    
    @IBAction func showPopupButtonAction(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PopupVC") as! PopupVC
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
    
}

// MARK: - Delegate
extension MainVC: PopupDelegate {
    func didSaveNewLink() {
        mainViewModel.refresh()
    }
}

// MARK: - Table View Delegates & Protocols
extension MainVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            videoTableView.beginUpdates()
            
            mainViewModel.service.removeLink(id: mainViewModel.arrayOfLinks[indexPath.row].id)
            mainViewModel.refresh()
            videoTableView.deleteRows(at: [indexPath], with: .fade)
            
            videoTableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        videoPlayer.playVideo(view: self, url: mainViewModel.arrayOfLinks[indexPath.row].urlString)
    }
}

extension MainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainViewModel.arrayOfLinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoTableViewCell
        cell.viewModel = mainViewModel.viewModelForCell(indexPath)
        return cell
    }
}
