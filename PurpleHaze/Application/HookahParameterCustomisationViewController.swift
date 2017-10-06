//
//  HookahParameterCustomisationViewController.swift
//  PurpleHaze
//
//  Created by Alexander Khodko on 11/09/2017.
//  Copyright © 2017 Alexander Khodko. All rights reserved.
//

import UIKit

class HookahParameterCustomisationViewController: ExtensedViewController {
    var centerConstraint: NSLayoutConstraint!
    var startingConstant: CGFloat  = 0.0
    @objc private func moveView(_ sender:UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            self.startingConstant = self.centerConstraint.constant
        case .changed:
            if self.centerConstraint.constant > 150 {
                self.centerConstraint.constant = 150
                return
            }
            
            if self.centerConstraint.constant < -150 {
                self.centerConstraint.constant = -150
                return
            }
            let translation = sender.translation(in: self.view)
            self.centerConstraint.constant = self.startingConstant + translation.y
            let value1 = Int(viewFirst.frame.height/(selectionsView.frame.height - 50)*100)
            labelFirst.text = "\(value1)%"
            
            let value2 = Int(viewSecond.frame.height/(selectionsView.frame.height - 50)*100)
            labelSecond.text = "\(value2)%"
            
        default:
            break
        }
    }
    var labelFirst: UILabel!
    var labelSecond: UILabel!
    var viewFirst: UIView!
    var viewSecond: UIView!
    var movableViewHandler: UIView!
    @IBOutlet var selectionsView: UIView!
    override func viewDidLoad() {
        self.tastesCollectionView.delegate = self
        self.typesCollectionView.delegate = self
        self.tastesCollectionView.allowsSelection = true
        super.viewDidLoad()
    }
    
    private var didLayout = false
    
    override func viewDidLayoutSubviews() {
        if !self.didLayout {
            self.didLayout = true
            let viewMovable = UIImageView()
            viewMovable.image = UIImage(named: "SeparatorImage")
            viewMovable.contentMode = .scaleAspectFit
            self.movableViewHandler = viewMovable
            viewMovable.translatesAutoresizingMaskIntoConstraints = false
            self.selectionsView.addSubview(viewMovable)
            
            viewMovable.leadingAnchor.constraint(equalTo: self.selectionsView.leadingAnchor).isActive = true
            viewMovable.trailingAnchor.constraint(equalTo: self.selectionsView.trailingAnchor).isActive = true
            viewMovable.heightAnchor.constraint(equalToConstant: 50).isActive = true
            self.centerConstraint = viewMovable.centerYAnchor.constraint(equalTo: self.selectionsView.centerYAnchor)
            self.centerConstraint.isActive = true
            
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(moveView(_:)))
            viewMovable.isUserInteractionEnabled = true
            viewMovable.addGestureRecognizer(panGesture)
            let view = UIImageView()
            viewFirst = view
            view.image = UIImage(named: "Placeholder0")
            view.contentMode = .scaleAspectFit
            view.translatesAutoresizingMaskIntoConstraints = false
            self.selectionsView.addSubview(view)
            view.leadingAnchor.constraint(equalTo: self.selectionsView.leadingAnchor).isActive = true
            view.trailingAnchor.constraint(equalTo: self.selectionsView.trailingAnchor).isActive = true
            view.topAnchor.constraint(equalTo: self.selectionsView.topAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: viewMovable.topAnchor, constant: -10).isActive = true

            
            
            let view2 = UIImageView()
            viewSecond = view2
            view2.image = UIImage(named: "Placeholder1")
            view2.contentMode = .scaleAspectFit
            view2.translatesAutoresizingMaskIntoConstraints = false
            self.selectionsView.addSubview(view2)
            view2.leadingAnchor.constraint(equalTo: self.selectionsView.leadingAnchor).isActive = true
            view2.bottomAnchor.constraint(equalTo: self.selectionsView.bottomAnchor).isActive = true
            view2.trailingAnchor.constraint(equalTo: self.selectionsView.trailingAnchor).isActive = true
            view2.topAnchor.constraint(equalTo: viewMovable.bottomAnchor, constant: 10).isActive = true
            
            self.labelFirst = UILabel()
            self.labelSecond = UILabel()
            self.labelFirst.translatesAutoresizingMaskIntoConstraints = false
            self.labelSecond.translatesAutoresizingMaskIntoConstraints = false
            
            self.selectionsView.addSubview(labelFirst)
            self.selectionsView.addSubview(labelSecond)
            
            labelSecond.centerYAnchor.constraint(equalTo: view2.centerYAnchor).isActive = true
            labelSecond.centerXAnchor.constraint(equalTo: view2.centerXAnchor).isActive = true
            labelSecond.textColor = .white
            labelSecond.font = UIFont.boldSystemFont(ofSize: 45)
            labelSecond.text = "50%"
            
            labelFirst.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            labelFirst.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            labelFirst.textColor = .white
            labelFirst.font = UIFont.boldSystemFont(ofSize: 45)
            labelFirst.text = "50%"
            
        }
    }

    @IBOutlet var tastesCollectionView: UICollectionView!
    @IBOutlet var typesCollectionView: UICollectionView!
    private let tastesTypes = ["Фрукты", "Ягоды", "Сладкое", "Другое"]
    private let someArrayWithLabels = ["Банан", "Яблоко", "Персик", "Груша"]
    private let someArrayWithImages = ["Placeholder0", "Placeholder1", "Placeholder2", "Placeholder3"]
}

