//
//  File.swift
//  AssignmentNotebook
//
//  Created by Bailey Carlson on 2/19/19.
//  Copyright © 2019 John Hersey High School. All rights reserved.
//

import Foundation

class Assignment: Codable {
    
    var title: String
    var date: String
    var assignmentClass: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case date
        case assignmentClass
    }
    
    init(title: String, date: String, assignmentClass: String) {
        self.title = title
        self.date = date
        self.assignmentClass = assignmentClass
        
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title  = try container.decode(String.self, forKey: .title)
        date = try container.decode(String.self, forKey: .date)
        assignmentClass = try container.decode(String.self, forKey: .assignmentClass)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(date, forKey: .date)
        try container.encode(assignmentClass, forKey: .assignmentClass)
    }
    
}
