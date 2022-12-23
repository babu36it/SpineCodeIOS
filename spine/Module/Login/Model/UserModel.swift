
import Foundation
import ObjectMapper

// MARK: - SignInRequestModel
class SignInRequestModel: Mappable {
    
    private let Email = "email"
    private let Password = "password"
    private let DeviceToken = "notify_device_token"
    private let DeviceType = "notify_device_type"

    lazy var email: String? = ""
    lazy var password: String? = ""
    lazy var devicetype: String? = ""
    lazy var devicetoken: String? = ""

    required init() { }
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        email <- map[Email]
        password <- map[Password]
        devicetype <- map[DeviceType]
        devicetoken <- map[DeviceToken]
    }
}

// MARK: - SignInResponseModel
class SignInResponseModel: NSObject, NSCoding, Mappable{
    var data: SignInResponseData?
    var status: Bool?
    var token: String?
    var tokenType: String?
    var tokenExpiry: Int?
    var imagePath: String?
    var message: String?
    
    required override init() { }
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        data <- map["data"]
        status <- map["status"]
        token <- map["token"]
        tokenType <- map["token_type"]
        tokenExpiry <- map["expires_in"]
        imagePath <- map["image"]
        message <- map["message"]
    }
    
    @objc required init(coder aDecoder: NSCoder) {
        data = aDecoder.decodeObject(forKey: "data") as? SignInResponseData
        status = aDecoder.decodeObject(forKey: "status") as? Bool
        token = aDecoder.decodeObject(forKey: "token") as? String
        tokenType = aDecoder.decodeObject(forKey: "token_type") as? String
        tokenExpiry = aDecoder.decodeObject(forKey: "expires_in") as? Int
        imagePath = aDecoder.decodeObject(forKey: "image") as? String
        message = aDecoder.decodeObject(forKey: "message") as? String
    }
    
    @objc func encode(with aCoder: NSCoder) {
        aCoder.encode(data, forKey: "data")
        aCoder.encode(status, forKey: "status")
        aCoder.encode(token, forKey: "token")
        aCoder.encode(tokenType, forKey: "token_type")
        aCoder.encode(tokenExpiry, forKey: "expires_in")
        aCoder.encode(imagePath, forKey: "image")
        aCoder.encode(message, forKey: "message")
    }
}

extension SignInResponseModel {
    func save() {
        AppUtility.shared.updateUserInfo(self)
        if let jsonData: Data = self.toJSONString()?.data(using: .utf8) {
            KeychainHelper.shared.save(jsonData, forKey: "UserInformation")
        }
    }
    
    class func retrieve() -> SignInResponseModel? {
        if let jsonData: Data = KeychainHelper.shared.readData(forKey: "UserInformation"), let jsonString: String = String(data: jsonData, encoding: .utf8) {
            return SignInResponseModel(JSONString: jsonString)
        }
        return nil
    }
    
    class func remove() {
        KeychainHelper.shared.delete(forKey: "UserInformation")
    }
    
    var profileImage: String? {
        if let userImage: String = data?.userImage, let imagePath: String = imagePath, !userImage.isEmpty, !imagePath.isEmpty {
            return imagePath + userImage
        }
        return nil
    }
    
    var followersCount: String {
        let followers: Int = Int(data?.followerRecordCount ?? "0") ?? 0
        return followers.formatUsingAbbrevation()
    }
    
    var followingCount: String {
        let followings: Int = Int(data?.followingRecordCount ?? "0") ?? 0
        return followings.formatUsingAbbrevation()
    }

}

