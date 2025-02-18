//
//  HomeViewModel.swift
//  SphereBindSwift
//
//  Created by Kevinho Morales on 23/12/24.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    @Published var items: [ItemModel] = []
    
    func addItem(title: String, image: UIImage?) {
        let newItem = ItemModel(image: image, title: title, date: getCurrentDate())
        items.append(newItem)
    }
    
    private func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: Date())
    }
}
