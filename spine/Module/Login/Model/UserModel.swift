
import Foundation
import ObjectMapper


// MARK: - signInRequestModel
class signInRequestModel: Mappable {
    
    private let Email             = "email"
    private let Password          = "password"
    private let DeviceToken       = "notify_device_token"
    private let DeviceType        = "notify_device_type"
    
    
    
    lazy var email              : String? = ""
    lazy var password           : String? = ""
    lazy var devicetype         : String? = ""
    lazy var devicetoken        : String? = ""
    
    
    required init(){ }
    required init?(map: Map) {}
    func mapping(map: Map) {
        email                 <- map[Email]
        password              <- map[Password]
        devicetype            <- map[DeviceType]
        devicetoken           <- map[DeviceToken]
    }
}

// MARK: - signInResponseModel
class signInResponseModel : NSObject, NSCoding, Mappable{
    
    var data : signInResponseData?
    var status: Bool?
    var token: String?
    var tokenType: String?
    var tokenExpiry: Int?
    var message: String?
    
    required override init(){}
    required init?(map: Map){}
    
    func mapping(map: Map)
    {
        data <- map["data"]
        status <- map["status"]
        token <- map["token"]
        tokenType <- map["token_type"]
        tokenExpiry <- map["expires_in"]
        message <- map["message"]
    }
    @objc required init(coder aDecoder: NSCoder)
    {
        data = aDecoder.decodeObject(forKey: "data") as? signInResponseData
        status = aDecoder.decodeObject(forKey: "status") as? Bool
        token = aDecoder.decodeObject(forKey: "token") as? String
        tokenType = aDecoder.decodeObject(forKey: "token_type") as? String
        tokenExpiry = aDecoder.decodeObject(forKey: "expires_in") as? Int
        message = aDecoder.decodeObject(forKey: "message") as? String
    }
    
    @objc func encode(with aCoder: NSCoder)
    {
        aCoder.encode(data, forKey: "data")
        aCoder.encode(status, forKey: "status")
        aCoder.encode(token, forKey: "token")
        aCoder.encode(tokenType, forKey: "token_type")
        aCoder.encode(tokenExpiry, forKey: "expires_in")
        aCoder.encode(message, forKey: "message")
    }
    func save() -> Void {
        //UserDefaults.standard.set(self.token, forKey: "token")
        AppUtility.shared.userSettings.authToken = self.token ?? ""
    }
    
    class func remove() -> Void {
        //UserDefaults.standard.removeObject(forKey: "token")
        AppUtility.shared.userSettings.authToken = ""
        StandardUserDefaults.synchronize()
    }
    
    static func loggedInUser() -> signInResponseModel? {
        let user = StandardUserDefaults.getCustomObject(key: K.Key.loggedInUser) as? signInResponseModel
        return user
    }
    
    static func isUserLoggedIn() -> Bool {
        if let token = UserDefaults.standard.string(forKey: "token"), token != "" {
            return true
        }
        return false
    }
    
