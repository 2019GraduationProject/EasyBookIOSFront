//
//  Message.swift
//  easyBook
//
//  Created by 黄小白 on 2019/3/19.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

struct Message: Codable {
    
    var title = ""
    var content = ""
    var time = ""
    
    init(title: String, content: String, time: String) {
        self.title = title
        self.content = content
        self.time = time
    }
    
}
