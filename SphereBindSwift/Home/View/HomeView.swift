//
//  HomeView.swift
//  SphereBindSwift
//
//  Created by Kevinho Morales on 4/12/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Text("¡Bienvenido a Sphere Bind!")
                .font(.largeTitle)
                .bold()
                .padding()

            Text("Esta es la pantalla principal después de iniciar sesión.")
                .font(.body)
                .padding()

            Spacer()
        }
    }
}

#Preview {
    HomeView()
}
