//
//  Extensions.swift
//  PurpleHaze
//
//  Created by Alexander Khodko on 11/09/2017.
//  Copyright © 2017 Alexander Khodko. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    @objc func dismissModal() {
        self.dismiss(animated: true, completion: nil)
    }
}

class ExtensedViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.hideKeyboard()
    }
    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
}

class BorderedButton: UIButton {
    override func draw(_ rect: CGRect) {
        let borderLayer = CAShapeLayer()
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.allCorners], cornerRadii: CGSize(width: 0, height: 0))
        let mask = CAShapeLayer()
        mask.frame = self.bounds
        mask.path = path.cgPath
        self.layer.mask = mask
        borderLayer.path = mask.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = UIColor.yellowHook.cgColor
        borderLayer.lineWidth = 6
        borderLayer.frame = self.bounds
        self.layer.addSublayer(borderLayer)
    }
}

extension UIScrollView {
    func setPageFor(targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageWidth: Float = Float(UIScreen.main.bounds.width - 120 / 3)
        let currentOffset: Float = Float(self.contentOffset.x)
        let targetOffset: Float = Float(targetContentOffset.pointee.x)
        var newTargetOffset: Float = 0
        if targetOffset > currentOffset {
            newTargetOffset = ceilf(currentOffset / pageWidth) * pageWidth
        } else {
            newTargetOffset = floorf(currentOffset / pageWidth) * pageWidth
        }
        if newTargetOffset < 0 {
            newTargetOffset = 0
        } else if newTargetOffset > Float(self.contentSize.width) {
            newTargetOffset = Float(Float(self.contentSize.width))
        }
        
        targetContentOffset.pointee.x = CGFloat(currentOffset)
        self.setContentOffset(CGPoint(x: CGFloat(newTargetOffset), y: self.contentOffset.y), animated: true)
    }
}

extension Array {
    func randomItem() -> Element? {
        if isEmpty { return nil }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}

extension UIColor {
    static var yellowHook: UIColor {
        return UIColor(red: 1, green: 196 / 255, blue: 0, alpha: 1)
    }
}

extension UITextField {
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "", attributes: [NSAttributedStringKey.foregroundColor: newValue!])
        }
    }
    
    func formatPhone(range: NSRange, string: String) -> Bool {
        let newString = (self.text! as NSString).replacingCharacters(in: range, with: string)
        let count = self.text?.characters.count ?? 0
        if newString.characters.count < count && newString.characters.count >= 4 {
            return true
        } else if newString.characters.count < 4 {
            return false
        }
        if newString.characters.count > 17 {
            return false
        }
        
        let components = newString.components(separatedBy: NSCharacterSet.decimalDigits.inverted)
        
        let decimalString = components.joined(separator: "") as NSString
        let length = decimalString.length
        
        var index = 0
        let formattedString = NSMutableString()
        formattedString.append("+")
        
        if length >= 1 {
            let countryCode = decimalString.substring(with: NSRange(location: 0, length: 1))
            formattedString.append(countryCode)
            index += 1
        }
        
        if length > 1 {
            var rangeLength = 3
            if length < 4 {
                rangeLength = length - 1
            }
            let operatorCode = decimalString.substring(with: NSRange(location: 1, length: rangeLength))
            formattedString.appendFormat(" (%@) ", operatorCode)
            index += operatorCode.characters.count
        }
        
        if length > 4 {
            var rangeLength = 3
            if length < 7 {
                rangeLength = length - 4
            }
            let prefix = decimalString.substring(with: NSRange(location: 4, length: rangeLength))
            formattedString.appendFormat("%@-", prefix)
            index += prefix.characters.count
        }
        
        if index < length {
            let remainder = decimalString.substring(from: index)
            formattedString.append(remainder)
        }
        
        self.text = formattedString as String
        
        if newString.characters.count == 17 {
            self.resignFirstResponder()
        }
        
        return false
    }
}

class PickerLabel: UILabel {
    
    init(title: String, size: Double, color: UIColor) {
        super.init(frame: .zero)
        self.backgroundColor = .clear
        self.textAlignment = .center
        let font = UIFont.boldSystemFont(ofSize: CGFloat(size))
        let attributedTitle = NSAttributedString(string: title, attributes: [NSAttributedStringKey.font: font, NSAttributedStringKey.foregroundColor: color])
        self.attributedText = attributedTitle
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
