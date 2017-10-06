//
//  HookahCustomisationViewController.swift
//  PurpleHaze
//
//  Created by Alexander Khodko on 11/09/2017.
//  Copyright © 2017 Alexander Khodko. All rights reserved.
//

import UIKit

class HookahCustomisationViewController: ExtensedViewController {

    @IBOutlet var hookahStrength: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private var strengthes = ["3", "4", "5", "6", "7", "8", "9", "10"]
}

extension HookahCustomisationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.strengthes.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent _: Int, reusing view: UIView?) -> UIView {
        pickerView.subviews[1].isHidden = true
        pickerView.subviews[2].isHidden = true
        return PickerLabel(title: self.strengthes[row], size: 69.0, color: UIColor.yellowHook)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.strengthes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 81
    }
}
