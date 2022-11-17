//
//  Constant.swift
//  spine


import Foundation
import SwiftUI

enum ImageName {
    //custom
    static let playImageThumb = "PlayImageThumb"
    static let ic_heart = "ic_heart"
    static let ic_message = "ic_message"
    static let ic_leftarrow = "ic_leftarrow"
    static let ic_bookmark = "ic_bookmark"
    static let ic_threedot = "ic_threedot"
    static let ic_background = "ic_background"
    static let ic_launch = "ic_launch"
    static let ic_search = "ic_search"
    static let ic_close = "ic_close"
    static let ic_rightarrow = "ic_rightarrow"
    static let ic_back = "ic_back"
    static let sample1 = "sample1"
    static let sample2 = "sample2"
    static let sample3 = "sample3"
    static let podcastDetailBanner = "podcastDetailBanner"
    //Tabs
    static let ic_home = "ic_home"
    static let ic_event = "ic_event"
    static let ic_podcast = "ic_podcast"
    static let ic_activites = "ic_activites"
    static let ic_profile = "ic_profile"
    
    
    //system
    
    static let chevronLeft = "chevron.left"
    static let chevronRight = "chevron.right"
    static let minusCircle = "minus.circle"
    static let plusCircle = "plus.circle"
    static let plus = "plus"
    static let calendar = "calendar"
    static let clock = "clock"
    
    static let checkmark = "checkmark"
    static let checkmarkSquareFill = "checkmark.square.fill"
    static let checkmarkCircle = "checkmark.circle"
    static let arrowUpRight = "arrow.up.right"
    static let arrowShapeUpBack = "arrowshape.turn.up.backward"
    static let arrowShapeUpRight = "arrowshape.turn.up.right"
    
    static let square = "square"
    static let circle = "circle"
    static let close = "close"
    static let multiply = "multiply"
    static let multiplyCircleFill = "multiply.circle.fill"
    
    static let magnifyingglass = "magnifyingglass"
    static let heartFill = "heart.fill"
    static let messageFill = "message.fill"
    static let cameraFill = "camera.fill"
    static let trash = "trash"
    static let playCircle = "play.circle"
    static let gearshape = "gearshape"
    static let envelopeBadge = "envelope.badge"
    static let shift = "shift"
    static let mic = "mic"
    static let paperplaneFill = "paperplane.fill"
}

struct K {
    static let appName = Bundle.main.displayName ?? ""
    static let countryID = "1"
    struct Key {
        static let loggedInUser         = "LoggedInUserKey"
    }
    struct Messages {
        static let mobileNoError    = "Please enter mobile number"
        static let mobileLengthErr  = "Mobile number should be minimum 10 characters"
        static let usernameError    = "Please enter username"
        static let towneError       = "Please enter town"
        static let passwordError    = "Please enter password"
        static let newPasswordErr   = "Please enter new passowrd"
        static let passwordValidErr = "Please enter minimum 8 characters, 1 Uppercase Alphabate, 1 Number"
        static let firstNameError   = "Please enter first name"
        static let lastNameError    = "Please enter last name"
        static let confirmPassError = "Please enter confirm passowrd"
        static let passMatchError   = "Password and Confirm password does not matched"
        static let termsAcceptError = "Please accept terms and condition"
        
        static let emailError   = "Please enter email address"
        static let validEmailError  = "Please enter valid email address"
        static let streetAddError   = "Please enter street address"
        static let appartmentError  = "Please enter appartment/unit"
        static let stateError       = "Please enter state"
        static let cityError        = "Please enter city"
        static let zipError         = "Please enter zip code"
        
        static let submitSelection  = "Please select atleast one ballot"
        static let customCandidatename  = "Please enter candidate name"
    }
    
    struct imgNames {
        static let backButton       = "ic_back_arrow"
        static let alertCircle      = "ic_alert_circle"
        static let check            = "ic_check"
        static let uncheck          = "ic_uncheck"
        static let nodata           = "ic_nodata"
        static let user             = "ic_user"
        static let settings         = "ic_settings"
        static let phone            = "ic_phone"
        static let info             = "ic_info"
        static let power            = "ic_power"
        static let userBg           = "ic_user_bg"
        static let phoneBg          = "ic_phone_bg"
        static let lock             = "ic_lock"
        static let bellTab          = "ic_bell"
        static let homeTab          = "ic_home_tab"
        static let profileTab       = "ic_profile"
        static let notificationTab  = "ic_notification"
        static let arrowRight       = "ic_arrow_right"
        static let arrowUp          = "ic_arrow_up"
        static let arrowDown        = "ic_arrow_down"
        static let switchON         = "ic_switch_on"
        static let switchOFF        = "ic_switch_off"
        static let email            = "ic_email"
        static let terms            = "ic_terms"
        static let privacy          = "ic_privacy"
        static let licence          = "ic_licence"
        static let success          = "ic_succes"
        static let checkCircle      = "ic_check_circle"
        static let warning          = "ic_warning"
        static let camera           = "ic_camera"
        static let close            = "ic_close"
        static let circleFilled     = "ic_circle_filled"
        static let circle           = "ic_circle"
        
    }
    
    struct placeHolders {
        static let firstName        = "First Name"
        static let lastName         = "Last Name"
        static let email            = "Email Address"
        static let mobile           = "Mobile Number"
        static let password         = "Password"
        static let confPassword     = "Confirm Password"
        static let streetAdd        = "Street Address"
        static let appartment       = "Appartment/Unit"
        static let country          = "Country"
        static let countryName      = "United States"
        static let state            = "State"
        static let city             = "City"
        static let zip              = "Zip"
        
        static let oldPassword      = "Old Password"
        static let newPassword      = "New Password"
    }
    
