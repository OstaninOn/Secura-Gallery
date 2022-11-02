//
//  ViewController.swift
//  SecuraGallery
//
//  Created by  aleksandr on 1.11.22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pinField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        pinField.placeholder = " ⤷ Password"
        
    }

    @IBAction func unlockOpen(_ sender: Any) {
        view.endEditing(true)
        guard pinField.text == "1234" else { return }
        
            let gallery = GalleryViewController()
            let navigation = UINavigationController(rootViewController: gallery)
            navigation.modalPresentationStyle = .fullScreen
            present(navigation, animated: false)
            
    }
    
}

