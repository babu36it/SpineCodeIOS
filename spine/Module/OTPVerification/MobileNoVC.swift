//
//  MobileNoVC.swift
//  spine
//
//

import SwiftUI
import FirebaseAuth

struct MobileNoVC: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @StateObject var viewModel: MobileOTPViewModel = .init()
    @State private var selection: Int? = 0
    @State var closure: AlertAction?

    var userID: String = ""
        
    var btnBack: some View {
        Button(action: {
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
                VStack {
                    Text(K.appText.enterPhone)
                        .font(AppUtility.shared.appFont(type: .SemiBold, size: 14))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.init(white: 0.93))
                        .padding()

                    HStack {
                        Text(viewModel.countryCode.isEmpty ? "🇬🇧 +44" : "\(viewModel.countryFlag) +\(viewModel.countryCode)")
                            .font(AppUtility.shared.appFont(type: .SemiBold, size: 16))
                            .multilineTextAlignment(.center)
                            .foregroundColor(viewModel.countryCode.isEmpty ? .secondary : Color(white: 0.93))
                            .onTapGesture {
                                withAnimation (.spring()) {
                                    if self.viewModel.yPickerPosition != 200 {
                                        self.viewModel.yPickerPosition = 200
                                    } else {
                                        self.viewModel.yPickerPosition = 0
                                    }
                                }
                            }
                        
                        Divider().frame(width: 1, height: 30, alignment: .center).background(Color.white)
                        
                        TextField("Phone Number", text: $viewModel.phoneNumber)
                            .foregroundColor(.white)
                            .accentColor(.white)
                            .frame(height: 35)
                            .background(Color.clear)
                            .autocapitalization(.none)
                            .font(AppUtility.shared.appFont(type: .regular, size: 16))
                            .keyboardType(.phonePad)
                    }
                    .padding([.top, .bottom], 5)
                    .padding([.leading, .trailing], 15)
                    .overlay(RoundedRectangle(cornerRadius: 35).stroke(Color.white, lineWidth: 2))
                    .padding(.bottom, 40)
                    
                    AppLoginButton(title: K.appButtonTitle.next, callback: {
                        self.hideKeyboard()
                        viewModel.signInWithPhoneNumber { status, error in
                            if status {
                                self.selection = 1
                            }
                        }
                    })
                }
                .padding([.leading, .trailing], 60)
                Spacer()
            }
            .onAppear {
                self.viewModel.userID = userID
            }
            
            NavigationLink(destination: MobileOTPVC(viewModel: viewModel), tag: 1, selection: $selection) {
                EmptyView()
            }

            if viewModel.shouldShowAlert {
                AlertView(shown: $viewModel.shouldShowAlert, closureA: $closure, isSuccess: self.viewModel.isSuccess, message: self.viewModel.errorMessage, buttonTitle: K.appButtonTitle.ok, isShowButton: true, isShowCancel: false).buttonAction {
                    viewModel.shouldShowAlert = false
                }
            }
            
            IndicatorView(isAnimating: $viewModel.showLoader)
            
            CountryCodeView(countryCode: $viewModel.countryCode, countryFlag: $viewModel.countryFlag, yPosition: $viewModel.yPickerPosition)
                .offset(y: viewModel.yPickerPosition)
        }
        .background(
            Image(ImageName.ic_background)
                .resizable()
                .scaleEffect()
                .edgesIgnoringSafeArea(.all)
        )
        .onTapGesture {
            self.hideKeyboard()
            if self.viewModel.yPickerPosition != 200 {
                withAnimation (.spring()) {
                    self.viewModel.yPickerPosition = 200
                }
            }
        }
        .navigationBarItems(leading: btnBack)
        .navigationBarBackButtonHidden(true)
    }
}

struct CountryCodeView: View {
    @Binding var countryCode: String
    @Binding var countryFlag: String
    @Binding var yPosition: CGFloat
    
    var body: some View {
        GeometryReader { geo in
            let viewHeight: CGFloat = 400
            List(CountryCodes.countryInfos, id: \.name) { country in
                HStack {
                    Text("\(country.flag)")
                    Text("\(country.name)")
                    Spacer()
                    Text("+\(country.code)").foregroundColor(.secondary)
                }
                .background(Color.white)
                .font(.system(size: 20))
                .onTapGesture {
                    self.countryCode = country.code
                    self.countryFlag = country.flag
                    withAnimation(.spring()) {
                        self.yPosition = viewHeight/2
                    }
                }
            }
            .listStyle(.plain)
            .cornerRadius(20)
            .padding(.bottom)
            .frame(width: geo.size.width, height: viewHeight)
            .position(x: geo.frame(in: .global).midX, y: geo.frame(in: .global).maxY - viewHeight/2)
        }
    }
}

struct MobileNoVC_Previews: PreviewProvider {
    static var previews: some View {
        MobileNoVC(userID: "0")
    }
}
