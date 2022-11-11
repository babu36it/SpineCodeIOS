//
//  SampleData.swift
//  spine
//
//  Created by Mac on 22/06/22.
//

import Foundation

struct EventDetail: Hashable {
    let isBanner: Bool
    var bannerImg: String = ""
    let eventType: EventType
    let title: String
    let location: String
    let time: String
    let days: String
    let cost: String
    let hostName: String
    let link: String
    let invitation: Invitation
    let date: String
}

let event1 = EventDetail(isBanner: false, eventType: .retreat, title: "Yoga Weekend - Reclaiming Your Centre", location: "Madrid, Spain", time: "", days: "2 days", cost: "$75", hostName: "Oliver", link: "", invitation: .none, date: "")
let event2 = EventDetail(isBanner: false, eventType: .online, title: "Lorem Ipsum dolor sit amet", location: "", time: "18.00-19.00", days: "", cost: "FREE", hostName: "Anna", link: "Link:www.abc.com", invitation: .none, date: "")
let event3 = EventDetail(isBanner: false, eventType: .retreat, title: "Lorem Ipsum dolor sit amet Lorem Ipsum dolor", location: "London, UK", time: "", days: "2 days", cost: "$70", hostName: "Tom", link: "", invitation: .none, date: "")
let event4 = EventDetail(isBanner: true, bannerImg: "ic_launch",  eventType: .online, title: "Sahaja yoga online Meditation", location: "", time: "", days: "", cost: "", hostName: "", link: "", invitation: .none, date: "")

let event5 = EventDetail(isBanner: false, eventType: .online, title: "Sahaja yoga online meditation centre", location: "", time: "18.00-19.00", days: "", cost: "FREE", hostName: "Chris", link: "Link:www.abc2.com", invitation: .notAccepted, date: "")
let event6 = EventDetail(isBanner: false, eventType: .online, title: "Sahaja yoga online meditation centre", location: "", time: "18.00-19.00", days: "", cost: "FREE", hostName: "Chris", link: "Link:www.abc2.com", invitation: .pending, date: "")
let event7 = EventDetail(isBanner: false, eventType: .online, title: "Lorem Ipsum dolor sit amet", location: "", time: "18.00-19.00", days: "", cost: "FREE", hostName: "Anna", link: "Link:www.abc.com", invitation: .accepted, date: "")
let event8 = EventDetail(isBanner: true, bannerImg: "podcastDetailBanner",  eventType: .retreat, title: "Yoga weekend Retreat - Reclaiming your Centre", location: "Madrid, Spain", time: "", days: "", cost: "", hostName: "", link: "", invitation: .none, date: "")
let event9 = EventDetail(isBanner: true, bannerImg: "magic-bowls",  eventType: .online, title: "Sahaja yoga online Meditation", location: "", time: "", days: "", cost: "", hostName: "", link: "", invitation: .none, date: "")


// comment model

struct Comment: Hashable {
    let id = UUID()
    let name: String
    var image: String = "Oval 5"
    let comment: String
    let replies: [Comment]
    var liked: Bool
}

let comment1 = Comment(name: "Anna", comment: "Lorem ipsum sit amet, set consecuter discipline ipsum sit amet", replies: [Comment(name: "Stephen1", comment: "Test message1", replies: [], liked: false), Comment(name: "Stephen2", comment: "Test messahe 2", replies: [], liked: false)], liked: false)
let comment2 = Comment(name: "Oliver", comment: "Lorem ipsum sit amet, set consecuter discipline ipsum sit amet2", replies: [Comment(name: "Mark", comment: "Test message 2", replies: [], liked: false)], liked: true)

let comment3  = Comment(name: "Stephen1", comment: "Lorem ipsum sit amet, set consecuter discipline ipsum sit amet", replies: [], liked: false)
let comment4  = Comment(name: "Stephen2", comment: "Lorem ipsum sit amet, set consecuter discipline ipsum sit amet", replies: [], liked: false)



struct Attendee: Hashable {
    let name: String
    var type: ProfileType = .personal
    var img: String
    var msgEn: Bool
}

let attendeeLst = [Attendee(name: "Craig Warner", img: "Oval 57", msgEn: true), Attendee(name: "Edvin Practitioner", type: .practitioner, img: "Oval 5", msgEn: false), Attendee(name: "Brendon Lewis", img: "Oval 57", msgEn: true), Attendee(name: "Harriet", img: "Oval 5", msgEn: false), Attendee(name: "Ralph", img: "Oval 57", msgEn: false), Attendee(name: "Estella", img: "Oval 5", msgEn: true), Attendee(name: "Mark Lenin", img: "Oval 57", msgEn: false), Attendee(name: "Edvin Det", img: "Oval 5", msgEn: false), Attendee(name: "David Warner", img: "Oval 57", msgEn: false), Attendee(name: "Steve smith", img: "Oval 5", msgEn: false), Attendee(name: "Shane watson", img: "Oval 57", msgEn: true), Attendee(name: "david Hussey", img: "Oval 5", msgEn: false) ]



