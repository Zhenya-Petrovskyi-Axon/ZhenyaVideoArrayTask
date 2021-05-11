//
//  PopupVC.swift
//  UsersYouTubeVideoLibrary
//
//  Created by Evhen Petrovskyi on 30.04.2021.
//

import UIKit

// MARK: - Protocol for MainVC to update data
protocol PopupDelegate: AnyObject {
    func userDidSaveNewLink()
}

// MARK: - Main PopupVC Class
class PopupVC: UIViewController {
    
    @IBOutlet weak var mainPopupView: UIView!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    
    private var popupViewModel: PopupViewModelProtocol! = PopupViewModel()
    
    weak var delegate: PopupDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
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
        [titleTextField, urlTextField].forEach {
            $0?.layer.masksToBounds = true
            $0?.layer.cornerRadius = 10
            $0?.layer.borderWidth = 0.3
            $0?.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        }
        
        // MARK: - Tap on screen to dissmiss popup
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissView)))
    }
    
    // MARK: - Dissmiss pop-up with tap on screen
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Check & save data
    @IBAction func saveButtonAction(_ sender: UIButton) {
        guard let url = urlTextField.text,
              let title = titleTextField.text,
              !url.isBlank,
              !title.isBlank
        else {
            showAlert(text: "Mark all fields first, please")
            return
        }
        do {
            try popupViewModel.saveLink(urlString: url, title: title)
            self.dismiss(animated: false, completion: { [weak self] in
                self?.delegate?.userDidSaveNewLink()
            })
        } catch let error {
            self.showAlert(text: "\(error)")
        }
    }
}
