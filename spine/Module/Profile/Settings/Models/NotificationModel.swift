//
//  NotificationModel.swift
//  spine
//
//  Created by Mac on 05/07/22.
//

import Foundation
import SwiftUI

class NotificationModel: ObservableObject {
    @AppStorage(C.UserDefKey.notf_push) var push = false
    @AppStorage(C.UserDefKey.notf_likes) var likes = false
    @AppStorage(C.UserDefKey.notf_comments) var comments = false
    @AppStorage(C.UserDefKey.notf_eventUpdate) var eventUpdate = false
    @AppStorage(C.UserDefKey.notf_eventRemindr) var eventReminder = false
    @AppStorage(C.UserDefKey.notf_msgMob) var msgMob = false
    @AppStorage(C.UserDefKey.notf_activity) var activity = false
    @AppStorage(C.UserDefKey.notf_impulse) var impulse = false
    @AppStorage(C.UserDefKey.notf_post) var post = false
    
    @AppStorage(C.UserDefKey.notf_email) var email = false
    @AppStorage(C.UserDefKey.notf_iCal) var iCal = false
    @AppStorage(C.UserDefKey.notf_msgEmail) var msgEmail = false
    @AppStorage(C.UserDefKey.notf_reply) var reply = false
    @AppStorage(C.UserDefKey.notf_suggested) var suggested = false
    @AppStorage(C.UserDefKey.notf_hqUpdate) var hqUpdate = false
    @AppStorage(C.UserDefKey.notf_hqSurvey) var hqSurvey = false
}
