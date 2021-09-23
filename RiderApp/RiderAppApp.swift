//
//  RiderAppApp.swift
//  RiderApp
//
//  Created by Luis Gutierrez on 16/9/21.
//

import SwiftUI
import Firebase

@main
struct RiderAppApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            let viewModel = AppViewModel()
            LoginView()
                .environmentObject(viewModel)
        }
    }
}
