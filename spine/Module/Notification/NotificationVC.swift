//
//  NotificationVC.swift
//  Populist
//
//  Created by Bharat Jadav on 11/06/21.
//

import SwiftUI

enum ListStatus:Int {
    case notDetermine = 0
    case isAvailable = 1
    case isEmpty = 2
}

struct NotificationVC: View {
    @State var listStatus:ListStatus = ListStatus.notDetermine
    @State var showLoader: Bool = false
    @State var pageNo: Int = 0
    @State var pageSize: Int = 10
    @ObservedObject var viewModel = NotificationViewModel()
    
    //Alert Parameters
    @State private var sessionExpire: Int? = 0
    @State var shouldShowAlert    = false
    @State var message  = ""
    @State var closure  : AlertAction?
    @State var isSuccess = true
    
    var btnBack : some View {
        Button(action: {
        })
        {
            HStack {
                Text(K.appHeaderTitle.notifications)
                    .font(.custom(FontStyle.Montserrat_SemiBold.rawValue, size: 20))
                    .foregroundColor(Color.init(K.appColors.primaryBlack))
            }
        }
        .disabled(true)
    }
    
    var btnClearAll: some View {
        Button(action: {
            self.removeAllNotification()
        }) {
            HStack {
                Spacer()
                Text(K.appButtonTitle.clearAll)
                    .font(.custom(FontStyle.Montserrat_SemiBold.rawValue, size: 16))
                    .foregroundColor(Color.init(K.appColors.purple))
                    .padding([.top, .trailing], 20.0)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Image(K.imgNames.nodata)
                        .padding()
                        .aspectRatio(contentMode: .fit)
                    Text(K.appText.noNotication)
                        .font(.custom(FontStyle.Montserrat_Regular.rawValue, size: 14))
                        .foregroundColor(Color.init(K.appColors.grey1))
                        .padding([.leading, .bottom, .trailing], 20)
                }.opacity(listStatus == ListStatus.isEmpty ? 1 : 0)
                
                ScrollView {
                    VStack {
                        btnClearAll
                        LazyVStack(spacing:0) {
                            ForEach(self.viewModel.notificationList) { item in
                                NotificationListCell(notificationDetailModel: item) { (obj) in
                                    if let isExpand = obj?.isExpand,
                                       let notificationId = obj?.notficationId {
                                        self.viewModel.updateNotificationExpandProperties(by: notificationId, isExpand: isExpand)
                                    }
                                } readCompletion: { (status, obj) in
                                    if status == true,
                                       let isRead = obj?.isRead,
                                       let notificationId = obj?.notficationId {
                                        self.viewModel.updateNotificationModel(by: notificationId, isRead: isRead)
                                    }
                                }
                            }
                        }
                        .padding(.top, 10)
                        .onAppear {
                            if viewModel.notificationListFull == false {
                                self.viewModel.pageNo += 1
                                self.featchNotificationList()
                            }
                        }
                    }.opacity(listStatus == ListStatus.isAvailable ? 1 : 0)
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: btnBack)
            .navigationBarColor(UIColor.init(named: K.appColors.grey4), hideShadow: false)
        }
        //.navigationViewStyle(StackNavigationViewStyle())
        .onAppear(perform: self.featchNotificationList)
        
//        if shouldShowAlert {
//            AlertView(shown: $shouldShowAlert, closureA: $closure, isSuccess: isSuccess, message: message, buttonTitle: K.appButtonTitle.ok, isShowButton: true, isShowCancel: false).buttonAction {
//                shouldShowAlert = false
//                if AppUtility.shared.apiErrorCode == ServerErrorCode.sessionExpire.rawValue {
//                    self.sessionExpire = Session.expire.rawValue
//                    AppUtility.shared.apiErrorCode = ServerErrorCode.none.rawValue
//                }
//            }
//        }
        
        //Navigate To Login Session Expire
        NavigationLink(destination:  LoginVC(), tag: 2, selection: self.$sessionExpire) {
            EmptyView()
        }
        
        IndicatorView(isAnimating: $showLoader)
     }
}

//MARK:- Service call methods
extension NotificationVC {
    /// Get notifictaion List
    func featchNotificationList() {
        self.showLoader = true
        viewModel.getNotificationList(self.viewModel.pageNo) { (status, error) in
            if status {
                self.updateListStatus()
            }
            else {
                if let err = error as NSError?, err.code == ServerErrorCode.sessionExpire.rawValue {
                    AppUtility.shared.apiErrorCode = ServerErrorCode.sessionExpire.rawValue
                }
                
                self.isSuccess = status
                self.message = AppUtility.shared.apiResponseMessage
                self.shouldShowAlert = true
            }
            self.showLoader = false
        }
    }
    
    func removeAllNotification() {
        self.showLoader = true
        viewModel.deleteAllNotification { (status) in
            self.showLoader = false
            if status {
                self.updateListStatus()
            }
        }
    }
    
    private func updateListStatus() {
        self.listStatus = viewModel.notificationList.count > 0 ? .isAvailable : .isEmpty
    }
}

struct NotificationVC_Previews: PreviewProvider {
    static var previews: some View {
        NotificationVC(listStatus: .notDetermine, showLoader: false, pageNo: 0, pageSize: 10, viewModel: NotificationViewModel())
    }
}
