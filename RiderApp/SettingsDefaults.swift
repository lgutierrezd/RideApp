//
//  SettingsDefaults.swift
//  RiderApp
//
//  Created by Luis Gutierrez on 20/9/21.
//

import Foundation

@propertyWrapper
struct SettingsDefault<T> {
    let key: String
    let defaultValue: T
    
    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: key)
        }
    }
}
