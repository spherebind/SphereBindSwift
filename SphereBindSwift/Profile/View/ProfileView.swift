//
//  ProfileView.swift
//  SphereBindSwift
//
//  Created by Kevinho Morales on 18/2/25.
//

import SwiftUI

struct ProfileView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = false

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: isLoggedIn ? "person.fill" : "person")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
            
            Text(isLoggedIn ? "Usuario Logeado" : "No has iniciado sesión")
                .font(.title)
            
            Button("Cerrar Sesión") {
                isLoggedIn = false
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
