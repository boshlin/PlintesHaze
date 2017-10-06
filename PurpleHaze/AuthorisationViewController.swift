//
//  AuthorisationViewController.swift
//  PurpleHaze
//
//  Created by Alexander Khodko on 11/09/2017.
//  Copyright © 2017 Alexander Khodko. All rights reserved.
//

import UIKit

class AuthorisationViewController: ExtensedViewController, UITextFieldDelegate {
    
    @IBAction func proceed() {
        User.shared.isAuthorised = true
        let mainViewController = Storyboards.application.instantiateViewController(withIdentifier: "SWRevealViewController")
        self.present(mainViewController, animated: true, completion: nil)
    }
    
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var codeTextField: UITextField!
    @IBOutlet var proceedButton: UIButton!
    @IBOutlet var dismissButton: UIBarButtonItem!
    @IBOutlet var buttonToBottom: NSLayoutConstraint!
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
