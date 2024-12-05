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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