/*
class signInResponseModel :  NSObject, NSCoding, Mappable{
    
    var data : signInResponseData?
    var message : String?
    var status : Bool?
    
    required override init(){}
    required init?(map: Map){}
    
    func mapping(map: Map)
    {
        data <- map["data"]
        message <- map["message"]
        status <- map["status"]
    }
    @objc required init(coder aDecoder: NSCoder)
    {
        data = aDecoder.decodeObject(forKey: "data") as? signInResponseData
        message = aDecoder.decodeObject(forKey: "message") as? String
        status = aDecoder.decodeObject(forKey: "status") as? Bool
        
    }
    
    @objc func encode(with aCoder: NSCoder)
    {
        aCoder.encode(data, forKey: "data")
        aCoder.encode(message, forKey: "message")
        aCoder.encode(status, forKey: "status")
    }
    func save() -> Void {
        StandardUserDefaults.setCustomObject(obj: self, key: K.Key.loggedInUser)
    }
    class func remove() -> Void {
        StandardUserDefaults.removeObject(forKey: K.Key.loggedInUser)
        StandardUserDefaults.synchronize()
    }
    static func loggedInUser() -> signInResponseModel? {
        let user = StandardUserDefaults.getCustomObject(key: K.Key.loggedInUser) as? signInResponseModel
        return user
    }
    
    static func isUserLoggedIn() -> Bool {
        return signInResponseModel.loggedInUser()?.data?.usersId?.isValid ?? false
    }
    
    static func loggedInUserId() -> String? {
        let user = StandardUserDefaults.getCustomObject(key: K.Key.loggedInUser) as? signInResponseModel
        return user?.data?.usersId
    }
}
 */

// MARK: - signInResponseData
class SignInResponseData : NSObject, NSCoding, Mappable{
    var account: String?
    var accountMode: String?
    var address: AnyObject?
    var bgImage: AnyObject?
    var bio: AnyObject?
    var businessAddress: String?
    var businessPhone: AnyObject?
    var businessMobile: String?
    var businessMobileCode: String?
    var businessPhoneCode: String?
    var category: String?
    var categoryName: String?
    var city: String?
    var companyName: String?
    var contactEmail: AnyObject?
    var country: String?
    var createdOn: String?
    var defaultCurrencyID: String?
    var defaultLanguageID: String?
    var deseasePattern: String?
    var deviceToken: AnyObject?
    var displayName: String?
    var documents: String?
    var email: String?
    var eventRecordsCount: String?
    var facebookId: AnyObject?
    var facebookImage: AnyObject?
    var followerRecordCount: String?
    var followingRecordCount: String?
    var googleListing: String?
    var impulseFollow: String?
    var interested: String?
    var isDelete: String?
    var keyPerformance: String?
    var languages: String?
    var lastLogin: AnyObject?
    var listingType: String?
    var metaverseAddress: String?
    var mobile: String?
    var name: String?
    var notifyDeviceToken: AnyObject?
    var notifyDeviceType: AnyObject?
    var offerDescription: String?
    var otherLink: String?
    var password: String?
    var podRecordsCount: String?
    var postRecordsCount: String?
    var postCode: String?
    var qualification: String?
    var recoveryToken: AnyObject?
    var referralCode: String?
    var socialLogin: String?
    var status: String?
    var street1: String?
    var street2: String?
    var street3: String?
    var town: String?
    var updatedOn: AnyObject?
    var userImage: String?
    var userLatitude: String?
    var userLongitude: String?
    var usersId: String?
    var verificationPin: String?
    var verifyAccountStatus: String?
    var verifyEmail: String?
    var verifyMobile: String?
    var website: AnyObject?
    var wikipedia: String?

