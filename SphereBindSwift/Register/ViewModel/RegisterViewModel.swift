//
//  RegisterViewModel.swift
//  SphereBindSwift
//
//  Created by Kevinho Morales on 4/12/24.
//

import Foundation
import FirebaseAuth

class RegisterViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var errorMessage: String?
    @Published var isRegistered: Bool = false // Indica si el registro fue exitoso

    func register() {
        // Validar campos
        guard !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            errorMessage = "Por favor, completa todos los campos."
            return
        }
        
        // Validar que las contraseñas coincidan
        guard password == confirmPassword else {
            errorMessage = "Las contraseñas no coinciden."
            return
        }
        
        // Registrar usuario con Firebase
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                self?.errorMessage = "Error: \(error.localizedDescription)"
            } else {
                self?.errorMessage = nil
                self?.isRegistered = true // Cambia a true tras un registro exitoso
            }
        }
    }
}
