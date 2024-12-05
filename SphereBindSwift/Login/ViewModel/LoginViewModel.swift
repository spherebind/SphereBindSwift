//
//  LoginViewModel.swift
//  SphereBindSwift
//
//  Created by Kevinho Morales on 4/12/24.
//

import SwiftUI
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String? = nil
    
    func login(completion: @escaping (Bool) -> Void) {
        // Limpiar cualquier mensaje de error previo
        errorMessage = nil
        
        // Validar que el correo no esté vacío
        guard !email.isEmpty else {
            errorMessage = "Por favor, ingresa tu correo."
            completion(false)
            return
        }
        
        // Validar que la contraseña no esté vacía
        guard !password.isEmpty else {
            errorMessage = "Por favor, ingresa tu contraseña."
            completion(false)
            return
        }
        
        // Iniciar sesión con Firebase Authentication
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                // Si ocurre un error, lo mostramos
                self.errorMessage = error.localizedDescription
                completion(false)
            } else {
                // Si el login es exitoso, indicamos que se ha iniciado sesión correctamente
                completion(true)
            }
        }
    }
}
