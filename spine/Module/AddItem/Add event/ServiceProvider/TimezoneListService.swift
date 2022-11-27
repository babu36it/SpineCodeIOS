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
    private struct Constants {
        static let timezoneFilename: String = "timezones.json"
    }

    private let httpUtility: HttpUtility = .shared
    
    func getTimezones(completion: @escaping(_ result: Result<APIResponseModel<[TimezoneModel]>, CHError>) -> Void) {
        if let jsonData: Data = FileManager.default.fileDataFromCachesDirectory(for: Constants.timezoneFilename), let response: APIResponseModel<[TimezoneModel]> = try? JSONDecoder().decode(APIResponseModel<[TimezoneModel]>.self, from: jsonData) {
            completion(.success(response))
        } else {
            guard let timezonesList = URL(string: APIEndPoint.timezones.urlStr) else {
                completion(.failure(.invalidUrl))
                return
            }
            httpUtility.requestData(url: timezonesList, resultType: APIResponseModel<[TimezoneModel]>.self) { result in
                if let jsonData: Data = try? JSONEncoder().encode(result.get()) {
                    FileManager.default.saveDataToCachesDirectory(jsonData, filename: Constants.timezoneFilename)
                }
                completion(result)
            }
        }
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
