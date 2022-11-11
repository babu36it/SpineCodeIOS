//
//  UserSettings.swift
//  spine

import Foundation
import Combine

class UserSettings: ObservableObject {
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    @UserDefault("userEmail", defaultValue: "")
    var userEmail: String {
        willSet {
            objectWillChange.send()
        }
    }
    
    @UserDefault("userPassword", defaultValue: "")
    var userPassword: String {
        willSet {
            objectWillChange.send()
        }
    }
    
    @UserDefault("deviceToken", defaultValue: "")
    var deviceToken: String {
        willSet {
            objectWillChange.send()
        }
    }
    
    @UserDefault("deviceType", defaultValue: "")
    var deviceType: String {
        willSet {
            objectWillChange.send()
        }
    }
    

    @UserDefault("userName", defaultValue: "")
    var userName: String {
        willSet {
            objectWillChange.send()
        }
    }
    
    @UserDefault("userID", defaultValue: "")
    var userID: String {
        willSet {
            objectWillChange.send()
        }
    }
    
    @UserDefault("userMobile", defaultValue: "")
    var userMobile: String {
        willSet {
            objectWillChange.send()
        }
    }
    
    @UserDefault("islogin", defaultValue: false)
    var islogin: Bool {
        willSet {
            objectWillChange.send()
        }
    }
    
    @UserDefault("authToken", defaultValue: "")
    var authToken: String {
        willSet {
            objectWillChange.send()
        }
    }
    
    @UserDefault("isNOtificationON", defaultValue: true)
    var isNOtificationON: Bool {
        willSet {
            objectWillChange.send()
        }
    }
    
    @UserDefault("unSeenNotification", defaultValue: [:])
    var unseenNotifications:[AnyHashable : Any] {
        willSet {
            objectWillChange.send()
        }
    }
}

//MARK: UserDefault Storage Data
@propertyWrapper
struct UserDefault<T> {
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
            UserDefaults.standard.set(newValue, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
}
