//
//  HelperViews.swift
//  spine
//
//  Created by Mac on 22/05/22.
//

import Foundation
import SwiftUI


struct Kconstant {
    static let filterPadding: CGFloat = 60
}


struct C {
    struct PlaceHolder {
        static let select = "Select"
        static let language = "Select Language"
        static let category = "Select Category"
        static let timeZone = "Select Timezone"
        static let currency = "Currency"
        static let address = "Add address"
        static let dates = "Add dates"
        static let aboutEvent = "Who should join, and why? What will you do at your event? (minimum 50 characters)"
        static let postQuestion = "Post a question or share what’s on your mind"
        static let hashTags = "Enter up to 5 hastags, e.g. #lorem  #lorem"
        static let destWebsite = "Where your ad links to"
        static let promoteAd = "Add 1-2 lines of additional text to promote your ad"
        static let eventType = "Select event type"
        
        
        
        static let aboutEventprvTxt = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\n Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    }
    
    struct StaticText {
        static let deactivateAccntTitle = "Are you sure you want to deactivate your account?"
        static let deactivateAccntText = "Deactivating your account means no one will see your profile and saved posts. Only your activity, posts and other contribution will remain on Spine.\n\nf you decide to rejoine later, you can sign in with the same credentials to reactivate your account."
        static let deleteAccntTitle = "Want to delete your account for good?"
        static let deleteAccntText = "Deleting your account means you won’t be able to get your posts and saved content back. All of your Spine data will be deleted."
        
        static let verifyAccntTitle = "If you are a provider, you can be verified as a trusted provider by us"
        static let verifyAccntText = "Please send some information about yourself so that we can start the verification process. Needed:\n\nID\nTreatment certificates\nPublications"
        
        static let notf_push = "Get push notifications on your mobile for the notification types below."
        static let notf_likes = "Posts, events, podcasts, and comments I created."
        static let notf_comments = "Comments on posts, events, podcasts, and comments I created."
        static let notf_eventUpdate = "Get updates from the event host, changes to your reservation status, and reminders when the event you’ve signed up to is about to start."
        static let notf_eventRemindr = "Get a reminder one day before an event you saved starts."
        static let notf_msgMob = "Private messages from other members and hosts."
        static let notf_activity = "Get notified on all the activity from the members that you follow."
        static let notf_impulse = "Short inspirational messages and impulses by Spine."
        static let notf_post = "Get notified about every new post."
        
        static let notf_email = "Get email updates for the notification types you choose below."
        static let notf_iCal = "Send me email reminders with iCal attachements."
        static let notf_msgEmail = "Email me when someone sends me a message."
        //static let notf_reply = "notification_reply"
        static let notf_suggested = "Highlights based on your interests and history."
        static let notf_hqUpdate = "Tell me about new features and important Spine new."
        static let notf_hqSurvey = "Ask me about things that could make Spine better."
        
        static let findability = "Allow others to find me by my email address (without publicly displaying my email)"
        static let advertising = "Allow Spine to share my data to personalise my ad experience."
        static let customisation = "Allow Spine to use my cookies to personalise my content, and remember my account and regional preferences"
        static let necessary = "These tools are necessary for the app to function and can’t be switched off in our systems."
        static let privacyPolicy = "For details on how we securely use your data, see our Privacy Policy"
        static let loremText = "Lorem ipsum dolor sit amet dolor sit amet ipsum at de lorem ipsum dolor sit amet dolor sit amet."
    }
    
    struct UserDefKey {
        static let notf_push = "notification_push"
        static let notf_likes = "notification_likes"
        static let notf_comments = "notification_comments"
        static let notf_eventUpdate = "notification_eventUpdate"
        static let notf_eventRemindr = "notification_eventReminders"
        static let notf_msgMob = "notification_messagesMob"
        static let notf_activity = "notification_activity"
        static let notf_impulse = "notification_impulse"
        static let notf_post = "notification_post"
        
        static let notf_email = "notification_email"
        static let notf_iCal = "notification_iCal"
        static let notf_msgEmail = "notification_messagesEmail"
        static let notf_reply = "notification_reply"
        static let notf_suggested = "notification_suggested"
        static let notf_hqUpdate = "notification_hqUpdate"
        static let notf_hqSurvey = "notification_hqSurvey"
    }
    
}




struct BannerImageView: View {
    let image: String
    var heightF: Double = 2.0
    let screenWidth = UIScreen.main.bounds.size.width
    var body: some View {
        Image(image)
            .resizable()
            //.aspectRatio(contentMode: .fill)
            .frame(width: screenWidth, height: screenWidth/heightF)
    }
}

struct VideoThumbnailImage: View {
    let image: String
    let size: CGFloat
    var body: some View {
        ZStack {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height: size)
            Image(ImageName.playImageThumb)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size/2, height: size/2)
        }
        
    }
}


extension Notification.Name {
    static let clearDates = Notification.Name("cleardates")
}
