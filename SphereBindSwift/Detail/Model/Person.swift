//
//  Person.swift
//  SphereBindSwift
//
//  Created by Kevinho Morales on 22/4/25.
//

import Foundation

struct Person: Codable, Identifiable {
    let id = UUID()
    var name: String
    var lastName: String
    var email: String
}