//post details

enum PostType {
    case text
    case photo
    case video
}

struct PostDetail: Hashable {
    let postType: PostType
    var imgCount: Int = 0
    var img: String = ""
    var txt: String = ""
}
let txt1 = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incidi? Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incidi dolor sit ame"
let txt2 = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incidi? Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incidi dolor sit ame qhfwjhfg fhjfgwfg wjfg wjhfgw hjwg fjhgf fwjfg wjg gfweehjgwj wfgejwgfj wjfgjwhg wgwjfhgw egege gege dvdv dvdvd vdvdv dfvf dvdvv fdvdfvd vdvdvd vdvd vdfv dfvdf vdvdfv dvdfv dvdvd vdvd vdfvdf vfdv vd vd vberh hyhythty tybtb end"
let txt3 = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, end"


let posts: [PostDetail] = [
             PostDetail(postType: .photo, imgCount: 2, img: "magic-bowls"),
             PostDetail(postType: .video, imgCount: 0, img: "podcastDetailBanner"),
             PostDetail(postType: .photo, imgCount: 1, img: "thumbnail1"),
             PostDetail(postType: .text, imgCount: 0, txt: txt1),
             PostDetail(postType: .text, imgCount: 0, txt: txt1),
             PostDetail(postType: .text, imgCount: 0, txt: txt1),
            // PostDetail(postType: .video, imgCount: 0, img: "podcastDetailBanner")
]

let emptyPhotoPost = PostDetail(postType: .photo, imgCount: 0, img: "", txt: "")

struct SectionDetail: Hashable {
    let title: PostType
    let items: [PostDetail]
}


// chat view
struct Message: Identifiable, Codable {
    var id: String = UUID().uuidString
    let text: String
    let timeStamp: Date
    let isReceived: Bool
}

let msg1 = Message(text: "jhsgjda djagdjds fhjsjhfd sjhf dsjf jsdfjsdf j fsdjfh", timeStamp: Date(), isReceived: true)
let msg2 = Message(text: "jhsgjda djagdjds fhjsjhfd", timeStamp: Date(), isReceived: false)
let msg3 = Message(text: "jhsgjda djagdjds fhjsjhfd sjhf dsjf jsdfjsdf", timeStamp: Date(), isReceived: false)
let msg4 = Message(text: "jhsgjda djagdjds fhjsjhfd sjhf dsjf jsdfjsdf j fsdjfh sdfsd fsdfsdf", timeStamp: Date(), isReceived: true)
let msg5 = Message(text: "jhsgjda ", timeStamp: Date(), isReceived: true)
let msg6 = Message(text: "jhsgjda djagdjds fhjsjhfd sjhf dsjf jsdfjsdf j fsdjfh ds dwd dwdw weff frefer fefrefr fref eferfefr", timeStamp: Date(), isReceived: false)
let msg7 = Message(text: "jhsgjda djagdjds fhjsjhfd sjhf dsjf jsdfjsdf j fsdjfh ds dwd dwdw weff frefer fefrefr fref eferfefr", timeStamp: Date(), isReceived: true)
let msg8 = Message(text: "jhsgjda djagdjds fhjsjhfd sjhf dsjf jsdfjsdf j fsdjfh ds dwd dwdw weff frefer fefrefr ", timeStamp: Date(), isReceived: false)
let msg9 = Message(text: "jhsgjda djagdjds fhjsjhfd sjhf dsjf jsdfjsdf j fsdjfh", timeStamp: Date(), isReceived: true)
let msg10 = Message(text: "jhsgjda djagdjds fhjsjhfd", timeStamp: Date(), isReceived: false)
let msg11 = Message(text: "jhsgjda djagdjds fhjsjhfd sjhf dsjf jsdfjsdf", timeStamp: Date(), isReceived: false)
let msg12 = Message(text: "jhsgjda djagdjds fhjsjhfd sjhf dsjf jsdfjsdf j fsdjfh sdfsd fsdfsdf", timeStamp: Date(), isReceived: true)
let msg13 = Message(text: "jhsgjda ", timeStamp: Date(), isReceived: true)

let msgArr = [msg1, msg2, msg3, msg4, msg5, msg6, msg7, msg8, msg9, msg10, msg11, msg12, msg13]


//Feeds home

struct TextContentFormat {
    let title: String
    let descr: String
    let author: String
}
let format1 = TextContentFormat(title: "SPINE IMPULSE", descr: "Our future reality depends on what we do now, in this present moment", author: "UNKNOWN")
let format2 = TextContentFormat(title: "SPINE IMPULSE", descr: txt1, author: "UNKNOWN")

enum ContentType {
    case promotion
    case text
    case event
    case podcast
    case imageMultiple
    case spineImpulse
    case audio
}
struct FeedItemDetail: Identifiable {
    var id = UUID().uuidString
    let contentType: ContentType
    let profileImg: String
    let images: [String]
    let profTitle: String
    let profSubtitle: String
    let days: String
    let description: String
    var eventdetail: EventDetail?
    var imagetxt: TextContentFormat?
    var likes: Int = 0
    var comments: Int = 0
    var isNew = false
}

