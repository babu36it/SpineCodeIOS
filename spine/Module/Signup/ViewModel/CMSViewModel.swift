//
//  CMSViewModel.swift
//  Populist
//
//  Created by Bharat Jadav on 30/06/21.
//

import Foundation
import Combine
import UIKit

class CMSViewModel : NSObject, ObservableObject {
    var cmsData : CMSModel?
    @Published var isAnimating: Bool = false
    
    // MARK:- server request for fetch
    func getCMSPageDetails(resourceType: ApiResource, completion: @escaping (_ result: Bool, _ error: Error?) -> Void) {
        self.isAnimating.toggle()
        APIService.shared.requestWithGet(resourceType: resourceType, requestType: .get, completion: { (result:Result<CMSModel?, Error>) in
            self.isAnimating.toggle()
            switch result {
            case .success(let respone):
                self.cmsData = respone
                return completion(true, nil)
            case .failure(let error):
                AppUtility.shared.printToConsole(error)
                return completion(false, error)
            }
        })
    }
}

class WebViewModel: ObservableObject {
    @Published var htmlContent: String = ""
    @Published var didFinishLoading: Bool = false

    init (htmlContent: String) {
        self.htmlContent = htmlContent
    }
}
