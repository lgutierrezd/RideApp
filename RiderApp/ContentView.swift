//
//  ContentView.swift
//  RiderApp
//
//  Created by Luis Gutierrez on 16/9/21.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [MKPointAnnotation]()
    
    @ObservedObject var dm = DistanceManager()
    @ObservedObject var sm = SettingsManager()
    
    @State private var showSettings = false
    
    @EnvironmentObject var viewModel: AppViewModel
    var body: some View {
        VStack {
            ZStack {
                MapView(centerCoordinate: $centerCoordinate, mapAnnotations: locations)
                    .edgesIgnoringSafeArea(.all)
                Circle()
                    .fill(Color.blue)
                    .opacity(0.3)
                    .frame(width: 30, height: 30)
            }
            Button(action: {
                let newLocation = MKPointAnnotation()
                newLocation.coordinate = self.centerCoordinate
                self.locations.append(newLocation)
                if locations.count == 2 {
                    let locationA = CLLocation(latitude: self.locations.first!.coordinate.latitude, longitude: self.locations.first!.coordinate.longitude)
                    let locationB = CLLocation(latitude: self.locations.last!.coordinate.latitude, longitude: self.locations.last!.coordinate.longitude)
                    self.dm.distance([locationA, locationB])
                } else if locations.count > 2 {
                    self.dm.distance = 0
                    locations.removeAll()
                }
            }, label: {
                if locations.count != 2 {
                    Image(systemName: "plus")
                } else if locations.count == 2 {
                    Image(systemName: "trash")
                }
            })
            .padding()
            .background(Color.red)
            .foregroundColor(Color.white)
            .font(.title)
            .clipShape(Circle())
            .padding(.top, -35)
            Text("Distance Evaluation")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold()
            ZStack {
                RingView(percentage: (dm.distance ?? 0) / Double(sm.travelRadius), startColor: Color.blue, endColor: Color.red)
                    .aspectRatio(contentMode: .fit)
                if dm.distance != 0{
                    Text("\(Int(dm.distance ?? 0)) km").font(.title).bold()
                }
            }
            Button(action: {
                viewModel.signOut()
            }, label: {
                Text("Sign out")
            })
            .padding()
            HStack {
                Spacer()
                Button(action: {
                    self.showSettings.toggle()
                }, label: {
                    Image(systemName: "gear")
                }).sheet(isPresented: $showSettings,content: {
                    SettingsView()
                })
                .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
