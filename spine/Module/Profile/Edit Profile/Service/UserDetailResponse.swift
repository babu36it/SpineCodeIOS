//
//  UserDetailResponse.swift
//  spine
//
//  Created by Mac on 11/11/22.
//

import Foundation

struct UserDetailResponse: Decodable {
    let status: Bool
    let data: UserDetailResponseData
    let image: String
    let message: String
}

struct UserDetailResponseData: Decodable {
    let usersId: String
    let name: String
    let town: String
    let email: String
    let password: String
    let verificationPin: String
    let status: String
    let account: String
    let facebookId: String
    let facebookImage: String
    let socialLogin: String
    let deviceToken: String
    let lastLogin: String
    let verifyEmail: String
    let mobile: String
    let verifyMobile: String
    let referralCode: String
    let createdOn: String
    let updatedOn: String
    let notifyDeviceToken: String
    let userLatitude: String
    let userLongitude: String
    let notifyDeviceType: String
    let accountMode: String
    let bgImage: String
    let displayName: String
    let bio: String
    let category: String
    let website: String
    let contactEmail: String
    let businessPhone: String
    let businessAddress: String
    let address: String
    let isDelete: String
    let recoveryToken: String
    let impulseFollow: String
    let listingType: String
    let interested: String
    let offerDesciption: String
    let keyPerfomance: String
    let deseasePattern: String
    let languages: String
    let qualification: String
    let companyName: String
    let street1: String
    let street2: String
    let street3: String
    let city: String
    let postcode: String
    let country: String
    let metaverseAddress: String
    let businessMobile: String
    let categoryName: String
    let followersRecordsCount: String
    let followingRecordsCount: String
    let postRecordsCount: String
    let eventRecordsCount: String
    let podRecordsCount: String
    let userImage: String

