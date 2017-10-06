//
//  InitialViewController.swift
//  PurpleHaze
//
//  Created by Alexander Khodko on 11/09/2017.
//  Copyright © 2017 Alexander Khodko. All rights reserved.
//

import UIKit

class InitialViewController: ExtensedViewController {
    @IBAction func showTerms() {
         UIApplication.shared.open(URL(string: "https://plintes.xyz")!, options: [:], completionHandler: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
