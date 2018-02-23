//
//  Utils.swift
//  Uber Clone
//
//  Created by Abhishek Meher on 23/02/18.
//  Copyright © 2018 Abhishek Meher. All rights reserved.
//


import Foundation
class Utils {
    struct UserKeys {
        let nameKey:String = "user.nameKey"
        let jwtKey:String =  "user.jwtkey"
        let imageUrlKey:String =  "user.imageUrl"
    }
    
    static func saveUser(user: User) -> Bool {
        let preferences = UserDefaults.standard
        let userKeys = UserKeys()
        preferences.set(user.name, forKey: userKeys.nameKey)
        preferences.set(user.jwt, forKey: userKeys.jwtKey)
        preferences.set(user.imageUrl, forKey: userKeys.imageUrlKey)
        
        return preferences.synchronize()
    }
    
    static func getUser() -> User? {
        let preferences = UserDefaults.standard
        let userKeys = UserKeys()
        
        let name:String
        if preferences.object(forKey: userKeys.nameKey) == nil {
            return nil
        } else {
            name = preferences.string(forKey: userKeys.nameKey)!
        }
        
        let jwt:String
        if preferences.object(forKey: userKeys.jwtKey) == nil {
            return nil
        } else {
            jwt = preferences.string(forKey: userKeys.jwtKey)!
        }
        
        let imageUrl:String?
        if preferences.object(forKey: userKeys.imageUrlKey) == nil {
            imageUrl = ""
        } else {
            imageUrl = preferences.string(forKey: userKeys.imageUrlKey)
        }
        return User(name: name, jwt: jwt, imageUrl: imageUrl)
    }

}

