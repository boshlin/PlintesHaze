//
//  FinalResirvationViewController.swift
//  PurpleHaze
//
//  Created by Alexander Khodko on 11/09/2017.
//  Copyright © 2017 Alexander Khodko. All rights reserved.
//

import UIKit

class FinalResirvationViewController: ExtensedViewController {

    @IBAction func switchToMain() {
        self.navigationController?.popToViewController(self.navigationController!.viewControllers[0], animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
