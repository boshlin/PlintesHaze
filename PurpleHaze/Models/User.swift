//
//  User.swift
//  PurpleHaze
//
//  Created by Alexander Khodko on 11/09/2017.
//  Copyright © 2017 Alexander Khodko. All rights reserved.
//

import Foundation

final class User {
    private init() {}
    static let shared = User()
    
    var isAuthorised: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "Authorised")
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "Authorised")
            UserDefaults.standard.synchronize()
        }
    }
}
