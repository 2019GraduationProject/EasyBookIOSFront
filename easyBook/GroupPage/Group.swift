//
//  Group.swift
//  easyBook
//
//  Created by 黄小白 on 2019/3/23.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

struct Member: Codable {
    
    var avatar = ""
    var name = ""
    var gender = ""
    var introducation = ""
    var phone = ""
    var personBg = ""
    var isHolder = false
    
    init(avatar: String, name: String, gender: String, introducation: String, phone: String, personBg: String) {
        self.avatar = avatar
        self.name = name
        self.gender = gender
        self.introducation = introducation
        self.phone = phone
        self.personBg = personBg
        self.isHolder = false
    }
    
    init(avatar: String, name: String, gender: String, introducation: String, phone: String, personBg: String, isHolder: Bool) {
        self.avatar = avatar
        self.name = name
        self.gender = gender
        self.introducation = introducation
        self.phone = phone
        self.personBg = personBg
        self.isHolder = isHolder
    }
    
}

struct Invitation: Codable {
    
    var inviter: String
    var inviterAvatar: String
    var message: String
    
    init(inviter: String, inviterAvatar: String, message: String) {
        self.inviter = inviter
        self.inviterAvatar = inviterAvatar
        self.message = message
    }
    
}
