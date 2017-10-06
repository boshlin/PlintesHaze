//
//  ReservationInitialViewController.swift
//  PurpleHaze
//
//  Created by Alexander Khodko on 11/09/2017.
//  Copyright © 2017 Alexander Khodko. All rights reserved.
//

import UIKit

class ReservationInitialViewController: ExtensedViewController {
    @IBAction func showCalendar() {
        
    }

    @IBOutlet var timePicker: UIPickerView!
    @IBOutlet var peopleDescription: UILabel!
    @IBOutlet var peopleNumber: UILabel!
    
    @IBAction func decrease() {
        if Int(self.peopleNumber.text!)! < 2 {
            return
        }
        self.peopleNumber.text = String(Int(self.peopleNumber.text!)! - 1)
        self.peopleDescription.text = self.numberOfPeopleDescription
    }
    
    @IBAction func increase() {
        if Int(self.peopleNumber.text!)! > 9 {
            return
        }
        self.peopleNumber.text = String(Int(self.peopleNumber.text!)! + 1)
        self.peopleDescription.text = self.numberOfPeopleDescription
    }
    
    private var numberOfPeopleDescription: String {
        switch Int(self.peopleNumber.text!)! {
        case 2, 3, 4, 22, 23, 24, 32, 33, 34, 42, 43, 44: return "человека"
        default: return "человек"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.timePicker.delegate = self
        self.timePicker.dataSource = self
    }
    
    private let time = ["21:00", "21:15", "21:30", "21:45", "22:00", "22:15", "22:30", "22:45", "23:00", "23:15"]
}

extension ReservationInitialViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.time.count
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent _: Int, reusing view: UIView?) -> UIView {
        pickerView.subviews[1].isHidden = true
        pickerView.subviews[2].isHidden = true
        return PickerLabel(title: self.time[row], size: 69.0, color: UIColor.yellowHook)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.time[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 81
    }
}