    required override init() { }
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        account <- map["account"]
        accountMode <- map["account_mode"]
        address <- map["address"]
        bgImage <- map["bg_image"]
        bio <- map["bio"]
        businessAddress <- map["business_address"]
        businessPhone <- map["business_phone"]
        category <- map["category"]
        contactEmail <- map["contact_email"]
        createdOn <- map["created_on"]
        deviceToken <- map["device_token"]
        displayName <- map["display_name"]
        email <- map["email"]
        facebookId <- map["facebook_id"]
        facebookImage <- map["facebook_image"]
        impulseFollow <- map["impulse_follow"]
        isDelete <- map["is_delete"]
        lastLogin <- map["last_login"]
        name <- map["name"]
        notifyDeviceToken <- map["notify_device_token"]
        notifyDeviceType <- map["notify_device_type"]
        password <- map["password"]
        recoveryToken <- map["recovery_token"]
        referralCode <- map["referral_code"]
        socialLogin <- map["social_login"]
        status <- map["status"]
        town <- map["town"]
        updatedOn <- map["updated_on"]
        userLatitude <- map["user_latitude"]
        userLongitude <- map["user_longitude"]
        usersId <- map["users_id"]
        verificationPin <- map["verification_pin"]
        verifyEmail <- map["verify_email"]
        website <- map["website"]
        languages <- map["languages"]
        defaultLanguageID <- map["default_language_id"]
        defaultCurrencyID <- map["default_currency_id"]
        businessMobileCode <- map["business_mobile_code"]
        businessPhoneCode <- map["business_phone_code"]
        categoryName <- map["category_name"]
        city <- map["city"]
        companyName <- map["company_name"]
        country <- map["country"]
        deseasePattern <- map["desease_pattern"]
        documents <- map["documents"]
        eventRecordsCount <- map["event_records_count"]
        followerRecordCount <- map["followers_records_count"]
        followingRecordCount <- map["following_records_count"]
        googleListing <- map["google_listing"]
        interested <- map["interested"]
        keyPerformance <- map["key_perfomance"]
        languages <- map["languages"]
        listingType <- map["listing_type"]
        metaverseAddress <- map["metaverse_address"]
        mobile <- map["mobile"]
        offerDescription <- map["offer_desciption"]
        otherLink <- map["other_link"]
        podRecordsCount <- map["pod_records_count"]
        postRecordsCount <- map["post_records_count"]
        postCode <- map["postcode"]
        qualification <- map["qualification"]
        street1 <- map["street_1"]
        street2 <- map["street_2"]
        street3 <- map["street_3"]
        userImage <- map["user_image"]
        verifyAccountStatus <- map["verify_account_status"]
        verifyMobile <- map["verify_mobile"]
        wikipedia <- map["wikipedia"]
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder) {
        account = aDecoder.decodeObject(forKey: "account") as? String
        accountMode = aDecoder.decodeObject(forKey: "account_mode") as? String
        address = aDecoder.decodeObject(forKey: "address") as? AnyObject
        bgImage = aDecoder.decodeObject(forKey: "bg_image") as? AnyObject
        bio = aDecoder.decodeObject(forKey: "bio") as? AnyObject
        businessAddress = aDecoder.decodeObject(forKey: "business_address") as? String
        businessPhone = aDecoder.decodeObject(forKey: "business_phone") as? AnyObject
        category = aDecoder.decodeObject(forKey: "category") as? String
        contactEmail = aDecoder.decodeObject(forKey: "contact_email") as? AnyObject
        createdOn = aDecoder.decodeObject(forKey: "created_on") as? String
        deviceToken = aDecoder.decodeObject(forKey: "device_token") as? AnyObject
        displayName = aDecoder.decodeObject(forKey: "display_name") as? String
        email = aDecoder.decodeObject(forKey: "email") as? String
        facebookId = aDecoder.decodeObject(forKey: "facebook_id") as? AnyObject
        facebookImage = aDecoder.decodeObject(forKey: "facebook_image") as? AnyObject
        impulseFollow = aDecoder.decodeObject(forKey: "impulse_follow") as? String
        isDelete = aDecoder.decodeObject(forKey: "is_delete") as? String
        lastLogin = aDecoder.decodeObject(forKey: "last_login") as? AnyObject
        name = aDecoder.decodeObject(forKey: "name") as? String
        notifyDeviceToken = aDecoder.decodeObject(forKey: "notify_device_token") as? AnyObject
        notifyDeviceType = aDecoder.decodeObject(forKey: "notify_device_type") as? AnyObject
        password = aDecoder.decodeObject(forKey: "password") as? String
        recoveryToken = aDecoder.decodeObject(forKey: "recovery_token") as? AnyObject
        referralCode = aDecoder.decodeObject(forKey: "referral_code") as? String
        socialLogin = aDecoder.decodeObject(forKey: "social_login") as? String
        status = aDecoder.decodeObject(forKey: "status") as? String
        town = aDecoder.decodeObject(forKey: "town") as? String
        updatedOn = aDecoder.decodeObject(forKey: "updated_on") as? AnyObject
        userLatitude = aDecoder.decodeObject(forKey: "user_latitude") as? String
        userLongitude = aDecoder.decodeObject(forKey: "user_longitude") as? String
        usersId = aDecoder.decodeObject(forKey: "users_id") as? String
        verificationPin = aDecoder.decodeObject(forKey: "verification_pin") as? String
        verifyEmail = aDecoder.decodeObject(forKey: "verify_email") as? String
        website = aDecoder.decodeObject(forKey: "website") as? AnyObject
        languages = aDecoder.decodeObject(forKey: "languages") as? String
        defaultLanguageID = aDecoder.decodeObject(forKey: "default_language_id") as? String
        defaultCurrencyID = aDecoder.decodeObject(forKey: "default_currency_id") as? String
        businessMobileCode = aDecoder.decodeObject(forKey: "business_mobile_code") as? String
        businessPhoneCode = aDecoder.decodeObject(forKey: "business_phone_code") as? String
        categoryName = aDecoder.decodeObject(forKey: "category_name") as? String
        city = aDecoder.decodeObject(forKey: "city") as? String
        companyName = aDecoder.decodeObject(forKey: "company_name") as? String
        country = aDecoder.decodeObject(forKey: "country") as? String
        deseasePattern = aDecoder.decodeObject(forKey: "desease_pattern") as? String
        documents = aDecoder.decodeObject(forKey: "documents") as? String
        eventRecordsCount = aDecoder.decodeObject(forKey: "event_records_count") as? String
        followerRecordCount = aDecoder.decodeObject(forKey: "followers_records_count") as? String
        followingRecordCount = aDecoder.decodeObject(forKey: "following_records_count") as? String
        googleListing = aDecoder.decodeObject(forKey: "google_listing") as? String
        interested = aDecoder.decodeObject(forKey: "interested") as? String
        keyPerformance = aDecoder.decodeObject(forKey: "key_perfomance") as? String
        languages = aDecoder.decodeObject(forKey: "languages") as? String
        listingType = aDecoder.decodeObject(forKey: "listing_type") as? String
        metaverseAddress = aDecoder.decodeObject(forKey: "metaverse_address") as? String
        mobile = aDecoder.decodeObject(forKey: "mobile") as? String
        offerDescription = aDecoder.decodeObject(forKey: "offer_desciption") as? String
        otherLink = aDecoder.decodeObject(forKey: "other_link") as? String
        podRecordsCount = aDecoder.decodeObject(forKey: "pod_records_count") as? String
        postRecordsCount = aDecoder.decodeObject(forKey: "post_records_count") as? String
        postCode = aDecoder.decodeObject(forKey: "postcode") as? String
        qualification = aDecoder.decodeObject(forKey: "qualification") as? String
        street1 = aDecoder.decodeObject(forKey: "street_1") as? String
        street2 = aDecoder.decodeObject(forKey: "street_2") as? String
        street3 = aDecoder.decodeObject(forKey: "street_3") as? String
        userImage = aDecoder.decodeObject(forKey: "user_image") as? String
        verifyAccountStatus = aDecoder.decodeObject(forKey: "verify_account_status") as? String
        verifyMobile = aDecoder.decodeObject(forKey: "verify_mobile") as? String
        wikipedia = aDecoder.decodeObject(forKey: "wikipedia") as? String
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder) {
        if account != nil{
            aCoder.encode(account, forKey: "account")
        }
        if accountMode != nil{
            aCoder.encode(accountMode, forKey: "account_mode")
        }
        if address != nil{
            aCoder.encode(address, forKey: "address")
        }
        if bgImage != nil{
            aCoder.encode(bgImage, forKey: "bg_image")
        }
        if bio != nil{
            aCoder.encode(bio, forKey: "bio")
        }
        if businessAddress != nil{
            aCoder.encode(businessAddress, forKey: "business_address")
        }
        if businessPhone != nil{
            aCoder.encode(businessPhone, forKey: "business_phone")
        }
        if category != nil{
            aCoder.encode(category, forKey: "category")
        }
        if contactEmail != nil{
            aCoder.encode(contactEmail, forKey: "contact_email")
        }
        if createdOn != nil{
            aCoder.encode(createdOn, forKey: "created_on")
        }
        if deviceToken != nil{
            aCoder.encode(deviceToken, forKey: "device_token")
        }
        if displayName != nil{
            aCoder.encode(displayName, forKey: "display_name")
        }
        if email != nil{
            aCoder.encode(email, forKey: "email")
        }
        if facebookId != nil{
            aCoder.encode(facebookId, forKey: "facebook_id")
        }
        if facebookImage != nil{
            aCoder.encode(facebookImage, forKey: "facebook_image")
        }
        if impulseFollow != nil{
            aCoder.encode(impulseFollow, forKey: "impulse_follow")
        }
        if isDelete != nil{
            aCoder.encode(isDelete, forKey: "is_delete")
        }
        if lastLogin != nil{
            aCoder.encode(lastLogin, forKey: "last_login")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if notifyDeviceToken != nil{
            aCoder.encode(notifyDeviceToken, forKey: "notify_device_token")
        }
        if notifyDeviceType != nil{
            aCoder.encode(notifyDeviceType, forKey: "notify_device_type")
        }
        if password != nil{
            aCoder.encode(password, forKey: "password")
        }
        if recoveryToken != nil{
            aCoder.encode(recoveryToken, forKey: "recovery_token")
        }
        if referralCode != nil{
            aCoder.encode(referralCode, forKey: "referral_code")
        }
        if socialLogin != nil{
            aCoder.encode(socialLogin, forKey: "social_login")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if town != nil{
            aCoder.encode(town, forKey: "town")
        }
        if updatedOn != nil{
            aCoder.encode(updatedOn, forKey: "updated_on")
        }
        if userLatitude != nil{
            aCoder.encode(userLatitude, forKey: "user_latitude")
        }
        if userLongitude != nil{
            aCoder.encode(userLongitude, forKey: "user_longitude")
        }
        if usersId != nil{
            aCoder.encode(usersId, forKey: "users_id")
        }
        if verificationPin != nil{
            aCoder.encode(verificationPin, forKey: "verification_pin")
        }
        if verifyEmail != nil{
            aCoder.encode(verifyEmail, forKey: "verify_email")
        }
        if website != nil{
            aCoder.encode(website, forKey: "website")
        }
        if languages != nil{
            aCoder.encode(languages, forKey: "languages")
        }
        if defaultLanguageID != nil{
            aCoder.encode(defaultLanguageID, forKey: "default_language_id")
        }
        if defaultCurrencyID != nil{
            aCoder.encode(defaultCurrencyID, forKey: "default_currency_id")
        }
        if businessMobileCode != nil {
            aCoder.encode(businessMobileCode, forKey: "business_mobile_code")
        }
        if businessPhoneCode != nil {
            aCoder.encode(businessPhoneCode, forKey: "business_phone_code")
        }
        if categoryName != nil {
            aCoder.encode(categoryName, forKey: "category_name")
        }
        if city != nil {
            aCoder.encode(city, forKey: "city")
        }
        if companyName != nil {
            aCoder.encode(companyName, forKey: "company_name")
        }
        if country != nil {
            aCoder.encode(country, forKey: "country")
        }
        if deseasePattern != nil {
            aCoder.encode(deseasePattern, forKey: "desease_pattern")
        }
        if documents != nil {
            aCoder.encode(documents, forKey: "documents")
        }
        if eventRecordsCount != nil {
            aCoder.encode(eventRecordsCount, forKey: "event_records_count")
        }
        if followerRecordCount != nil {
            aCoder.encode(followerRecordCount, forKey: "followers_records_count")
        }
        if followingRecordCount != nil {
            aCoder.encode(followingRecordCount, forKey: "following_records_count")
        }
        if googleListing != nil {
            aCoder.encode(googleListing, forKey: "google_listing")
        }
        if interested != nil {
            aCoder.encode(interested, forKey: "interested")
        }
        if keyPerformance != nil {
            aCoder.encode(keyPerformance, forKey: "key_perfomance")
        }
        if languages != nil {
            aCoder.encode(languages, forKey: "languages")
        }
        if listingType != nil {
            aCoder.encode(listingType, forKey: "listing_type")
        }
        if metaverseAddress != nil {
            aCoder.encode(metaverseAddress, forKey: "metaverse_address")
        }
        if mobile != nil {
            aCoder.encode(mobile, forKey: "mobile")
        }
        if offerDescription != nil {
            aCoder.encode(offerDescription, forKey: "offer_desciption")
        }
        if otherLink != nil {
            aCoder.encode(otherLink, forKey: "other_link")
        }
        if podRecordsCount != nil {
            aCoder.encode(podRecordsCount, forKey: "pod_records_count")
        }
        if postRecordsCount != nil {
            aCoder.encode(postRecordsCount, forKey: "post_records_count")
        }
        if postCode != nil {
            aCoder.encode(postCode, forKey: "postcode")
        }
        if qualification != nil {
            aCoder.encode(qualification, forKey: "qualification")
        }
        if street1 != nil {
            aCoder.encode(street1, forKey: "street_1")
        }
        if street2 != nil {
            aCoder.encode(street2, forKey: "street_2")
        }
        if street3 != nil {
            aCoder.encode(street3, forKey: "street_3")
        }
        if userImage != nil {
            aCoder.encode(userImage, forKey: "user_image")
        }
        if verifyAccountStatus != nil {
            aCoder.encode(verifyAccountStatus, forKey: "verify_account_status")
        }
        if verifyMobile != nil {
            aCoder.encode(verifyMobile, forKey: "verify_mobile")
        }
        if wikipedia != nil {
            aCoder.encode(wikipedia, forKey: "wikipedia")
        }
    }
}

// MARK: - SignInRequestModel
class SignUpRequestModel: Mappable {
    private let Email = "email"
    private let Password = "password"
    private let Town = "town"
    private let Name = "name"
    private let Userip = "user_ip"
    private let UserLatitude = "user_latitude"
    private let UserLongitude = "user_longitude"

    lazy var email: String? = ""
    lazy var password: String? = ""
    lazy var town: String? = ""
    lazy var name: String? = ""
    lazy var userip: String? = ""
    lazy var latitude: String? = ""
    lazy var longitude: String? = ""

    required init() { }
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        email <- map[Email]
        password <- map[Password]
        town <- map[Town]
        name <- map[Name]
        userip <- map[Userip]
        latitude <- map[UserLatitude]
        longitude <- map[UserLongitude]
    }
}