extension HookahParameterCustomisationViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tastesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TasteCollectionViewCell", for: indexPath) as! TasteCollectionViewCell
            cell.tasteImage.image = UIImage(named: self.someArrayWithImages.randomItem()!)
            cell.tasteImage.alpha = 0.5
            cell.tasteName.text = self.someArrayWithLabels.randomItem()!
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TasteTypeCollectionViewCell", for: indexPath) as! TasteTypeCollectionViewCell
        if indexPath.row < self.tastesTypes.count {
            cell.tasteType.text = self.tastesTypes[indexPath.row]
        } else {
            cell.tasteType.text = nil
        }
        if indexPath.row == 0 {
            cell.tasteType.textColor = UIColor.yellowHook
        }
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity _: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView == tastesCollectionView {
            return
        }
        let pageWidth: Float = Float((scrollView.frame.width - 10) / 3)
        let currentOffset: Float = Float(scrollView.contentOffset.x)
        let targetOffset: Float = Float(targetContentOffset.pointee.x)
        var newTargetOffset: Float = 0
        if targetOffset > currentOffset {
            self.typesCollectionView.visibleCells.forEach({($0 as! TasteTypeCollectionViewCell).tasteType.textColor = UIColor.white})
            (self.typesCollectionView.visibleCells[1] as! TasteTypeCollectionViewCell).tasteType.textColor = UIColor.yellowHook
            newTargetOffset = ceilf(currentOffset / pageWidth) * pageWidth
        } else {
            self.typesCollectionView.visibleCells.forEach({($0 as! TasteTypeCollectionViewCell).tasteType.textColor = UIColor.white})
            (self.typesCollectionView.visibleCells[0] as! TasteTypeCollectionViewCell).tasteType.textColor = UIColor.yellowHook
            newTargetOffset = floorf(currentOffset / pageWidth) * pageWidth
        }
        if newTargetOffset < 0 {
            newTargetOffset = 0
        } else if newTargetOffset > Float(scrollView.contentSize.width) {
            newTargetOffset = Float(Float(scrollView.contentSize.width))
        }
        self.tastesCollectionView.reloadData()
        targetContentOffset.pointee.x = CGFloat(currentOffset)
        scrollView.setContentOffset(CGPoint(x: CGFloat(newTargetOffset), y: scrollView.contentOffset.y), animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        if collectionView == tastesCollectionView {
            return 6
        }
        return self.tastesTypes.count + 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        if collectionView == tastesCollectionView {
            return CGSize(width: (collectionView.frame.width - 40), height: 150)
        }
        return CGSize(width: (collectionView.frame.width - 40) / 3, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        if collectionView == tastesCollectionView {
            print(indexPath.row)
            let cell = collectionView.cellForItem(at: indexPath)! as! TasteCollectionViewCell
            if cell.tasteImage.alpha == 0.5 {
                cell.tasteName.alpha = 1
                cell.tasteImage.alpha = 1
            } else {
                cell.tasteName.alpha = 0.5
                cell.tasteImage.alpha = 0.5
            }
        }
    }
}
