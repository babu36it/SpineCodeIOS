//
//  PersonalDetailsVC.swift
//  Populist
//
//  Created by Bharat Jadav on 02/07/21.
//

import SwiftUI
import FloatingLabelTextFieldSwiftUI

struct PersonalDetailsVC: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var strTitle     : String
    @State var firstName    : String = ""
    @State var lastName     : String = ""
    @State var streetAdd    : String = ""
    @State var apprtment    : String = ""
    @State var city         : String = ""
    @State var zip          : String = ""
    @State var state        : String = ""
    @State var country      : String = K.placeHolders.countryName
    @State var email        : String = ""
    
    @State var stateID      : Int = 0
    @State var cityID       : Int = 0
    
    var viewModel : ProfileViewModel? = ProfileViewModel()
    
    //Alert Parameters
    @State private var sessionExpire: Int? = 0
    @State var showLoader: Bool = false
    @State private var errorMessage : String = ""
    @State var isFromSignup: Bool
    @State var isNavigate: Bool = false
    
    @State var stateList   : [StateModel]?  = []
    @State var cityList    : [CityModel]?   = []
    
    @State var shouldShowAlert    = false
    @State var message  = ""
    @State var closure  : AlertAction?
    @State var isSuccess = true
    
    var btnBack : some View {
        Button(action: {
            if isFromSignup == false {
                self.presentationMode.wrappedValue.dismiss()
            }
        })
        {
            HStack {
                if !isFromSignup {
                    Image(K.imgNames.backButton) // set image here
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                }
                
                Text(strTitle)
                    .font(.custom(FontStyle.Montserrat_SemiBold.rawValue, size: 20))
                    .foregroundColor(Color.init(K.appColors.primaryBlack))
            }
        }
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                if showLoader == false {
                    LazyVStack {
                        HStack {
                            Image(K.imgNames.alertCircle)
                                .aspectRatio(contentMode: .fit)
                                .padding(.leading, 5)
                            Text(K.appText.detailsText)
                                .font(.custom(FontStyle.Montserrat_Regular.rawValue, size: 15))
                                .foregroundColor(Color.init(K.appColors.grey1))
                                .padding(.horizontal, 5)
                        }
                        .padding(.top)
                        
                        VStack {
                            FloatingLabelTextField($firstName, placeholder: K.placeHolders.firstName)
                                .floatingStyle(ThemeTextFieldStyle())
                                .padding()
                                .keyboardType(.default)
                                .frame(height: 50)
                            
                            FloatingLabelTextField($lastName, placeholder: K.placeHolders.lastName)
                                .floatingStyle(ThemeTextFieldStyle())
                                .padding()
                                .keyboardType(.default)
                                .frame(height: 50)
                            FloatingLabelTextField($email, placeholder: K.placeHolders.email)
                                .floatingStyle(ThemeTextFieldStyle())
                                .padding()
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .frame(height: 50)
                            FloatingLabelTextField($streetAdd, placeholder: K.placeHolders.streetAdd)
                                .floatingStyle(ThemeTextFieldStyle())
                                .padding()
                                .keyboardType(.default)
                                .frame(height: 50)
                            FloatingLabelTextField($apprtment, placeholder: K.placeHolders.appartment)
                                .floatingStyle(ThemeTextFieldStyle())
                                .padding()
                                .keyboardType(.default)
                                .frame(height: 50)
                            HStack {
                                FloatingLabelTextField($country, placeholder: K.placeHolders.country)
                                    .floatingStyle(ThemeTextFieldStyle())
                                    .padding()
                                    .keyboardType(.default)
                                    .frame(height: 50)
                                    .disabled(true)
                                FloatingLabelTextField($state, placeholder: K.placeHolders.state)
                                    .floatingStyle(ThemeTextFieldStyle())
                                    .disabled(true)
                                    .padding()
                                    .keyboardType(.default)
                                    .frame(height: 50)
                                    .onTapGesture {
                                        UIApplication.shared.endEditing()
                                        getStatesDropdown()
                                    }
                            }
                            HStack {
                                FloatingLabelTextField($city, placeholder: K.placeHolders.city)
                                    .floatingStyle(ThemeTextFieldStyle())
                                    .padding()
                                    .keyboardType(.default)
                                    .frame(height: 50)
                                    .onTapGesture {
                                        UIApplication.shared.endEditing()
                                        if stateID != 0 {
                                            self.getCityDropdown()
                                        }
                                    }
                                FloatingLabelTextField($zip, placeholder: K.placeHolders.zip)
                                    .floatingStyle(ThemeTextFieldStyle())
                                    .padding()
                                    .keyboardType(.default)
                                    .frame(height: 50)
                            }
                            NavigationLink(destination: MainTabView(), isActive: $isNavigate) {
                                AppButtons(title: K.appButtonTitle.saveChanges, callback: {
                                    self.errorMessage = self.formValidation()
                                    if self.errorMessage == "" {
                                        self.updateUserProfile()
                                    }
                                    else {
                                        self.shouldShowAlert = true
                                        self.isSuccess = false
                                        self.message = self.errorMessage
                                    }
                                })
                            }
                            
                        }.padding(.top, 20)
                    }
                }
            }
            .onAppear(perform: self.fetchUserProfile)
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: btnBack)
            .navigationBarBackButtonHidden(true)
            if shouldShowAlert {
                AlertView(shown: $shouldShowAlert, closureA: $closure, isSuccess: self.isSuccess, message: self.message, buttonTitle: K.appButtonTitle.ok, isShowButton: true, isShowCancel: false).buttonAction {
                    shouldShowAlert = false
                    if AppUtility.shared.apiErrorCode == ServerErrorCode.sessionExpire.rawValue {
                        self.sessionExpire = Session.expire.rawValue
                        AppUtility.shared.apiErrorCode = ServerErrorCode.none.rawValue
                    }
                }
            }
            IndicatorView(isAnimating: $showLoader)
            
            //Navigate To Login Session Expire
            NavigationLink(destination:  LoginVC(), tag: 2, selection: self.$sessionExpire) {
                EmptyView()
            }
        }
    }
    
    func setupUserProfileData() {
        if self.viewModel?.userData != nil {
            self._firstName.wrappedValue = self.viewModel?.userData?.first_name?.stringValue ?? ""
            self._lastName.wrappedValue = self.viewModel?.userData?.last_name?.stringValue ?? ""
            self._email.wrappedValue = self.viewModel?.userData?.email?.stringValue ?? ""
            self._streetAdd.wrappedValue = self.viewModel?.userData?.street_address?.stringValue ?? ""
            self._apprtment.wrappedValue = self.viewModel?.userData?.apartment?.stringValue ?? ""
            self._state.wrappedValue = self.viewModel?.userData?.state_name?.stringValue ?? ""
            self._city.wrappedValue = self.viewModel?.userData?.city_name?.stringValue ?? ""
            self._zip.wrappedValue = self.viewModel?.userData?.zip?.stringValue ?? ""
            
            self._stateID.wrappedValue = self.viewModel?.userData?.state_id?.intValue ?? 0
            self._cityID.wrappedValue = self.viewModel?.userData?.city_id?.intValue ?? 0
            self.getCityList()
        }
    }
    
    func formValidation() -> String {
        if _firstName.wrappedValue.isValid == false {
            return K.Messages.firstNameError
        }
        else if _lastName.wrappedValue.isValid == false {
            return K.Messages.lastNameError
        }
        else if _email.wrappedValue.isValid == false {
            return K.Messages.emailError
        }
        else if _streetAdd.wrappedValue.isValid == false {
            return K.Messages.streetAddError
        }
        else if _apprtment.wrappedValue.isValid == false {
            return K.Messages.appartmentError
        }
        else if _state.wrappedValue.isValid == false {
            return K.Messages.stateError
        }
        else if _city.wrappedValue.isValid == false {
            return K.Messages.cityError
        }
        else if _zip.wrappedValue.isValid == false {
            return K.Messages.zipError
        }
        else {
            return ""
        }
    }
}

