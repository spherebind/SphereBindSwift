//
//  RegisterView.swift
//  SphereBindSwift
//
//  Created by Kevinho Morales on 4/12/24.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = RegisterViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Crea una cuenta")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 10)
            
            Text("Ingresa tus datos para registrarte")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.bottom, 20)
            
            TextField("Email", text: $viewModel.email)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            SecureField("Contraseña", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .padding(.top, 10)
            
            SecureField("Confirma tu contraseña", text: $viewModel.confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .padding(.top, 10)
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            
            Button(action: viewModel.register) {
                Text("Registrarse")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            .padding(.top, 20)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Registro")
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
            .environmentObject(RegisterViewModel()) // Inicializa el ViewModel para la vista previa
    }
}
