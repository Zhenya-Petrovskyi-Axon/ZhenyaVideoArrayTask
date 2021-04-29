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
    
    // MARK: - Show save allert
    func showInputPopup() {
        let alert = UIAlertController(title: "Upiii", message: "Wanna add a video link?", preferredStyle: .alert)

        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in

          guard let textField = alert.textFields?.first,
            let linkToSave = textField.text else {
              return
          }

            self.mainViewModel.saveLink(link: linkToSave)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)

        present(alert, animated: true)
    }

    // MARK: - Call Pop-up
    @IBAction func addLinkBarButtonAction(_ sender: Any) {
        showInputPopup()
      }

//      func save(name: String) {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//          return
//        }
//
//        let managedContext = appDelegate.persistentContainer.viewContext
//        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
//        let person = NSManagedObject(entity: entity, insertInto: managedContext)
//        person.setValue(name, forKeyPath: "name")
//
//        do {
//          try managedContext.save()
//          people.append(person)
//        } catch let error as NSError {
//          print("Could not save. \(error), \(error.userInfo)")
//        }
//      }
//    }
    
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