struct PersonalDetailsVC_Previews: PreviewProvider {
    static var previews: some View {
        PersonalDetailsVC(strTitle: K.appHeaderTitle.manageProfileDetails, isFromSignup: false)
    }
}

//MARK:- API Webservice Call
extension PersonalDetailsVC {
    func fetchUserProfile() {
        self.showLoader = true
        viewModel?.getUserProfile(resourceType: .userProfile, completion: { (success, error) in
            if success {
                self.setupUserProfileData()
                self.getStateList()
            }
            else {
                if let err = error as NSError?, err.code == ServerErrorCode.sessionExpire.rawValue {
                    AppUtility.shared.apiErrorCode = ServerErrorCode.sessionExpire.rawValue
                }
                
                self.isSuccess = success
                self.message = AppUtility.shared.apiResponseMessage
                self.shouldShowAlert = true
                self.showLoader = false
            }
        })
    }
    
    func getStateList() {
        self.viewModel?.getStateList(value: "1", completion: { (success, error) in
            self.showLoader = false
            self.stateList = self.viewModel?.stateList
        })
    }
    
    func getCityList() {
        DispatchQueue.main.async {
            self.viewModel?.getCityList(value: "\(self.stateID)", completion: { (success, error) in
                self.cityList = self.viewModel?.cityList
            })
        }
    }
    
