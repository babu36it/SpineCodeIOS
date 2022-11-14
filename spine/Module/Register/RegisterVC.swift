//
//  RegisterVC.swift
//  spine
//
//  Created by OM Apple on 27/04/22.
//

import SwiftUI
import FBSDKCoreKit
import FBSDKLoginKit

struct RegisterVC: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var username  : String = ""
    @State private var emailId   : String = ""
    @State private var mobile   : String = ""
    @State private var password : String = ""
    @State private var town  : String = ""
    
    @State private var isLoginValid: Bool = false
    @State private var isNavigationBarHidden = true
    
    @State private var errorMessage: String = "0"
    @State var showLoader: Bool = false
    
    @State var shouldShowAlert    = false
    @State var message  = ""
    @State var closure  : AlertAction?
    @State var isSuccess = true
    @State private var selection : Int? = 0
    @State var userID = ""
    @State var verificationCode = ""
    
    var isRootView: Bool = false

    var viewModel : LoginViewModel? = LoginViewModel()
    
    var loginManager = LoginManager()
    let readPermissions =  ["public_profile", "email", "user_friends","user_birthday"]
   
    init(isRootView: Bool = false) {
        //Use this if NavigationBarTitle is with Large Font
        //            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.red]
        
        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        self.isRootView = isRootView
    }
    
    var btnBack: some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        HStack {
            Image(ImageName.ic_back) // set image here
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
        }
    }
    }
    var body: some View {
        //        NavigationView {
        ZStack(alignment: .center) {
            VStack {
                HeaderTitleView(title: K.appHeaderTitle.signup).padding(.top, 20)
                    .font(AppUtility.shared.appFont(type: .regular, size: 18))
                VStack {
                    VStack {
                        TextField("Username", text: $username)
                            .foregroundColor(.white)
                            .accentColor(.white)
                            .padding()
                            .frame(height: 45)
                            .background(Color.clear)
                            .cornerRadius(25)
                            .autocapitalization(.none)
                            .font(AppUtility.shared.appFont(type: .regular, size: 16))
                            .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.white, lineWidth: 2))
                            .padding(.bottom, 20)
                            .keyboardType(.emailAddress)
                            .onChange(of: username) { newValue in
                                print(newValue)
                            }

                        TextField("Email", text: $emailId)
                            .foregroundColor(.white)
                            .accentColor(.white)
                            .padding()
                            .frame(height: 45)
                            .background(Color.clear)
                            .cornerRadius(25)
                            .autocapitalization(.none)
                            .font(AppUtility.shared.appFont(type: .regular, size: 16))
                            .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.white, lineWidth: 2))
                            .padding(.bottom, 20)
                            .keyboardType(.emailAddress)
                            .onChange(of: emailId) { newValue in
                                print(newValue)
                            }
                        
                        SecureField("Password", text: $password)
                            .foregroundColor(.white)
                            .accentColor(.white)
                            .padding()
                            .frame(height: 45)
                            .background(Color.clear)
                            .cornerRadius(25)
                            .font(AppUtility.shared.appFont(type: .regular, size: 16))
                            .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.white, lineWidth: 2))
                            .padding(.bottom, 20)
                        
                        TextField("Town", text: $town)
                            .foregroundColor(.white)
                            .accentColor(.white)
                            .padding()
                            .frame(height: 45)
                            .background(Color.clear)
                            .cornerRadius(25)
                            .autocapitalization(.none)
                            .font(AppUtility.shared.appFont(type: .regular, size: 16))
                            .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.white, lineWidth: 2))
                            .padding(.bottom, 20)
                            .keyboardType(.emailAddress)
                            .onChange(of: town) { newValue in
                                print(newValue)
                            }
                        
                        NavigationLink(destination: OTPVC(userID: userID, verificationCode: verificationCode, emailId: emailId, password: password), tag: 1, selection: self.$selection) {
                            EmptyView()
                        }
                        
                        AppLoginButton(title: K.appButtonTitle.continues, callback: {
                            self.errorMessage = self.signUpValidation()
                            if self.errorMessage == "" {
                                self.doSignUp()
                            }
                            else {
                                self.shouldShowAlert = true
                                self.isSuccess = false
                                self.message = self.errorMessage
                            }
//                            self.redirectToOTPVerification()
                        })
                        VStack {
                            Button {
                                print("Forgot Password pressed")
                            } label: {
                                Title5(title: "I have read and agree to the Terms of Service and Privacy Policy", fColor: .white)
                            }.padding()
                        }
                        HStack{
                            LabelledDivider(label: "Or")
                        }
                        VStack{
                            Button {
                                print("Contionue with Facebook")
                                facebookLogin()
                            } label: {
                                Text("Contionue with Facebook")
                                    .font(AppUtility.shared.appFont(type: .regular, size: 16))
                                    .frame(minWidth: 0, maxWidth: .infinity)
                    
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(
                                        LinearGradient(gradient: Gradient(colors: [Color.init(red: 1/255, green: 65/255, blue: 143/255), Color.init(red: 8/255, green: 106/255, blue: 208/255), Color.init(red: 9/255, green: 141/255, blue: 226/255)]), startPoint: .leading, endPoint: .trailing)
                                        )
                            }
                            .background(Color.init(red: 1/255, green: 65/255, blue: 143/255))
                            .frame(height: 45)
                            .cornerRadius(5)
                            
                        }
                        if isRootView {
                            VStack {
                                Button {
                                    AppUtility.shared.redirectToLoginScreen()
                                } label: {
                                    Text("Already have an Account?")
                                        .foregroundColor(.white)
                                        .underline()
                                        .font(AppUtility.shared.appFont(type: .regular, size: 16))
                                }
                                .padding()
                            }
                        }
                    }.padding(.top, 30)
                        .padding([.leading, .trailing], 30)
                }
                .padding([.leading, .trailing], 35)
                Spacer()
            }
            .onTapGesture {
                self.hideKeyboard()
            }
            if shouldShowAlert {
                AlertView(shown: $shouldShowAlert, closureA: $closure, isSuccess: self.isSuccess, message: self.message, buttonTitle: K.appButtonTitle.ok, isShowButton: true, isShowCancel: false).buttonAction {
                    shouldShowAlert = false
                }
            }
            IndicatorView(isAnimating: $showLoader)
        }
        .background(
            Image(ImageName.ic_background)
                .resizable()
                .scaleEffect()
                .edgesIgnoringSafeArea(.all)
        )
        .navigationBarItems(leading: btnBack)
        .navigationBarBackButtonHidden(true)
    }
    
    private func redirectToMainScreen() {
        DispatchQueue.main.async {
            //            if let window = UIApplication.shared.windows.first {
            //                    let homeView = MainTabView()
            //                    window.rootViewController = UIHostingController(rootView: homeView)
            //                    window.makeKeyAndVisible()
            //                }
        }
    }
    
    func signUpValidation() -> String {
        if _username.wrappedValue.isValid == false {
            return K.Messages.usernameError
        }
        else if _emailId.wrappedValue.isValid == false {
            return K.Messages.emailError
        } else if _emailId.wrappedValue.isValidEmail() == false {
            return K.Messages.validEmailError
        } else if _password.wrappedValue.isValid == false {
            return K.Messages.passwordError
        }else if _town.wrappedValue.isValid == false {
            return K.Messages.towneError
        }
        else {
            return ""
        }
    }
    
    private func redirectToOTPVerification() {
        self.hideKeyboard()
        self.showLoader = true
        ///api call to send OTP on Mobile number via Email
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            self.showLoader = false
//            self.shouldShowAlert = true
            self.selection = 1
        }
    }
}

