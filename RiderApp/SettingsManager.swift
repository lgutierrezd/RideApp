//
//  SettingsManager.swift
//  RiderApp
//
//  Created by Luis Gutierrez on 20/9/21.
//

import Foundation
import Combine

class SettingsManager: ObservableObject{
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    @SettingsDefault("travelRadius", defaultValue: 300)
    var travelRadius: Double {
        willSet{
            objectWillChange.send()
        }
    }
}
