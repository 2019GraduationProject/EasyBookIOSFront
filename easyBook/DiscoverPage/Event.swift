//
//  Event.swift
//  easyBook
//
//  Created by 黄小白 on 2019/3/11.
//  Copyright © 2019 Sherley Huang's studio. All rights reserved.
//

struct Event: Codable {
    
    var name = ""
    var date: EventDate!
    var location = ""
    var group: [String] = []
    var clause: [Clause] = []
    var isOver = false 
    
    init(name: String, date: EventDate, location: String, group: [String], clause: [Clause]) {
        self.name = name
        self.date = date
        self.location = location
        self.group = group
        self.clause = clause
        self.isOver = false
    }
    
    init(name: String, date: EventDate, location: String, group: [String], clause: [Clause], isOver: Bool) {
        self.name = name
        self.date = date
        self.location = location
        self.group = group
        self.clause = clause
        self.isOver = isOver
    }
    
}

struct Clause: Codable {
    
    var startTime = ""
    var endTime = ""
    
    init(startTime: String, endTime: String) {
        self.startTime = startTime
        self.endTime = endTime
    }
    
}

struct EventDate: Codable {
    
    var monthAndDay = ""
    var year = ""
    
    init(monthAndDay: String) {
        let dateComponents = Calendar.current.dateComponents([.year], from: Date())
        self.monthAndDay = monthAndDay
        self.year = dateComponents.year!.description
    }
    
    init(monthAndDay: String, year: String) {
        self.monthAndDay = monthAndDay
        self.year = year
    }
    
}
