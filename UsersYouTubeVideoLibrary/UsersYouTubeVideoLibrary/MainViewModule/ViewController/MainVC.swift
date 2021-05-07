//
//  ViewController.swift
//  UsersYouTubeVideoLibrary
//
//  Created by Evhen Petrovskyi on 28.04.2021.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var videoTableView: UITableView!
    
    let mainViewModel = MainViewModel()
    
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
        mainViewModel.getLinks()
    }
}

// MARK: - Table View Delegates & Protocols
extension MainVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle { .delete }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        videoTableView.beginUpdates()
        mainViewModel.removeLink(at: indexPath)
        mainViewModel.getLinks()
        videoTableView.deleteRows(at: [indexPath], with: .fade)
        videoTableView.endUpdates()
    }
    
    // MARK: Play video from selected row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        playVideo(url: mainViewModel.arrayOfLinks[indexPath.row].urlString)
    }
}
extension MainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mainViewModel.linksCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoTableViewCell
        cell.viewModel = mainViewModel.viewModelForCell(indexPath)
        return cell
    }
}