    enum CodingKeys: String, CodingKey {
        case users_id = "users_id"
        case name = "name"
        case town = "town"
        case email = "email"
        case password = "password"
        case verification_pin = "verification_pin"
        case status = "status"
        case account = "account"
        case facebook_id = "facebook_id"
        case facebook_image = "facebook_image"
        case social_login = "social_login"
        case device_token = "device_token"
        case last_login = "last_login"
        case verify_email = "verify_email"
        case mobile = "mobile"
        case verify_mobile = "verify_mobile"
        case referral_code = "referral_code"
        case created_on = "created_on"
        case updated_on = "updated_on"
        case notify_device_token = "notify_device_token"
        case user_latitude = "user_latitude"
        case user_longitude = "user_longitude"
        case notify_device_type = "notify_device_type"
        case account_mode = "account_mode"
        case bg_image = "bg_image"
        case display_name = "display_name"
        case bio = "bio"
        case category = "category"
        case website = "website"
        case contact_email = "contact_email"
        case business_phone = "business_phone"
        case business_address = "business_address"
        case address = "address"
        case is_delete = "is_delete"
        case recovery_token = "recovery_token"
        case impulse_follow = "impulse_follow"
        case listing_type = "listing_type"
        case interested = "interested"
        case offer_desciption = "offer_desciption"
        case key_perfomance = "key_perfomance"
        case desease_pattern = "desease_pattern"
        case languages = "languages"
        case qualification = "qualification"
        case company_name = "company_name"
        case street_1 = "street_1"
        case street_2 = "street_2"
        case street_3 = "street_3"
        case city = "city"
        case postcode = "postcode"
        case country = "country"
        case metaverse_address = "metaverse_address"
        case business_mobile = "business_mobile"
        case category_name = "category_name"
        case followers_records_count = "followers_records_count"
        case following_records_count = "following_records_count"
        case post_records_count = "post_records_count"
        case event_records_count = "event_records_count"
        case pod_records_count = "pod_records_count"
        case user_image = "user_image"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        usersId = try values.decode(String.self, forKey: .users_id)
        name = try values.decode(String.self, forKey: .name)
        town = try values.decode(String.self, forKey: .town)
        email = try values.decode(String.self, forKey: .email)
        password = try values.decode(String.self, forKey: .password)
        verificationPin = try values.decode(String.self, forKey: .verification_pin)
        status = try values.decode(String.self, forKey: .status)
        account = try values.decode(String.self, forKey: .account)
        facebookId = try values.decode(String.self, forKey: .facebook_id)
        facebookImage = try values.decode(String.self, forKey: .facebook_image)
        socialLogin = try values.decode(String.self, forKey: .social_login)
        deviceToken = try values.decode(String.self, forKey: .device_token)
        lastLogin = try values.decode(String.self, forKey: .last_login)
        verifyEmail = try values.decode(String.self, forKey: .verify_email)
        mobile = try values.decode(String.self, forKey: .mobile)
        verifyMobile = try values.decode(String.self, forKey: .verify_mobile)
        referralCode = try values.decode(String.self, forKey: .referral_code)
        createdOn = try values.decode(String.self, forKey: .created_on)
        updatedOn = try values.decode(String.self, forKey: .updated_on)
        notifyDeviceToken = try values.decode(String.self, forKey: .notify_device_token)
        userLatitude = try values.decode(String.self, forKey: .user_latitude)
        userLongitude = try values.decode(String.self, forKey: .user_longitude)
        notifyDeviceType = try values.decode(String.self, forKey: .notify_device_type)
        accountMode = try values.decode(String.self, forKey: .account_mode)
        bgImage = try values.decode(String.self, forKey: .bg_image)
        displayName = try values.decode(String.self, forKey: .display_name)
        bio = try values.decode(String.self, forKey: .bio)
        category = try values.decode(String.self, forKey: .category)
        website = try values.decode(String.self, forKey: .website)
        contactEmail = try values.decode(String.self, forKey: .contact_email)
        businessPhone = try values.decode(String.self, forKey: .business_phone)
        businessAddress = try values.decode(String.self, forKey: .business_address)
        address = try values.decode(String.self, forKey: .address)
        isDelete = try values.decode(String.self, forKey: .is_delete)
        recoveryToken = try values.decode(String.self, forKey: .recovery_token)
        impulseFollow = try values.decode(String.self, forKey: .impulse_follow)
        listingType = try values.decode(String.self, forKey: .listing_type)
        interested = try values.decode(String.self, forKey: .interested)
        offerDesciption = try values.decode(String.self, forKey: .offer_desciption)
        keyPerfomance = try values.decode(String.self, forKey: .key_perfomance)
        deseasePattern = try values.decode(String.self, forKey: .desease_pattern)
        languages = try values.decode(String.self, forKey: .languages)
        qualification = try values.decode(String.self, forKey: .qualification)
        companyName = try values.decode(String.self, forKey: .company_name)
        street1 = try values.decode(String.self, forKey: .street_1)
        street2 = try values.decode(String.self, forKey: .street_2)
        street3 = try values.decode(String.self, forKey: .street_3)
        city = try values.decode(String.self, forKey: .city)
        postcode = try values.decode(String.self, forKey: .postcode)
        country = try values.decode(String.self, forKey: .country)
        metaverseAddress = try values.decode(String.self, forKey: .metaverse_address)
        businessMobile = try values.decode(String.self, forKey: .business_mobile)
        categoryName = try values.decode(String.self, forKey: .category_name)
        followersRecordsCount = try values.decode(String.self, forKey: .followers_records_count)
        followingRecordsCount = try values.decode(String.self, forKey: .following_records_count)
        postRecordsCount = try values.decode(String.self, forKey: .post_records_count)
        eventRecordsCount = try values.decode(String.self, forKey: .event_records_count)
        podRecordsCount = try values.decode(String.self, forKey: .pod_records_count)
        userImage = try values.decode(String.self, forKey: .user_image)
    }
}