//MARK:- Service Call
extension RegisterVC {
   
    
    func facebookLogin() {
          loginManager.logIn(permissions: [.publicProfile, .email], viewController: nil) { loginResult in
              switch loginResult {
              case .failed(let error):
                  print(error)
              case .cancelled:
                  print("User cancelled login.")
              case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                  print("Logged in! \(grantedPermissions) \(declinedPermissions) \(accessToken)")
                                  
                  GraphRequest(graphPath: "me",parameters:  ["fields": "id, name, first_name, email"]).start { (connection, result, error) -> Void  in
                      if (error == nil){
                          let fbDetails = result as! NSDictionary
                          print(fbDetails)
                          let fbUserId = fbDetails["id"] ?? ""
                          let fbAccessToken = AccessToken.current?.tokenString ?? ""

                          let fbResult = "id=\(fbUserId)&accessToken=\(fbAccessToken)"
                          let request = socialLoginRequestModel()
                          let email = fbDetails["email"]  as? String
                          let id = fbDetails["id"]  as? String
                          let name = fbDetails["name"]  as? String
                          request.email = email
                          request.facebookId = id
                          request.name = name
                          request.longitude = "22.3452"
                          request.latitude = "23.4535"
                          request.devicetoken = "saaadasd"
                          request.notifytoken = "saaadasd"
                          request.notifydevicetype = "iPhone"
                          viewModel?.socialLogin(request) { (response, status) in
                              if response?.status == true {
                                  AppUtility.shared.redirectToMainScreen()
                                  if let message  = response?.message{
                                      ShowToast.show(toatMessage: message)
                                  }
                              }else{


                              }
                          }
                      }
                      else
                      {
                          ShowToast.show(toatMessage: error.debugDescription)
                      }
                  
                  }
              }
          }
      }

    func doSignUp() {
            let request = signUpRequestModel()
            request.email = self._emailId.wrappedValue
            request.password = self._password.wrappedValue
            request.name = self._username.wrappedValue
            request.town = self._town.wrappedValue
            request.userip = "192.168.1.1"
            request.latitude = "24.3456"
            request.longitude = "27.3456"
            viewModel?.signUp(request) { (response, status) in
                if response?.status == true {
                    if let message  = response?.message{
                       ShowToast.show(toatMessage: message)
                        self.selection = 1
                    }
                    if let signInData = response?.data {
                        self.userID = signInData.usersId ?? ""
                        self.verificationCode = signInData.verificationPin ?? ""
                    }
                }else{
                  
                    if let message  = response?.message{
                       ShowToast.show(toatMessage: message)
                    }
                    
                }
            }
        }
}

struct RegisterVC_Previews: PreviewProvider {
    static var previews: some View {
        RegisterVC()
    }
}


//struct LabelledDivider: View {
//
//    let label: String
//    let horizontalPadding: CGFloat
//    let color: Color
//
//    init(label: String, horizontalPadding: CGFloat = 10, color: Color = .white) {
//        self.label = label
//        self.horizontalPadding = horizontalPadding
//        self.color = color
//    }
//
//    var body: some View {
//        HStack {
//            line
//            Text(label).foregroundColor(color)
//            line
//        }
//    }
//
//    var line: some View {
//        VStack { Divider().background(color).frame(height:2) }.padding(horizontalPadding)
//    }
//}
