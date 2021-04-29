//
//  ViewController.swift
//  UsersYouTubeVideoLibrary
//
//  Created by Evhen Petrovskyi on 28.04.2021.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var videoTableView: UITableView!
    
    var mainViewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
        setupDelegates()
        
    }
    
    func setupDelegates() {
        videoTableView.delegate = self
        videoTableView.dataSource = self
    }
    
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

    // MARK: -
    @IBAction func addLinkBarButtonAction(_ sender: Any) {
        mainViewModel.saveLink(link: "Hello World")
    }
    
}

extension MainVC: UITableViewDelegate {
    
}

extension MainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainViewModel.linksCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoTableViewCell
        cell.videoLinkCellLabel.text = mainViewModel.links[indexPath.row].url
        return cell
    }
    
    
}
