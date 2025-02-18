//
//  DetailViewModel.swift
//  SphereBindSwift
//
//  Created by Kevinho Morales on 23/12/24.
//

import SwiftUI

final class DetailViewModel: ObservableObject {
    @Published var selectedImage: UIImage?
    @Published var eventName: String = ""
    @Published var showAlert: Bool = false

    func validateAndSave(to homeViewModel: HomeViewModel) {
        if eventName.isEmpty {
            showAlert = true
        } else {
            homeViewModel.addItem(title: eventName, image: selectedImage)
        }
    }
}
