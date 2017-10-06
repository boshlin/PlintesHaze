//
//  SideMenuViewController.swift
//  PurpleHaze
//
//  Created by Alexander Khodko on 11/09/2017.
//  Copyright © 2017 Alexander Khodko. All rights reserved.
//

import UIKit
import SWRevealViewController

class SideMenuViewController: UIViewController {
    @IBOutlet var menuTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.menuTableView.dataSource = self
        self.menuTableView.delegate = self
        self.menuTableView.reloadData()
        self.revealViewController().delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.initGestures()
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.revealViewController().frontViewController.view.isUserInteractionEnabled = true
        self.deinitGestures()
    }
}

extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AccountUserTableViewCell", for: indexPath) as! AccountUserTableViewCell
            cell.userImage.image = UIImage(named: "avatarPlaceholder")
            cell.userName.text = "Давид Мини"
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell", for: indexPath) as! SideMenuTableViewCell
        switch indexPath.row {
        case 1:
            cell.menuItemTitle.text = "Главная"
            cell.menuItemTitle.textColor = UIColor.yellowHook
            cell.menuItemImage.image = UIImage(named: "main")
        case 2:
            cell.menuItemTitle.text = "Бронирвание"
            cell.menuItemImage.image = UIImage(named: "reservate")
        case 3:
            cell.menuItemTitle.text = "Миксы"
            cell.menuItemImage.image = UIImage(named: "mix")
        case 4:
            cell.menuItemTitle.text = "Мои заказы"
            cell.menuItemImage.image = UIImage(named: "reservations")
        case 5:
            cell.menuItemTitle.text = "О нас"
            cell.menuItemImage.image = UIImage(named: "info")
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension SideMenuViewController: SWRevealViewControllerDelegate {
    /// Функция, которая не позволяет листать Front View справа налево
    func revealControllerPanGestureShouldBegin(_: SWRevealViewController) -> Bool {
        
        let velocity = revealViewController().panGestureRecognizer().velocity(in: self.view)
        
        if velocity.x > 0 && revealViewController().frontViewPosition == FrontViewPosition.right {
            return false
        } else {
            return true
        }
    }
    
    private func deinitGestures() {
        if self.revealViewController().frontViewController.view.gestureRecognizers != nil {
            for gesture in self.revealViewController().frontViewController.view.gestureRecognizers! {
                if gesture == self.revealViewController().tapGestureRecognizer() {
                    gesture.isEnabled = true
                }
                
                if gesture == self.revealViewController().panGestureRecognizer() {
                    gesture.isEnabled = true
                }
            }
        }
        
        if let blockView = self.revealViewController().frontViewController.view.viewWithTag(1000) {
            blockView.removeFromSuperview()
        }
    }
    
    private func initGestures() {
        let disablingView = UIView(frame: CGRect(x: 0, y: 0, width: self.revealViewController().frontViewController.view.frame.width, height: self.revealViewController().frontViewController.view.frame.height))
        disablingView.tag = 1000
        self.revealViewController().frontViewController.view.addSubview(disablingView)
        self.revealViewController().frontViewController.view.bringSubview(toFront: disablingView)
        self.revealViewController().frontViewController.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        self.revealViewController().frontViewController.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.revealViewController().view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
}
