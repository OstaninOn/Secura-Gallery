//
//  ViewController.swift
//  SecuraGallery
//
//  Created by  aleksandr on 1.11.22.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    
    @IBOutlet weak var penPin: UIButton!
    
    @IBOutlet weak var showPinButton: UIButton!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var glleryLabel: UILabel!
    
    @IBOutlet weak var pinField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pinField.placeholder = " password "
        pinField.layer.shadowOffset = CGSize(width: 5, height: 5)
        pinField.layer.shadowOpacity = 1
        pinField.layer.shadowRadius = 2
        
        glleryLabel.layer.shadowOffset = CGSize(width: 5, height: 5)
        glleryLabel.layer.shadowOpacity = 0.5
        glleryLabel.layer.shadowRadius = 0.8
        glleryLabel.layer.masksToBounds = false
        glleryLabel.layer.cornerRadius = 1
        
        showPinButton.setImage(UIImage(systemName: "eye"), for: .normal)
        showPinButton.setImage(UIImage(systemName: "eye.slash"), for: .selected)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func penPinGallery(_ sender: Any) {
        
        view.endEditing(true)
        guard pinField.text == "1234" else { return }
        let gallery = GalleryViewController()
        let navigation = UINavigationController(rootViewController: gallery)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: false)
        return
    }
   
    @IBAction func showPinn(_ sender: Any) {
        pinField.isSecureTextEntry.toggle()
        showPinButton.isSelected = !pinField.isSecureTextEntry
    }
    
    
    @IBAction func authButtonPressed() {
        
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            error: &error
        ) {
            let reason = "требуется идентификация!"
            
            context.evaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                localizedReason: reason
            ) { success, error in
                DispatchQueue.main.async {
                    guard success, error == nil else {
                        self.statusLabel.text = "Your Biometric Status:\n" + "Failed"
                        self.statusLabel.textColor = .red
                        self.showAlert(title: "ошибка", message: "попробуйте снова")
                        return
                    }
                    
                    self.statusLabel.text = "Your Biometric Status:\n" + "Logged In"
                    self.statusLabel.textColor = .green
                    self.view.endEditing(true)
                    let gallery = GalleryViewController()
                    let navigation = UINavigationController(rootViewController: gallery)
                    navigation.modalPresentationStyle = .fullScreen
                    self.present(navigation, animated: false)
                    
                }
                
            }
            
        } else {
            if let error {
                showAlert(title: "нет доступа", message: "\(error.localizedDescription)")
            }
        }
    }
}
extension ViewController {
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "отмена", style: .cancel)
        alert.addAction(dismissAction)
        present(alert, animated: true)
    }
    
}

