//
//  User.swift
//  Uber Clone
//
//  Created by Abhishek Meher on 23/02/18.
//  Copyright © 2018 Abhishek Meher. All rights reserved.
//

struct User: Codable {
    var name: String
    var jwt: String
    var imageUrl: String?
}
