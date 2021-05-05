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
    
    // MARK: - Bindings
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
    
    @IBAction func showPopupButtonAction(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PopupVC") as! PopupVC
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true)
    }
    
}

// MARK: Table View Delegates & Protocols
extension MainVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            videoTableView.beginUpdates()
            
            mainViewModel.service.removeLink(id: mainViewModel.links[indexPath.row].id)
            mainViewModel.links.remove(at: indexPath.row)
            videoTableView.deleteRows(at: [indexPath], with: .fade)
            
            videoTableView.endUpdates()
        }
    }
    
}

extension MainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainViewModel.links.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoTableViewCell
        cell.viewModel = mainViewModel.viewModelForCell(indexPath)
        return cell
    }
}
