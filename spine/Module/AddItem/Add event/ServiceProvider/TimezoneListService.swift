//
//  TimezoneListService.swift
//  spine
//
//  Created by Mac on 28/11/22.
//

import Foundation

struct TimezoneModel: Codable {
    let id, countryCode, timezone, gmtOffset: String
    let dstOffset, rawOffset: String

    enum CodingKeys: String, CodingKey {
        case id, timezone
        case countryCode = "country_code"
        case gmtOffset = "gmt_offset"
        case dstOffset = "dst_offset"
        case rawOffset = "raw_offset"
    }
}

class TimezoneListService {
    private let httpUtility: HttpUtility = .shared
    
    func getTimezones(completion: @escaping(_ result: Result<APIResponseModel<[TimezoneModel]>, CHError>) -> Void) {
        guard let url = URL(string: APIEndPoint.timezones.urlStr) else {
            completion(.failure(.invalidUrl))
            return
        }
        httpUtility.getCachedResponse(url: url, cachedFilename: CachedFileNames.timezones, completion: completion)
    }
    
    class func timezone(for timezone: String, completion: @escaping (TimezoneModel?) -> Void) {
        TimezoneListService().getTimezones { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let timezoneRes):
                    let timezoneModel = timezoneRes.data?.first { $0.timezone == timezone }
                    completion(timezoneModel)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
