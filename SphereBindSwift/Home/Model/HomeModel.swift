//
//  HomeModel.swift
//  SphereBindSwift
//
//  Created by Kevinho Morales on 23/12/24.
//

import SwiftUI

struct ItemModel: Identifiable {
    let id = UUID()
    let image: UIImage?
    let title: String
    let date: String
}
