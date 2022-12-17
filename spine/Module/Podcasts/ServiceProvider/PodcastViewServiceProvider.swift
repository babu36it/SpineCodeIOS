//
//  PodcastViewServiceProvider.swift
//  spine
//
//  Created by Mac on 16/12/22.
//

import Foundation

struct PodcastViewServiceProvider {
    private let httpUtility: HttpUtility = .shared
        
    func getPodcastEpisodes(postData: [String:Any]?, completion: @escaping(_ result: Result<PodcastEpisodeCustomResponse, CHError>)-> Void) {
        guard let url = URL(string: APIEndPoint.getPodacastEpisodes.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.requestData(httpMethod: .get, postData: postData, url: url, resultType: PodcastEpisodeCustomResponse.self) { result in
            completion(result)
        }
    }
    
    func getPodcasts(postData: [String:Any]?, completion: @escaping(_ result: Result<PodcastResponse, CHError>)-> Void) {
        guard let url = URL(string: APIEndPoint.getPodacasts.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.requestData(httpMethod: .get, postData: postData, url: url, resultType: PodcastResponse.self) { result in
            completion(result)
        }
    }
    
}
