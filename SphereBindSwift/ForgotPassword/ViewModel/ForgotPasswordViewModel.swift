//
//  ForgotPasswordViewModel.swift
//  SphereBindSwift
//
//  Created by Kevinho Morales on 4/12/24.
//

import Foundation
import FirebaseAuth

class ForgotPasswordViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var errorMessage: String?
    @Published var isEmailSent: Bool = false // Indica si el email fue enviado con éxito

    func sendPasswordReset() {
        // Validar que el email no esté vacío
        guard !email.isEmpty else {
            errorMessage = "Por favor, ingresa tu email."
            return
        }

        // Enviar correo de recuperación
        Auth.auth().sendPasswordReset(withEmail: email) { [weak self] error in
            if let error = error {
                self?.errorMessage = "Error: \(error.localizedDescription)"
            } else {
                self?.errorMessage = nil
                self?.isEmailSent = true // Cambia a true tras enviar el correo
            }
        }
    }
}