    func updateUserProfile() {
        var params = [String : Any]()
        params["first_name"]        = _firstName.wrappedValue
        params["last_name"]         = _lastName.wrappedValue
        params["street_address"]    = _streetAdd.wrappedValue
        params["apartment"]         = _apprtment.wrappedValue
        params["state_id"]          = _stateID.wrappedValue
        params["city_id"]           = _cityID.wrappedValue
        params["zip"]               = _zip.wrappedValue
        params["email"]             = _email.wrappedValue
        params["is_email_verified"] = "0"
        self.showLoader = true
        
        self.viewModel?.UpdateUserProfile(parameters: params, completion: { (success, error) in
            if success {
                DispatchQueue.main.async {
                    AppUtility.shared.userSettings.islogin = true
                    if isFromSignup == false {
                        self.isNavigate = false
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    else {
                        self.isNavigate = true
                    }
                }
            }
            else {
                self.shouldShowAlert = true
                self.isSuccess = success
                self.message = AppUtility.shared.apiResponseMessage
                if let err = error as NSError?, err.code == ServerErrorCode.sessionExpire.rawValue {
                    AppUtility.shared.apiErrorCode = ServerErrorCode.sessionExpire.rawValue
                }
            }
            self.showLoader = false
        })
    }
}

//MARK:- Get Location
extension PersonalDetailsVC {
    func getStatesDropdown() {
        let list = self.stateList?.map {(item) -> String in
            return "\(item.name?.stringValue ?? "")"
        }
        let picker = YBTextPicker.init(with: list ?? [], appearance: DropAppearance.stateAppearance,
            onCompletion: { (selectedIndexes, selectedValues) in
                if selectedValues.count > 0 {
                    var values = [String]()
                    for index in selectedIndexes{
                        values.append(list?[index] ?? "")
                    }
                    
                    self.city       = ""
                    self.cityID     = 0
                    self.state      = values.joined(separator: ", ")
                    self.stateID    = self.stateList?[selectedIndexes[0]].id?.intValue ?? 0
                    self.getCityList()
                }
                else {
                    self.state  = "Select State"
                }
            },
            onCancel: {
                AppUtility.shared.printToConsole("Cancelled")
            }
        )
        
        picker.preSelectedValues = self.state.components(separatedBy: ", ")
        picker.allowMultipleSelection = false
        
        picker.show(withAnimation: .Fade)
    }
    
    func getCityDropdown() {
        let list = self.cityList?.map {(item) -> String in
            return "\(item.name?.stringValue ?? "")"
        }
        let picker = YBTextPicker.init(with: list ?? [], appearance: DropAppearance.stateAppearance,
            onCompletion: { (selectedIndexes, selectedValues) in
                if selectedValues.count > 0 {
                    var values = [String]()
                    for index in selectedIndexes{
                        values.append(list?[index] ?? "")
                    }
                    
                    self.city     = values.joined(separator: ", ")
                    self.cityID   = self.cityList?[selectedIndexes[0]].id?.intValue ?? 0
                }
                else {
                    self.city  = "Select City"
                }
            },
            onCancel: {
                AppUtility.shared.printToConsole("Cancelled")
            }
        )
        
        picker.preSelectedValues = self.city.components(separatedBy: ", ")
        picker.allowMultipleSelection = false
        
        picker.show(withAnimation: .Fade)
    }
}
