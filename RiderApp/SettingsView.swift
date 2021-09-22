//
//  SettingsView.swift
//  RiderApp
//
//  Created by Luis Gutierrez on 17/9/21.
//

import SwiftUI

struct SettingsView: View{
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var settings = SettingsManager()
    
    var body: some View{
        VStack {
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
            Text("Your ride experience")
                .font(.largeTitle)
                .bold()
            Spacer().frame(height: 100)
            Text("How far do you like to drive?").bold()
            Slider(value: $settings.travelRadius, in: 100...500, step: 100).padding()
            HStack {
                ForEach(0..<Int(settings.travelRadius/100), id:\.self){ _ in
                    Image(systemName: "bolt.car")
                        .font(.largeTitle)
                }
                
            }.padding(.top, 10)
            Text("My radius is \(Int(settings.travelRadius)) km")
                .font(.headline)
                .foregroundColor(.gray)
            Spacer()
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Done")
            })
        }
    }
    static let gradientStart = Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255)
    static let gradientEnd = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)
    
}

struct SettingsView_Previews: PreviewProvider{
    static var previews: some View{
        SettingsView()
    }
}
