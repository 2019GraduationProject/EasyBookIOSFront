//
//  Member.swift
//  easyBook
//
//  Created by 黄小白 on 2019/3/22.
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
