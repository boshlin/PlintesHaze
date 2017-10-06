//
//  CodeComfirmationViewController.swift
//  PurpleHaze
//
//  Created by Alexander Khodko on 11/09/2017.
//  Copyright © 2017 Alexander Khodko. All rights reserved.
//

import UIKit

class CodeComfirmationViewController: ExtensedViewController {

    @IBOutlet var proceedButton: UIButton!
    
    @IBAction func proceed() {
        User.shared.isAuthorised = true
        let mainViewController = Storyboards.application.instantiateViewController(withIdentifier: "SWRevealViewController")
        self.present(mainViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
    }
}
