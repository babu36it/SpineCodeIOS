//
//  ValidateRssServiceProvider.swift
//  spine
//
//  Created by Mac on 18/10/22.
//

import Foundation

struct ValidateRssServiceProvider {
    private let httpUtility: HttpUtility
    
    init(httpUtility: HttpUtility) {
        self.httpUtility = httpUtility
    }
    
    func validateRss(postData: [String:Any]?, completion: @escaping(_ result: Result<ValidateRssResponseModel, CHError>)-> Void) {
        guard let url = URL(string: APIEndPoint.validateRss.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.requestData(httpMethod: .post, postData: postData, url: url, resultType: ValidateRssResponseModel.self) { result in
            completion(result)
        }
    }
    
}


struct RssEmailOTPVerificationServiceProvider {
    private let httpUtility: HttpUtility
    
    init(httpUtility: HttpUtility) {
        self.httpUtility = httpUtility
    }
    
    func validateRssOTP(postData: [String:Any]?, completion: @escaping(_ result: Result<RssOtpResponseModel, CHError>)-> Void) {
        guard let url = URL(string: APIEndPoint.rssEmailOTPVerification.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.requestData(httpMethod: .post, postData: postData, url: url, resultType: RssOtpResponseModel.self) { result in
            completion(result)
        }
    }
}

struct RssDataServiceProvider {
    private let httpUtility: HttpUtility
    
    init(httpUtility: HttpUtility) {
        self.httpUtility = httpUtility
    }
    
    func getRssData(postData: [String:Any]?, completion: @escaping(_ result: Result<RssDataResponseModel, CHError>)-> Void) {
        guard let url = URL(string: APIEndPoint.getRssData.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.requestData(httpMethod: .post, postData: postData, url: url, resultType: RssDataResponseModel.self) { result in
            completion(result)
        }
    }
}

struct AddPodcastServiceProvider {
    private let httpUtility: HttpUtility
    
    init(httpUtility: HttpUtility) {
        self.httpUtility = httpUtility
    }
    
    func getLanguageList(completion: @escaping(_ result: Result<LanguageListResponse, CHError>)-> Void) {
        
        //let urlStr = Helper.getUrlString(itemType: itemType)
        
        guard let url = URL(string: APIEndPoint.languages.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.requestData(httpMethod: .get, url: url, resultType: LanguageListResponse.self) { result in
            completion(result)
        }
    }
    
    func getCategoryList(completion: @escaping(_ result: Result<CategoryListResponse, CHError>)-> Void) {
        
        guard let url = URL(string: APIEndPoint.getPodcastsCategory.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.requestData(httpMethod: .get, url: url, resultType: CategoryListResponse.self) { result in
            completion(result)
        }
    }
    
    func getSubCategories(postData: [String:Any]?, completion: @escaping(_ result: Result<SubCategoryResponse, CHError>)-> Void) {
        guard let url = URL(string: APIEndPoint.getPodcastsSubcategoryByIds.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.requestData(httpMethod: .post, postData: postData, url: url, resultType: SubCategoryResponse.self) { result in
            completion(result)
        }
    }
    
    
    func addPodcastsSubcategory(postData: [String:Any]?, completion: @escaping(_ result: Result<GeneralResponseModel, CHError>)-> Void) {
        guard let url = URL(string: APIEndPoint.addPodcastsSubcategory.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.requestData(httpMethod: .post, postData: postData, url: url, resultType: GeneralResponseModel.self) { result in
            completion(result)
        }
    }
    
    func submitPodcast(postData: [String: Any]?, completion: @escaping(_ result: Result<GeneralResponseModel, CHError>)-> Void) {
        guard let url = URL(string: APIEndPoint.addPodcasts.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.requestData(httpMethod: .post, postData: postData, url: url, resultType: GeneralResponseModel.self) { result in
            completion(result)
        }
    }
    
}


