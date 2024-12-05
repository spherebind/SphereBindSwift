//
//  LoginView.swift
//  SphereBindSwift
//
//  Created by Kevinho Morales on 4/12/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @State private var isLoggedIn = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Text("Iniciar sesión")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                
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
                
                Button(action: {
                    viewModel.login { success in
                        if success {
                            isLoggedIn = true
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
                
                Spacer()
                
                // Navegación a Registro con NavigationLink
                NavigationLink(destination: RegisterView()) {
                    Text("¿No tienes cuenta? Regístrate")
                        .foregroundColor(.blue)
                        .padding(.bottom, 5)
                }
                
                // Navegación a Olvidé la Contraseña con NavigationLink
                NavigationLink(destination: ForgotPasswordView()) {
                    Text("¿Olvidaste la contraseña?")
                        .foregroundColor(.blue)
                        .padding(.top, 5)
                }
                
                // Navegación a HomeView con NavigationLink
                NavigationLink(destination: HomeView(), isActive: $isLoggedIn) {
                    EmptyView() // No mostramos ningún enlace visual, solo activamos la navegación
                }
            }
            .padding()
            .navigationTitle("Login")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(LoginViewModel()) // Inicializa el ViewModel para la vista previa
    }
}
