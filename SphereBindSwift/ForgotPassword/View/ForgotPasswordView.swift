//
//  ForgotPasswordView.swift
//  SphereBindSwift
//
//  Created by Kevinho Morales on 4/12/24.
//

import SwiftUI

struct ForgotPasswordView: View {
    @StateObject private var viewModel = ForgotPasswordViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Recupera tu contraseña")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 10)
            
            Text("Ingresa tu correo para recibir un enlace de recuperación")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.bottom, 20)
            
            TextField("Email", text: $viewModel.email)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            
            Button(action: viewModel.sendPasswordReset) {
                Text("Enviar enlace de recuperación")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            .padding(.top, 20)
            
            if viewModel.isEmailSent {
                Text("¡Correo enviado con éxito! Revisa tu bandeja de entrada.")
                    .foregroundColor(.green)
                    .multilineTextAlignment(.center)
                    .padding(.top, 10)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Recuperar Contraseña")
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
            .environmentObject(ForgotPasswordViewModel()) // Inicializa el ViewModel para la vista previa
    }
}
