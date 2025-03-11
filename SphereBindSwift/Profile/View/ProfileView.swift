//
//  ProfileView.swift
//  SphereBindSwift
//
//  Created by Kevinho Morales on 18/2/25.
//

import SwiftUI

struct ProfileView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @State private var showLogoutAlert = false

    var body: some View {
        VStack(spacing: 32) {
            // Imagen de perfil
            Image(systemName: isLoggedIn ? "person.fill" : "person")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
                .padding()

            // Texto de usuario
            VStack(spacing: 8) {
                Text(isLoggedIn ? "Usuario Logeado" : "No has iniciado sesión")
                    .font(.title2)
                    .fontWeight(.bold)
                
                if isLoggedIn {
                    Text("Tu cuenta está activa")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }

            Spacer()

            // Botón de cerrar sesión con alerta
            if isLoggedIn {
                Button(role: .destructive) {
                    showLogoutAlert = true
                } label: {
                    Text("Cerrar Sesión")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .alert("¿Cerrar sesión?", isPresented: $showLogoutAlert) {
                    Button("Cancelar", role: .cancel) { }
                    Button("Cerrar Sesión", role: .destructive) {
                        withAnimation {
                            isLoggedIn = false
                        }
                    }
                }
            }
        }
        .padding()
        .frame(maxHeight: .infinity)
        .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
        .animation(.easeInOut, value: isLoggedIn)
    }
}
