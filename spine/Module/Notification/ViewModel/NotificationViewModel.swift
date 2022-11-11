//
//  NotificationViewModel.swift
//  Populist
//
//  Created by Mitun Patel on 12/07/21.
//

import Foundation

class NotificationViewModel: NSObject, ObservableObject {
    @Published var notificationList = [NotificationModel]()
    var notificationListFull = false
    var totalNotificationCount = 0
    var pageNo = 0
    let pageSize = 10
    
    // MARK:- server request for fetch
    func getNotificationList(_ pageNumber:Int = 0, completion: @escaping (_ result: Bool, _ error: Error?) -> Void) {
        let strParam = "page_size=\(pageSize)&page_no=\(pageNumber)"
        APIService.shared.requestWithGet(resourceType: .getNotification, value: strParam, requestType: .get, completion: { (result:Result<NotificationResponseModel?, Error>) in
            switch result {
            case .success(let respone):
                DispatchQueue.main.async {
                    self.totalNotificationCount = respone?.total_pages?.intValue ?? 0
                    let itemCount = respone?.res?.count ?? 0
                    if let listItems = respone?.res {
                        self.notificationList.append(contentsOf: listItems)
                    }
//                    if (self.notificationList.count > 0),
//                       let list = respone?.res, self.pageNo != 0 {
//                        self.notificationList.append(contentsOf: list)
//                    } else {
//                        self.notificationList = respone?.res ?? []
//
//                    }
                    self.notificationListFull = itemCount < self.pageSize
                    return completion(true, nil)
                }
            case .failure(let error):
                AppUtility.shared.printToConsole(error)
                return completion(false, error)
            }
        })
    }
    
    /// readUnreadNotification
    static func readUnreadNotification(notificationId:CLong, isRead:Int, completion: @escaping (_ result: Bool) -> Void) {
        let param:[String:Any] = ["notification_id":notificationId,
                                  "is_seen":isRead]
        APIService.shared.requestWithPost(resourceType: .readUnReadNotification, requestType: .post, queryParameters: param as NSDictionary) { (result:Result<GeneralWitoutData?, Error>) in
            switch result {
            case .success( _):
                return completion(true)
            case .failure(let error):
                AppUtility.shared.printToConsole(error)
                return completion(false)
            }
        }
    }
    func updateNotificationModel(by notificationId:CLong, isRead:Int) {
        DispatchQueue.main.async {
            self.notificationList = self.notificationList.map({ (obj) -> NotificationModel in
                if (obj.notficationId ?? 0) == notificationId {
                    obj.isRead = isRead
                }
                return obj
            })
        }        
    }
    
    func updateNotificationExpandProperties(by notificationId:CLong, isExpand:Bool) {
        DispatchQueue.main.async {
            self.notificationList = self.notificationList.map({ (obj) -> NotificationModel in
                if (obj.notficationId ?? 0) == notificationId {
                    obj.isExpand = isExpand
                }
                return obj
            })
        }
    }
    ///delete all notification
    func deleteAllNotification(value: String = "", completion: @escaping (_ result: Bool) -> Void) {
        APIService.shared.requestWithGet(resourceType: .deleteAllNotification, value: value, requestType: .get, completion: { (result:Result<GeneralWitoutData?, Error>) in
            switch result {
            case .success( _):
                DispatchQueue.main.async {
                    self.notificationListFull = true
                    self.totalNotificationCount = 0
                    self.pageNo = 0
                    self.notificationList = []
                    return completion(true)
                }
            case .failure(let error):
                AppUtility.shared.printToConsole(error)
                return completion(false)
            }
        })
    }
}
