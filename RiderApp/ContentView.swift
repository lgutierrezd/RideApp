//
//  ContentView.swift
//  RiderApp
//
//  Created by Luis Gutierrez on 16/9/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color.gray)
                    .edgesIgnoringSafeArea(.all)
                Circle()
                    .fill(Color.blue)
                    .opacity(0.3)
                    .frame(width: 30, height: 30)
            }
            Button(action: {
                
            }, label: {
                Image(systemName: "plus")
            })
            .padding()
            .background(Color.red)
            .foregroundColor(Color.white)
            .font(.title)
            .clipShape(Circle())
            .padding(.top, -35)
            Text("Distance Evaluation")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold()
            Circle()
                .frame(width: 300, height: 300)
            HStack {
                Spacer()
                Button(action: {
                    
                }, label: {
                    Image(systemName: "gear")
                }).padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
