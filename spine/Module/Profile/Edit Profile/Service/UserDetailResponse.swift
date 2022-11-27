//
//  UserDetailResponse.swift
//  spine
//
//  Created by Mac on 11/11/22.
//

import Foundation

struct UserDetailResponseData: Codable {
    let usersID, name, town, email: String?
    let password, verificationPin, status, account: String?
    let facebookID, facebookImage, socialLogin, deviceToken: String?
    let lastLogin, verifyEmail, mobile, verifyMobile: String?
    let referralCode, createdOn, updatedOn, notifyDeviceToken: String?
    let userLatitude, userLongitude, notifyDeviceType, accountMode: String?
    let _bgImage, displayName, bio, category: String?
    let website, contactEmail, businessPhone, businessAddress: String?
    let address, isDelete, recoveryToken, impulseFollow: String?
    let listingType, interested, offerDesciption, keyPerfomance: String?
    let deseasePattern, languages, qualification, companyName: String?
    let street1, street2, street3, city: String?
    let postcode, country, metaverseAddress, businessMobile: String?
    let businessPhoneCode, businessMobileCode, defaultLanguageID, defaultCurrencyID: String?
    let verifyAccountStatus, documents, googleListing, wikipedia: String?
    let otherLink: String?
    let categoryName, followersRecordsCount, followingRecordsCount, postRecordsCount: String?
    let eventRecordsCount, podRecordsCount, _userImage: String?

    enum CodingKeys: String, CodingKey {
        case name, town, email, password, status, account, bio, category, website, mobile, documents, city, postcode, country, languages, qualification, interested, address, wikipedia
        case usersID = "users_id"
        case verificationPin = "verification_pin"
        case facebookID = "facebook_id"
        case facebookImage = "facebook_image"
        case socialLogin = "social_login"
        case deviceToken = "device_token"
        case lastLogin = "last_login"
        case verifyEmail = "verify_email"
        case verifyMobile = "verify_mobile"
        case referralCode = "referral_code"
        case createdOn = "created_on"
        case updatedOn = "updated_on"
        case notifyDeviceToken = "notify_device_token"
        case userLatitude = "user_latitude"
        case userLongitude = "user_longitude"
        case notifyDeviceType = "notify_device_type"
        case accountMode = "account_mode"
        case _bgImage = "bg_image"
        case displayName = "display_name"
        case contactEmail = "contact_email"
        case businessPhone = "business_phone"
        case businessAddress = "business_address"
        case isDelete = "is_delete"
        case recoveryToken = "recovery_token"
        case impulseFollow = "impulse_follow"
        case listingType = "listing_type"
        case offerDesciption = "offer_desciption"
        case keyPerfomance = "key_perfomance"
        case deseasePattern = "desease_pattern"
        case companyName = "company_name"
        case street1 = "street_1"
        case street2 = "street_2"
        case street3 = "street_3"
        case metaverseAddress = "metaverse_address"
        case businessMobile = "business_mobile"
        case businessPhoneCode = "business_phone_code"
        case businessMobileCode = "business_mobile_code"
        case defaultLanguageID = "default_language_id"
        case defaultCurrencyID = "default_currency_id"
        case verifyAccountStatus = "verify_account_status"
        case googleListing = "google_listing"
        case otherLink = "other_link"
        case categoryName = "category_name"
        case followersRecordsCount = "followers_records_count"
        case followingRecordsCount = "following_records_count"
        case postRecordsCount = "post_records_count"
        case eventRecordsCount = "event_records_count"
        case podRecordsCount = "pod_records_count"
        case _userImage = "user_image"
    }
}

extension APIResponseModel where T == UserDetailResponseData {
    var userImage: String? {
        if let image = image, let _userImage = data?._userImage {
            return "\(image)\(_userImage)"
        }
        return nil
    }
    var bgImage: String? {
        if let image = image, let _bgImage = data?._bgImage {
            return "\(image)\(_bgImage)"
        }
        return nil
    }
}