    static func loggedInUserId() -> String? {
        let user = StandardUserDefaults.getCustomObject(key: K.Key.loggedInUser) as? signInResponseModel
        return ""//user?.data?.usersId
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

class signInResponseData : NSObject, NSCoding, Mappable{

    var account : String?
    var accountMode : String?
    var address : AnyObject?
    var bgImage : AnyObject?
    var bio : AnyObject?
    var businessAddress : String?
    var businessPhone : AnyObject?
    var category : String?
    var contactEmail : AnyObject?
    var createdOn : String?
    var deviceToken : AnyObject?
    var displayName : String?
    var email : String?
    var facebookId : AnyObject?
    var facebookImage : AnyObject?
    var impulseFollow : String?
    var isDelete : String?
    var lastLogin : AnyObject?
    var name : String?
    var notifyDeviceToken : AnyObject?
    var notifyDeviceType : AnyObject?
    var password : String?
    var profileImage : String?
    var profilePic : AnyObject?
    var recoveryToken : AnyObject?
    var referralCode : String?
    var socialLogin : String?
    var status : String?
    var town : String?
    var updatedOn : AnyObject?
    var userLatitude : String?
    var userLongitude : String?
    var usersId : String?
    var verificationPin : String?
    var verifyEmail : String?
    var website : AnyObject?


    required override init(){ }
    required init?(map: Map) {}
    func mapping(map: Map)
    {
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
        profileImage <- map["profile_image"]
        profilePic <- map["profile_pic"]
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
        
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
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
         profileImage = aDecoder.decodeObject(forKey: "profile_image") as? String
         profilePic = aDecoder.decodeObject(forKey: "profile_pic") as? AnyObject
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

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
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
        if profileImage != nil{
            aCoder.encode(profileImage, forKey: "profile_image")
        }
        if profilePic != nil{
            aCoder.encode(profilePic, forKey: "profile_pic")
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

    }

}
// MARK: - signInRequestModel
class signUpRequestModel: Mappable {
    
    private let Email             = "email"
    private let Password          = "password"
    private let Town              = "town"
    private let Name              = "name"
    private let Userip            = "user_ip"
    private let UserLatitude      = "user_latitude"
    private let UserLongitude     = "user_longitude"
    
    
    
    lazy var email              : String? = ""
    lazy var password           : String? = ""
    lazy var town               : String? = ""
    lazy var name               : String? = ""
    lazy var userip             : String? = ""
    lazy var latitude           : String? = ""
    lazy var longitude          : String? = ""
    
    
    required init(){ }
    required init?(map: Map) {}
    func mapping(map: Map) {
        email                 <- map[Email]
        password              <- map[Password]
        town                  <- map[Town]
        name                  <- map[Name]
        userip                <- map[Userip]
        latitude              <- map[UserLatitude]
        longitude             <- map[UserLongitude]
    }
}


// MARK: - forgotPasswordRequestModel
class forgotPasswordRequestModel: Mappable {
    
    private let Email             = "email"
    
    lazy var email              : String? = ""
     
    
    required init(){ }
    required init?(map: Map) {}
    func mapping(map: Map) {
        email                 <- map[Email]
     }
}
// MARK: - forgotPasswordResponseModel
class forgotPasswordResponseModel :  Mappable{

    var message : String?
    var status : Bool?
    
    required init(){ }
    required init?(map: Map) {}
    func mapping(map: Map) {
        message <- map["message"]
        status <- map["status"]
    }
}
// MARK: - signInRequestModel
class mobileVerificationRequestModel: Mappable {
    
    private let Mobile             = "mobile_no"
    private let UserID             = "user_id"
    
    lazy var mobile              : String? = ""
    lazy var userID              : String? = ""
    
    required init(){ }
    required init?(map: Map) {}
    func mapping(map: Map) {
        mobile                 <- map[Mobile]
        userID                 <- map[UserID]
     }
}

// MARK: -socialLoginRequestModel
class socialLoginRequestModel: Mappable {
    
    private let Email             = "email"
    private let Name              = "name"
    private let UserLatitude      = "user_latitude"
    private let UserLongitude     = "user_longitude"
    private let FacebokId         = "facebook_id"
    private let DeviceToken       = "device_token"
    private let NotifyToken       = "notify_device_token"
    private let NotifyDeviceType  = "notify_device_type"
    

    
    lazy var email              : String? = ""
    lazy var name               : String? = ""
    lazy var latitude           : String? = ""
    lazy var longitude          : String? = ""
    lazy var facebookId         : String? = ""
    lazy var devicetoken        : String? = ""
    lazy var notifytoken        : String? = ""
    lazy var notifydevicetype   : String? = ""
    
    required init(){ }
    required init?(map: Map) {}
    func mapping(map: Map) {
        email                 <- map[Email]
        name                  <- map[Name]
        latitude              <- map[UserLatitude]
        longitude             <- map[UserLongitude]
        facebookId            <- map[FacebokId]
        devicetoken           <- map[DeviceToken]
        notifytoken           <- map[NotifyToken]
        notifydevicetype      <- map[NotifyDeviceType]
    }
}
