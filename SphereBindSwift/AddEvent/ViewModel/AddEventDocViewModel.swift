//
//  AddEventDocViewModel.swift
//  SphereBindSwift
//
//  Created by Kevinho Morales on 23/12/24.
//

import SwiftUI

final class AddEventDocViewModel: ObservableObject {
    @Published var selectedImage: UIImage?
    @Published var eventName: String = ""
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = "Debe ingresar el nombre del evento"
    
    var isFormValid: Bool {
        !eventName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func validateAndSave(to homeViewModel: HomeViewModel) -> Bool {
        let trimmedName = eventName.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedName.isEmpty {
            alertMessage = "Debe ingresar el nombre del evento"
            showAlert = true
            return false
        } else if selectedImage == nil {
            alertMessage = "Debe seleccionar una imagen para el evento"
            showAlert = true
            return false
        } else {
            homeViewModel.addItem(title: trimmedName, image: selectedImage)
            // Limpiar el formulario después de guardar
            resetForm()
            return true
        }
    }
    
    func resetForm() {
        eventName = ""
        selectedImage = nil
    }
}
