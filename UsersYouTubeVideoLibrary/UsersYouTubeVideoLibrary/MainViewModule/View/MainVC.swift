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

    // MARK: - Call Pop-up
    @IBAction func addLinkBarButtonAction(_ sender: Any) {
        mainViewModel.saveLink(link: "Hello World")
    }
    
}

// MARK: Table View Delegates & Protocols
extension MainVC: UITableViewDelegate {
    
}

extension MainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainViewModel.linksCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoTableViewCell
        cell.viewModel = mainViewModel.viewModelForCell(indexPath)
        return cell
    }
    
    
}