let feedItem1 = FeedItemDetail(contentType: .promotion, profileImg: "Oval 57", images: ["FeebBanner1"], profTitle: "Promoted by", profSubtitle: "Oliver Reese", days: "", description: txt1, likes: 2, comments: 3)
let feedItem2 = FeedItemDetail(contentType: .text, profileImg: "Oval 57", images: ["grayBanner"], profTitle: "", profSubtitle: "Sylvia Pole", days: "Today", description: "", imagetxt: format2, likes: 1, comments: 2)
let feedItem3 = FeedItemDetail(contentType: .event, profileImg: "Oval 57", images: ["FeedBanner3"], profTitle: "", profSubtitle: "Oliver Reese", days: "2 Days ago", description: txt1, eventdetail: event10, likes: 12, comments: 0, isNew: true)
let feedItem4 = FeedItemDetail(contentType: .event, profileImg: "Oval 57", images: ["FeedBanner5"], profTitle: "", profSubtitle: "Kavya Baily", days: "2 Days ago", description: txt1, eventdetail: event11, likes: 12, comments: 0, isNew: true)
let feedItem5 = FeedItemDetail(contentType: .podcast, profileImg: "Oval 57", images: ["FeedBanner5"], profTitle: "", profSubtitle: "Kavya Baily", days: "2 Days ago", description: txt1, eventdetail: event12, likes: 12, comments: 0, isNew: true)
let feedItem6 = FeedItemDetail(contentType: .imageMultiple, profileImg: "Oval 57", images: ["FeedBanner6","FeedBanner5"], profTitle: "", profSubtitle: "Kathy Liam", days: "2 Days ago", description: txt1, likes: 12, comments: 0, isNew: true)
let feedItem7 = FeedItemDetail(contentType: .spineImpulse, profileImg: "Oval 57", images: ["grayBanner"], profTitle: "", profSubtitle: "Spine", days: "Today", description: "", imagetxt: format1, likes: 1, comments: 2)
let feedItem8 = FeedItemDetail(contentType: .audio, profileImg: "Oval 57", images: ["TallBanner"], profTitle: "", profSubtitle: "Spine", days: "Today", description: txt1, imagetxt: format1, likes: 1, comments: 2)

let event10 = EventDetail(isBanner: false, bannerImg: "FeedBanner3", eventType: .retreat, title: "Yoga Weekend - Reclaiming Your Centre", location: "Madrid, Spain", time: "", days: "2 days", cost: "$75", hostName: "Oliver", link: "", invitation: .none, date: "")
let event11 = EventDetail(isBanner: false, bannerImg: "FeedBanner4", eventType: .online, title: "Sahaja Yoga Online Meditation", location: "Madrid, Spain", time: "19:00, 3hrs", days: "2 days", cost: "$75", hostName: "Oliver", link: "", invitation: .none, date: "08 May")
let event12 = EventDetail(isBanner: true, bannerImg: "FeedBanner5",  eventType: .retreat, title: "Yoga weekend Retreat - Reclaiming your Centre", location: "Madrid, Spain", time: "", days: "", cost: "", hostName: "", link: "", invitation: .none, date: "")


let feedList = [feedItem1, feedItem7, feedItem3, feedItem8, feedItem4, feedItem2, feedItem5, feedItem6]



struct StoryDetail: Hashable {
    let image: String
    let title: String
    let subTitle: String
    var storyImages: [String] = []
}

let story1 = StoryDetail(image: "Oval 5", title: "Sophia", subTitle: "Living with mental illness", storyImages: ["InstaStory", "ic_launch", "RetreatBanner"])
let story2 = StoryDetail(image: "Oval 57", title: "Sophia", subTitle: "Living with mental illness", storyImages: ["InstaStory", "ic_launch", "RetreatBanner"])
let story3 = StoryDetail(image: "ProfileImage3", title: "Sophia", subTitle: "Living with mental illness", storyImages: ["InstaStory", "ic_launch", "RetreatBanner"])
let story4 = StoryDetail(image: "ProfileImage5", title: "Sophia", subTitle: "Living with mental illness", storyImages: ["InstaStory", "ic_launch", "RetreatBanner"])
let story5 = StoryDetail(image: "Oval 5", title: "Sophi", subTitle: "Living with mental illness", storyImages: ["InstaStory", "ic_launch", "RetreatBanner"])
let story6 = StoryDetail(image: "Oval 57", title: "Sophiay", subTitle: "Living with mental illness", storyImages: ["InstaStory", "ic_launch", "RetreatBanner"])
let story7 = StoryDetail(image: "ProfileImage3", title: "Sophiz", subTitle: "Living with mental illness", storyImages: ["InstaStory", "ic_launch", "RetreatBanner"])
let story8 = StoryDetail(image: "ProfileImage5", title: "Sophiu", subTitle: "Living with mental illness", storyImages: ["InstaStory", "ic_launch", "RetreatBanner"])

