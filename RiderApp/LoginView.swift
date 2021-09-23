//
//  LoginView.swift
//  RiderApp
//
//  Created by Luis Gutierrez on 22/9/21.
//

import SwiftUI
import FirebaseAuth

class AppViewModel: ObservableObject {
    let auth = Auth.auth()
    
    @Published var signedIn = false
    
    var isSignedIn: Bool{
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password, completion: { [weak self] result, error in
            guard result != nil, error == nil else{
                return
            }
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        })
    }
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password, completion: { [weak self] result, error in
            guard result != nil, error == nil else{
                return
            }
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        })
    }
    
    func signOut() {
        try? auth.signOut()
        self.signedIn = false
    }
}

struct LoginView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView{
            if viewModel.signedIn {
                ContentView()
//                VStack {
//                    Text("You are singed in")
//                        .navigationTitle("Sign in")
//                        .padding()
//                    Button(action: {
//                        viewModel.signOut()
//                    }, label: {
//                        Text("Sign out")
//                    })
//                    .padding()
//                }
            } else {
                SignInView()
                    .navigationTitle("Sign in")
            }
        }
        .onAppear{
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}

struct SignInView: View {
    @State var email = ""
    @State var password = ""
    
    @State private var showRegisterView = false
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        VStack{
            ZStack {
                Polygon(sides: 6) // Hexagon
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [Self.gradientStart, Self.gradientEnd]),
                        startPoint: UnitPoint(x: 0.5, y: 0),
                        endPoint: UnitPoint(x: 0.5, y: 0.6)
                    ))
                    .frame(width : 150, height: 150, alignment: .topTrailing)
                Image(systemName: "bicycle").foregroundColor(.white).font(.largeTitle)
            }.padding(.top, 150)
            
            VStack{
                TextField("Email", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .background(Color(.secondarySystemBackground))
                    .padding()
                    .cornerRadius(8)
                
                SecureField("Password", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .background(Color(.secondarySystemBackground))
                    .padding()
                    .cornerRadius(8)
                
                Button(action: {
                    guard !email.isEmpty, !password.isEmpty else {
                        return
                    }
                    
                    viewModel.signIn(email: email, password: password)
                }, label: {
                    Text("Sign in")
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(Color.pink)
                })
                .cornerRadius(8)
                .padding()
                
                Button(action: {
                    self.showRegisterView.toggle()
                }, label: {
                    Text("Sign up")
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                }).sheet(isPresented: $showRegisterView, content: {
                    RegisterView()
                })
                .cornerRadius(8)
            }
            .padding()
            Spacer()
        }
    }
    static let gradientStart = Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255)
    static let gradientEnd = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
