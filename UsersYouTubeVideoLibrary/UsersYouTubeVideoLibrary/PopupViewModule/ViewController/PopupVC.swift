//
//  PopupVC.swift
//  UsersYouTubeVideoLibrary
//
//  Created by Evhen Petrovskyi on 30.04.2021.
//

import UIKit

// MARK: - Protocol for MainVC to update data
protocol PopupDelegate: AnyObject {
    func userDidSaveNewLink(url: String)
}

// MARK: - Main PopupVC Class
class PopupVC: UIViewController {
    
    @IBOutlet weak var mainPopupView: UIView!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    
    private var popupViewModel: PopupViewModelProtocol! = PopupViewModel()
    
    weak var delegate: PopupDelegate?
    
    private let titleMaxLenght = 30
    private let urlMaxLenght = 150
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainView()
        textFieldMaxLenght()
    }
    
    // MARK: - Setup view
    func setupMainView() {
        setTextFieldCorners()
        setupViewEffect()
        setupPopupView()
        dissmissRecogniser()
    }
    
    // MARK: - Dissmiss popup on screen tap
    func dissmissRecogniser() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissView)))
    }
    
    // MARK: - Set up popupView
    func setupPopupView() {
        // MARK: - Basic setup of view
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        mainPopupView.backgroundColor = .systemGray4.withAlphaComponent(0.9)
        mainPopupView.layer.cornerRadius = 20
        mainPopupView.layer.borderWidth = 1
        mainPopupView.layer.borderColor = UIColor.white.cgColor
    }
    // MARK: - Oval corners for text fields
    func setTextFieldCorners() {
        [titleTextField, urlTextField].forEach {
            $0?.layer.masksToBounds = true
            $0?.layer.cornerRadius = 10
            $0?.layer.borderWidth = 0.3
            $0?.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        }
    }
    
    // MARK: - 3D effect for popup view
    func setupViewEffect() {
        mainPopupView.layer.shadowRadius = 5
        mainPopupView.layer.shadowOpacity = 0.6
        mainPopupView.layer.shadowColor = UIColor.black.cgColor
        mainPopupView.layer.shadowOffset = CGSize(width: 10, height: 10)
    }
    
    // MARK: - Set maximum lenght for textField
    func textFieldMaxLenght() {
        [titleTextField, urlTextField].forEach {
            $0?.delegate = self
            $0?.smartInsertDeleteType = UITextSmartInsertDeleteType.no
        }
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
                self?.delegate?.userDidSaveNewLink(url: url)
            })
        } catch let error {
            switch error {
            case URLValidationError.urlIsNotValid:
                showAlert(text: "Url you are trying to save is not valid")
            default:
                showAlert(text: "System error, can't save url")
            }
        }
    }
}

// MARK: - UITextField delegate
extension PopupVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case titleTextField:
            guard let textFieldText = titleTextField.text,
                  let rangeOfTextToReplace = Range(range, in: textFieldText) else { return false }
            let substringToReplace = textFieldText[rangeOfTextToReplace]
            let count = textFieldText.count - substringToReplace.count + string.count
            return count <= titleMaxLenght
        case urlTextField:
            guard let textFieldText = urlTextField.text,
                  let rangeOfTextToReplace = Range(range, in: textFieldText) else { return false }
            let substringToReplace = textFieldText[rangeOfTextToReplace]
            let count = textFieldText.count - substringToReplace.count + string.count
            return count <= urlMaxLenght
        default:
            return false
        }
    }
}
