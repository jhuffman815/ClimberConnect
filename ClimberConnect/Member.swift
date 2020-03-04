//
//  Member.swift
//  ClimberConnect
//
//  Created by Jewell Huffman on 3/3/20.
//  Copyright © 2020 Jewell Huffman. All rights reserved.
//

import SwiftUI

struct Member: Codable {
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Connection]
}
