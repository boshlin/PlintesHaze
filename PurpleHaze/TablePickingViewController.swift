//
//  TablePickingViewController.swift
//  PurpleHaze
//
//  Created by Alexander Khodko on 11/09/2017.
//  Copyright © 2017 Alexander Khodko. All rights reserved.
//

import UIKit

class TablePickingViewController: UIViewController {

    @IBAction func changeFloor(_ sender: UIButton) {
        if sender.titleLabel!.text! == "2 этаж" {
            sender.setTitle("1 этаж", for: UIControlState())
            return
        }
        sender.setTitle("2 этаж", for: UIControlState())
    }
    
    @IBOutlet var tables: [UIButton]!
    @IBAction func pickTable(_ sender: UIButton) {
        if sender.tag == 1 {
            return
        }
        self.tables.filter({$0.backgroundColor == UIColor.green.withAlphaComponent(0.3)}).forEach({$0.backgroundColor = .clear})
        sender.backgroundColor = UIColor.green.withAlphaComponent(0.3)
    }
    
    override func viewDidLoad() {
    }
}
