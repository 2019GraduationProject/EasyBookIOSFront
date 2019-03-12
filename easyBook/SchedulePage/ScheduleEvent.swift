//
//  ScheduleEvent.swift
//  easyBook
//
//  Created by 黄小白 on 2019/3/12.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

struct ScheduleEvent: Codable {
    
    var name = ""
    var date = ""
    var startTime = ""
    var endTime = ""
    var location = ""
    var group: [String] = []
    
    init(name: String, date: String, startTime: String, endTime: String, location: String, group: [String]) {
        self.name = name
        self.date = date
        self.startTime = startTime
        self.endTime = endTime
        self.location = location
        self.group = group
    }
    
}
