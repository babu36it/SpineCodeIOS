//
//  LoginVC.swift
//  spine


import SwiftUI
import FBSDKCoreKit
import FBSDKLoginKit

struct LoginVC: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
    @State private var emailId   : String = ""
    @State private var mobile   : String = ""
    @State private var password : String = ""
    @State private var isLoginValid: Bool = false
    @State private var isNavigationBarHidden = true
    
    @State private var errorMessage: String = "0"
    @State var showLoader: Bool = false
    
    @State var shouldShowAlert    = false
    @State var message  = ""
    @State var closure  : AlertAction?
    @State var isSuccess = true
    @State private var selection : Int? = 0
    @State var userLoginID = ""
    @State var verificationCode = ""
    
    var viewModel : LoginViewModel? = LoginViewModel()
    
    var loginManager = LoginManager()
    let readPermissions =  ["public_profile", "email", "user_friends","user_birthday"]
    init(isRootView: Bool = false) {
            self.isRootView = isRootView
        }
        
    var isRootView : Bool = false
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
                ZStack(alignment: .center) {
            VStack {
                HeaderTitleView(title: K.appHeaderTitle.login).padding(.top, 30)  .font(AppUtility.shared.appFont(type: .regular, size: 18))
                VStack {
                    VStack {
                        TextField("Email", text: $emailId)
                            .foregroundColor(.white)
                            .accentColor(.white)
                            .padding()
                            .frame(height: 45)
                            .background(Color.clear)
                            .cornerRadius(25)
                            .autocapitalization(.none)
                            .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.white, lineWidth: 2))
                            .padding(.bottom, 20)
                            .keyboardType(.emailAddress)
                            .font(AppUtility.shared.appFont(type: .regular, size: 16))
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
                        
                        AppLoginButton(title: K.appButtonTitle.login, callback: {
                            self.errorMessage = self.loginValidation()
                            if self.errorMessage == "" {
                                self.doLogin()
                                
                            }
                            else {
                                self.shouldShowAlert = true
                                self.isSuccess = false
                                self.message = self.errorMessage
                            }
                        })
                        
                        NavigationLink(destination: OTPVC(userID:userLoginID, verificationCode:verificationCode), tag: 2, selection: self.$selection) {
                            EmptyView()
                        }
                        NavigationLink(destination: ForgotPasswordVC(), tag: 1, selection: self.$selection) {
                            EmptyView()
                                
                        }
                        VStack {
                            Button {
                                self.selection = 1
                                
                            } label: {
                                Text("Forgot Password").foregroundColor(.white).underline().font(AppUtility.shared.appFont(type: .regular, size: 16))
                            }.padding()
                            
                        }
                        HStack{
                            LabelledDivider(label: "Or")
                                .font(AppUtility.shared.appFont(type: .regular, size: 16))
                        }
                        VStack{
                            Button {
                                print("Contionue with Facebook")
                                self.facebookLogin()
                            } label: {
                                Text("Contionue with Facebook")
                                    .font(AppUtility.shared.appFont(type: .regular, size: 16))
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .font(.system(size: 16))
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
        //.navigationBarHidden(true)
        
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
    
    func loginValidation() -> String {
        if _emailId.wrappedValue.isValid == false {
            return K.Messages.emailError
        } else if _emailId.wrappedValue.isValidEmail() == false {
            return K.Messages.validEmailError
        } else if _password.wrappedValue.isValid == false {
            return K.Messages.passwordError
        }
        else {
            return ""
        }
    }
}

//MARK:- Service Call
extension LoginVC {
    func doLogin() {
        let request = signInRequestModel()
        request.email = self._emailId.wrappedValue
        request.password = self._password.wrappedValue
        request.devicetoken = "saaadasd"
        request.devicetype = "iPhone"
        
        viewModel?.signIn(request) { (response, status) in
            if response?.status == true {
                AppUtility.shared.redirectToMainScreen()
                if let message  = response?.message{
                    ShowToast.show(toatMessage: message)
                }
            }else{
                
//                if let response = response?.data {
//                    self.userLoginID = response.usersId ?? ""
//                    self.verificationCode = response.verificationPin ?? ""
//                    selection = 2
//                }
                if let message  = response?.message{
                    ShowToast.show(toatMessage: message)
                }
                
            }
        }
    }
   
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

//                                  if let response = response?.data {
//                                      self.userLoginID = response.usersId ?? ""
//                                      self.verificationCode = response.verificationPin ?? ""
//                                      selection = 2
//                                  }
                                  if let message  = response?.message{
                                      ShowToast.show(toatMessage: message)
                                  }

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
}

struct LoginVC_Previews: PreviewProvider {
    static var previews: some View {
        LoginVC()
    }
}


struct LabelledDivider: View {
    
    let label: String
    let horizontalPadding: CGFloat
    let color: Color
    
    init(label: String, horizontalPadding: CGFloat = 10, color: Color = .white) {
        self.label = label
        self.horizontalPadding = horizontalPadding
        self.color = color
    }
    
    var body: some View {
        HStack {
            line
            Text(label).foregroundColor(color)
            line
        }
    }
    
    var line: some View {
        VStack { Divider().background(color).frame(height:2) }.padding(horizontalPadding)
    }
}
