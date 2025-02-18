//
//  LoginView.swift
//  SphereBindSwift
//
//  Created by Kevinho Morales on 4/12/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @AppStorage("isLoggedIn") private var isLoggedIn = false // Guarda el estado de login
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("Ingresa tus datos para continuar")
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
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                }
                
                Button(action: {
                    viewModel.login { success in
                        if success {
                            isLoggedIn = true // Guarda el login en AppStorage
                        }
                    }
                }) {
                    Text("Iniciar sesión")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                .padding(.top, 20)
                .disabled(viewModel.isLoading)
                
                Spacer()
                
                NavigationLink(destination: RegisterView()) {
                    Text("¿No tienes cuenta? Regístrate")
                        .foregroundColor(.blue)
                        .padding(.bottom, 5)
                }
                
                NavigationLink(destination: ForgotPasswordView()) {
                    Text("¿Olvidaste la contraseña?")
                        .foregroundColor(.blue)
                        .padding(.top, 5)
                }
            }
            .padding()
            .navigationTitle("Iniciar sesión")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(LoginViewModel())
    }
}
