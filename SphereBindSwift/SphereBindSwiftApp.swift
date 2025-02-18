//
//  SphereBindSwiftApp.swift
//  SphereBindSwift
//
//  Created by Kevinho Morales on 28/11/24.
//

import SwiftUI
import Firebase

@main
struct SphereBindSwiftApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    @AppStorage("isLoggedIn") private var isLoggedIn = false // Estado de login global
    
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                HomeView() // Si ya está logueado, ir directo a Home
            } else {
                LoginView() // Si no, mostrar Login
            }
        }
    }
}