    struct appHeaderTitle {
        static let pinVerification  = "Pin Verification"
        static let spine            = "Spine"
        static let createAccount    = "Create Account"
        static let login            = "LOGIN"
        static let otpVerification            = "OTP Verification"
        static let signup           = "REGISTER"
        static let forgotPassword   = "FORGOT PASSWORD"
        static let resetPassword    = "Reset Password"
        static let ballots          = "Ballots"
        static let notifications    = "Notifications"
        static let mySettings       = "My Settings"
        static let manageProfile    = "Manage Profile"
        static let personalDetails  = "Personal Details"
        static let manageMobile     = "Manage Mobile Number"
        static let changePassword   = "Change Password"
        static let profile          = "Profile"
        static let manageProfileDetails = "Manage Profile Details"
        static let preference       = "Preference"
        static let support          = "Support"
        static let about            = "About"
        static let logout           = "Logout"
    }
    
    struct appButtonTitle {
        static let login            = "LOGIN"
        static let continues        = "CONTINUE"
        static let next             = "NEXT"
        static let ok               = "Okay"
        static let saveChanges      = "Save Changes"
        static let verify           = "Verify"
        static let cancel           = "Cancel"
        static let resendPin        = "Resend PIN"
        static let change           = "Change"
        static let reset            = "Reset"
        static let sendPin          = "Send PIN"
        static let getCodeagain     = "Get code again"
        static let getCodeaSMS      = "Get code via SMS"
        static let proceed          = "Proceed"
        static let submit           = "Submit"
        static let myProfile        = "My Profile"
        static let submitAnyways    = "Submit Anyways"
        static let confirmID        = "Comfirm ID"
        static let clearAll         = "Clear All"
        static let logout           = "LOGOUT"
    }
    
    struct appText {
        static let notYourMobile    = "Not your mobile number?"
        static let saveChanges      = "Save Changes"
        static let verify           = "Verify"
        static let cancel           = "Cancel"
        static let resendPin        = "Resend PIN"
        static let provideNo        = "Provide the mobile number associated with your account."
        static let termsCondition   = "Terms and Conditions"
        static let iAgree           = "I agree to the"
        static let alreadyAccount   = "Already have an account?"
        static let otpSent          = "Verification code has been sent to your email. Please check junk folder in case code is not received."
        static let haveReceive      = "Haven't received a code?"
        static let nodataText       = "We will notify you about the next available ballot for your area."
        static let detailsText      = "Provide details according to government records"
        static let privacyPolicy    = "Security and Privacy Policy"
        static let licences         = "Licences"
        static let instruction      = "Instructions"
        static let choiceButton     = "Select the button next to your choice."
        static let noNotication     = "No notification found."
        
        static let enterPhone     = "Enter your phone number"
    }
    
    struct appColors {
//        static let purple           = "purple"
        static let primaryBlack     = Color.init(hex: "#000000")
        static let primaryWhite     = Color.init(hex: "#FFFFFF")
        static let grey1            = "grey1"
        static let grey2            = "grey2"
        static let grey3            = "grey3"
        static let grey4            = "grey4"
        static let success          = "success"
        static let error            = "error"
        static let warning          = "warning"
        static let appTheme         = Color.init(hex: "#B79888")
        static let lightGray        = Color(UIColor.lightGray)
            
    }
    struct dateFomate {
        static let mmddyyyy_HHmmss = "MM-dd-yyyy HH:mm:ss" ///=> "07-16-2021 10:10:53"
        static let ddMMyyyy_HHmmss = "dd-MM-yyyy HH:mm:ss" ///=> "16-07-2021 10:10:53"
    }
    
    struct Notifications {
        static let firebaseNotification = "FirebaseNotificaiton"
    }
    
    enum LoadStatus:Int {
        case notDetermine   = 0
        case isAvailable    = 1
        case isEmpty        = 2
    }
    
    //Your app views
    enum AppStates {
        case loginView
        case mainView
    }
}

enum FontStyle: String {
   case Montserrat_Black        = "Montserrat-Black"
   case Montserrat_Bold         = "Montserrat-Bold"
   case Montserrat_ExtraBold    = "Montserrat-ExtraBold"
   case Montserrat_ExtraLight   = "Montserrat-ExtraLight"
   case Montserrat_Light        = "Montserrat-Light"
   case Montserrat_Medium       = "Montserrat-Medium"
   case Montserrat_Regular      = "Montserrat-Regular"
   case Montserrat_SemiBold     = "Montserrat-SemiBold"
   case Montserrat_Thin         = "Montserrat-Thin"
}

struct DropAppearance {
    static let stateAppearance = YBTextPickerAppearanceManager.init (
        pickerTitle         : "Select",
        titleFont           : UIFont.init(name: FontStyle.Montserrat_Bold.rawValue, size: 16),
        titleTextColor      : .white,
//        titleBackground     : UIColor.init(named: K.appColors.purple),
        searchBarFont       : UIFont.init(name: FontStyle.Montserrat_Regular.rawValue, size: 16),
        searchBarPlaceholder: "Search",
        closeButtonTitle    : "Cancel",
        closeButtonColor    : .darkGray,
        closeButtonFont     : UIFont.init(name: FontStyle.Montserrat_Regular.rawValue, size: 16),
        doneButtonTitle     : "OK",
//        doneButtonColor     : UIColor.init(named: K.appColors.purple),
        doneButtonFont      : UIFont.init(name: FontStyle.Montserrat_Bold.rawValue, size: 16),
        checkMarkPosition   : .Left,
        itemCheckedImage    : UIImage(named:"ic_purple_check"),
        itemUncheckedImage  : UIImage(named:"ic_purple_uncheck"),
        itemColor           : .black,
        itemFont            : UIFont.init(name: FontStyle.Montserrat_Regular.rawValue, size: 16)
    )
}