// MARK: - ForgotPasswordRequestModel
class ForgotPasswordRequestModel: Mappable {
    private let Email = "email"
    lazy var email: String? = ""

    required init() { }
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        email <- map[Email]
     }
}

// MARK: - ForgotPasswordResponseModel
class ForgotPasswordResponseModel:  Mappable{
    var message: String?
    var status: Bool?
    
    required init() { }
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        message <- map["message"]
        status <- map["status"]
    }
}

// MARK: - MobileVerificationRequestModel
class MobileVerificationRequestModel: Mappable {
    private let Mobile = "mobile_no"
    private let UserID = "user_id"
    
    lazy var mobile: String? = ""
    lazy var userID: String? = ""
    
    required init() { }
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        mobile <- map[Mobile]
        userID <- map[UserID]
     }
}

// MARK: - SocialLoginRequestModel
class SocialLoginRequestModel: Mappable {
    private let Email = "email"
    private let Name = "name"
    private let UserLatitude = "user_latitude"
    private let UserLongitude = "user_longitude"
    private let FacebokId = "facebook_id"
    private let DeviceToken = "device_token"
    private let NotifyToken = "notify_device_token"
    private let NotifyDeviceType = "notify_device_type"
    
    lazy var email: String? = ""
    lazy var name: String? = ""
    lazy var latitude: String? = ""
    lazy var longitude: String? = ""
    lazy var facebookId: String? = ""
    lazy var devicetoken: String? = ""
    lazy var notifytoken: String? = ""
    lazy var notifydevicetype: String? = ""
    
    required init() { }
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        email <- map[Email]
        name <- map[Name]
        latitude <- map[UserLatitude]
        longitude <- map[UserLongitude]
        facebookId <- map[FacebokId]
        devicetoken <- map[DeviceToken]
        notifytoken <- map[NotifyToken]
        notifydevicetype <- map[NotifyDeviceType]
    }
}
