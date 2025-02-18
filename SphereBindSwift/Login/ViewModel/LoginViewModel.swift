//
//  LoginViewModel.swift
//  SphereBindSwift
//
//  Created by Kevinho Morales on 4/12/24.
//

import SwiftUI
import FirebaseAuth

final class LoginViewModel: ObservableObject {
    @Published var email: String = "kfmorales94@gmail.com"
    @Published var password: String = "12345678"
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    
    func login(completion: @escaping (Bool) -> Void) {
        errorMessage = nil
        isLoading = true
        
        guard !email.isEmpty else {
            errorMessage = "Por favor, ingresa tu correo."
            isLoading = false
            completion(false)
            return
        }
        
        guard !password.isEmpty else {
            errorMessage = "Por favor, ingresa tu contraseña."
            isLoading = false
            completion(false)
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    completion(false)
                } else {
                    completion(true)
                }
            }
        }
    }
}
