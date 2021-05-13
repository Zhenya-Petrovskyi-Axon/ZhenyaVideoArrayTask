//
//  ViewController.swift
//  UsersYouTubeVideoLibrary
//
//  Created by Evhen Petrovskyi on 28.04.2021.
//

import UIKit
import AVKit

class MainVC: UIViewController {
    
    @IBOutlet weak var videoTableView: UITableView!
    
    private let cellID = "VideoCell"
    private let popupID = "PopupVC"
    
    private var mainViewModel: MainViewModelProtocol! = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFooterView()
        setupBindings()
        setupDelegates()
        setupCompletions()
    }
    
    // MARK: - Setup footer view
    func setupFooterView() {
        videoTableView.tableFooterView = UIView()
    }
    
    // MARK: - Setup completions for allert
    func setupCompletions() {
        mainViewModel.onError = { [weak self] error in
            self?.showAlert(text: error)
        }
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
        }
    }
    
    // MARK: - Show popup to add new links
    @IBAction func showPopupButtonAction(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: popupID) as? PopupVC else { return }
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
    
}

// MARK: - Update main view with new data when new user have been saved in PopupVC
extension MainVC: PopupDelegate {
    func userDidSaveNewLink(url: String) {
        mainViewModel.getLinks()
        playVideo(url)
    }
}

// MARK: - Table View Delegates
extension MainVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle { .delete }
    
    // MARK: Remove links
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        videoTableView.beginUpdates()
        mainViewModel.removeLink(indexPath)
        mainViewModel.getLinks()
        videoTableView.deleteRows(at: [indexPath], with: .fade)
        videoTableView.endUpdates()
    }
    
    // MARK: Play video from selected row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        playVideo(mainViewModel.videoUrl(at: indexPath))
    }
}

// MARK: - Table view DataSource
extension MainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mainViewModel.linksCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! VideoTableViewCell
        cell.viewModel = mainViewModel.viewModelForCell(indexPath)
        return cell
    }
}
