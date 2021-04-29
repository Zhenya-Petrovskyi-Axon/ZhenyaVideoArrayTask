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

    @IBAction func addLinkBarButtonAction(_ sender: Any) {
        mainViewModel.saveLink(link: "Hello World")
        print(mainViewModel.linkData?.result?.count ?? "No data")
    }
    
}

