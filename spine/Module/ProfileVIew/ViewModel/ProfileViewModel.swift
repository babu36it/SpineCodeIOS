//
//  ProfileViewModel.swift
//  Populist
//
//  Created by Bharat Jadav on 05/07/21.
//

import Foundation
import Combine
import UIKit

class ProfileViewModel: NSObject, ObservableObject {
    var userData    : UserModel?
    var stateList   : [StateModel]?
    var cityList    : [CityModel]?
    
    // MARK:- server request for fetch
    func getUserProfile(resourceType: ApiResource, completion: @escaping (_ result: Bool, _ error: Error?) -> Void) {
        APIService.shared.requestWithGet(resourceType: .userProfile, requestType: .get, completion: { (result:Result<UserModel?, Error>) in
            switch result {
            case .success(let respone):
                self.userData = respone
                return completion(true, nil)
            case .failure(let error):
                AppUtility.shared.printToConsole(error)
                return completion(false, error)
            }
        })
    }
    
    // MARK:- server request for fetch
    func updatePassword(parameters : [String: Any], completion: @escaping (_ result: Bool, _ error: Error?) -> Void) {
        APIService.shared.requestWithPost(resourceType: .userChangePassword, requestType: .post, queryParameters: parameters as NSDictionary, completion: { (result:Result<GeneralWitoutData?, Error>) in
            switch result {
            case .success( _):
                return completion(true, nil)
            case .failure(let error):
                AppUtility.shared.printToConsole(error)
                return completion(false, error)
            }
        })
    }
    
    // MARK:- server request for fetch
    func resetPassword(parameters : [String: Any], completion: @escaping (_ result: Bool, _ error: Error?) -> Void) {
        APIService.shared.requestWithPost(resourceType: .userResetPassword, requestType: .post, queryParameters: parameters as NSDictionary, completion: { (result:Result<GeneralWitoutData?, Error>) in
            switch result {
            case .success( _):
                return completion(true, nil)
            case .failure(let error):
                AppUtility.shared.printToConsole(error)
                return completion(false, error)
            }
        })
    }
    
    // MARK:- server request for update profile
    func UpdateUserProfile(parameters : [String: Any], completion: @escaping (_ result: Bool, _ error: Error?) -> Void) {
        APIService.shared.requestWithPost(resourceType: .userUpdateProfile, requestType: .post, queryParameters: parameters as NSDictionary, completion: { (result:Result<UserModel?, Error>) in
            switch result {
            case .success(let response):
                if response != nil {
                    self.userData = response
                    AppUtility.shared.userSettings.userID = self.userData?.id?.stringValue ?? ""
                    return completion(true, nil)
                }
                return completion(false, nil)
            case .failure(let error):
                AppUtility.shared.printToConsole(error)
                return completion(false, error)
            }
        })
    }
    
    // MARK:- Update Notification preferences
    func updateNotificationPreference(parameters : [String: Any], completion: @escaping (_ result: Bool, _ error: Error?) -> Void) {
        APIService.shared.requestWithPost(resourceType: .userChangeNotiPref, requestType: .post, queryParameters: parameters as NSDictionary, completion: { (result:Result<GeneralWitoutData?, Error>) in
            switch result {
            case .success( _):
                return completion(true, nil)
            case .failure(let error):
                AppUtility.shared.printToConsole(error)
                return completion(false, error)
            }
        })
    }
    
    // MARK:- server request for fetch
    func getStateList(value: String = "", completion: @escaping (_ result: Bool, _ error: Error?) -> Void) {
        APIService.shared.requestWithGet(resourceType: .locationGetStates, value: value, requestType: .get, completion: { (result:Result<[StateModel]?, Error>) in
            switch result {
            case .success(let respone):
                self.stateList = respone
                return completion(true, nil)
            case .failure(let error):
                AppUtility.shared.printToConsole(error)
                return completion(false, error)
            }
        })
    }
    
    func getCityList(value: String = "", completion: @escaping (_ result: Bool, _ error: Error?) -> Void) {
        APIService.shared.requestWithGet(resourceType: .locationGetCities, value: value, requestType: .get, completion: { (result:Result<[CityModel]?, Error>) in
            switch result {
            case .success(let respone):
                self.cityList = respone
                return completion(true, nil)
            case .failure(let error):
                AppUtility.shared.printToConsole(error)
                return completion(false, error)
            }
        })
    }
}
