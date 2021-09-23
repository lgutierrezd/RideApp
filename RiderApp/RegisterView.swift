//
//  RegisterView.swift
//  RiderApp
//
//  Created by Luis Gutierrez on 22/9/21.
//

import SwiftUI

struct RegisterView: View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var viewModel: AppViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView{
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
                        
                        viewModel.signUp(email: email, password: password)
                    }, label: {
                        Text("Create")
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                    })
                    .cornerRadius(8)
                }
                .padding()
                Spacer()
            }
            .navigationTitle("Create account")
        }
        .padding()
    }
    static let gradientStart = Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255)
    static let gradientEnd = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
