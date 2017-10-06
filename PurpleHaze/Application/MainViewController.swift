//
//  MainViewController.swift
//  PurpleHaze
//
//  Created by Alexander Khodko on 11/09/2017.
//  Copyright © 2017 Alexander Khodko. All rights reserved.
//

import UIKit

class MainViewController: ExtensedViewController {

    @IBOutlet var tabacosCollectionView: UICollectionView!
    @IBOutlet var eventsCollectionView: UICollectionView!
    @IBOutlet var sideMenuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sideMenuButton.target = self.revealViewController()
        self.sideMenuButton.action = #selector(revealViewController().revealToggleFixed)
        self.revealViewController().panGestureRecognizer().isEnabled = true
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity _: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        scrollView.setPageFor(targetContentOffset: targetContentOffset)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.tabacosCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabacoCollectionViewCell", for: indexPath) as! TabacoCollectionViewCell
            cell.tabacoImage.image = UIImage(named: "TabacoPlaceholder")
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCollectionViewCell", for: indexPath) as! EventCollectionViewCell
        cell.eventImage.image = UIImage(named: "EventPlaceholder")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 50, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}
