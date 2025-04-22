//
//  HomeModel.swift
//  SphereBindSwift
//
//  Created by Kevinho Morales on 23/12/24.
//

import SwiftUI

struct ItemModel: Identifiable, Codable {
    var id: String
    var title: String
    var date: String
    var imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, date, imageURL
    }
    
    // Imagen cacheada (no se guarda en Firestore)
    var image: UIImage?
}
