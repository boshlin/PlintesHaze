//
//  RegistrationViewController.swift
//  PurpleHaze
//
//  Created by Alexander Khodko on 11/09/2017.
//  Copyright © 2017 Alexander Khodko. All rights reserved.
//

import UIKit

class RegistrationViewController: ExtensedViewController, UITextFieldDelegate {
    @IBOutlet var dismissButton: UIBarButtonItem!
    
    @IBAction func proceed() {
//        let codeComfirmationController = Storyboards.registration.instantiateViewController(withIdentifier: "CodeComfirmationViewController")
//        self.navigationController?.pushViewController(codeComfirmationController, animated: true)
    }
    
    
    @IBOutlet var proceedButton: UIButton!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var phoneTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissButton.target = self
        self.dismissButton.action = #selector(dismissModal)
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
        self.phoneTextField.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "" {
            textField.text = "+7 ("
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return textField.formatPhone(range: range, string: string)
    }
}
