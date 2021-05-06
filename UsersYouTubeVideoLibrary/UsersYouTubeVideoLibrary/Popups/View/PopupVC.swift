//
//  PopupVC.swift
//  UsersYouTubeVideoLibrary
//
//  Created by Evhen Petrovskyi on 30.04.2021.
//

import UIKit

protocol PopupDelegate: AnyObject {
    func didSaveNewLink()
}

class PopupVC: UIViewController {
    
    @IBOutlet weak var mainPopupView: UIView!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    
    weak var delegate: PopupDelegate?
    
    let popupViewModel = PopupViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        print("PopupView viewDidLoad")
        
    }
    
    // MARK: - Setup view
    func setupView() {
        
        // MARK: - 3D effect for popup view
        mainPopupView.layer.shadowRadius = 5
        mainPopupView.layer.shadowColor = UIColor.black.cgColor
        mainPopupView.layer.shadowOpacity = 0.6
        mainPopupView.layer.shadowOffset = CGSize(width: 10, height: 10)
        
        // MARK: - Basic setup of view
        mainPopupView.backgroundColor = .systemGray4.withAlphaComponent(0.9)
        mainPopupView.layer.masksToBounds = true
        mainPopupView.layer.cornerRadius = 20
        mainPopupView.layer.borderWidth = 1
        mainPopupView.layer.borderColor = UIColor.white.cgColor
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        // MARK: - Text fields setup
        [titleTextField, urlTextField] .forEach { $0?.layer.masksToBounds = true
            $0?.layer.cornerRadius = 10
            $0?.layer.borderWidth = 0.3
            $0?.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        }
        
        // MARK: - Tap on screen to dissmiss popup
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissView)))
    }
    
    // MARK: - Dissmiss pop-up with tap on screen
    @objc func dismissView(){
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Check & save data
    @IBAction func saveButtonAction(_ sender: UIButton) {
        
        guard urlTextField.text != "" else {
            print("Url field is empty")
            return
        }
        
        let url = urlTextField.text ?? "Some Link"
        let title = titleTextField.text ?? "Some Title"
        
        if popupViewModel.isUrlValid(url: url) == true {
            
            popupViewModel.saveLink(urlString: url, title: title)
            print("\(url) Is valid to save")
            self.dismiss(animated: false, completion: { [weak self] in
                self?.delegate?.didSaveNewLink()
            })
             
        } else {
            // show allert
            print("Url is not valid")
        }
    }
}
