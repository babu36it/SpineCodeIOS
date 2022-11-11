//
//  NotificationCell.swift
//  Populist
//
//  Created by Bharat Jadav on 02/07/21.
//

import SwiftUI

struct NotificationCell: View {
    @State var strTitle : String = ""
    @State var strImage : String = ""
    @State var isSwitchON : Bool = AppUtility.shared.userSettings.isNOtificationON
    var viewModel : ProfileViewModel? = ProfileViewModel()
    @State var isON: Int = AppUtility.shared.userSettings.isNOtificationON ? 1 : 0
    
    let callback: (Bool, Error?) -> ()
    
    var body: some View {
        HStack {
            Image(strImage)
                .frame(width : 30.0, height : 50.0)
                .padding(.leading, 10)
            Text(strTitle)
                .font(.custom(FontStyle.Montserrat_Regular.rawValue, size: 16))
                .foregroundColor(Color.init(K.appColors.primaryBlack))
                .padding(.leading, 10)
            Spacer()
            Image(isSwitchON ? K.imgNames.switchON : K.imgNames.switchOFF)
                .frame(width : 50.0, height : 50.0)
                .onTapGesture {
                    isSwitchON.toggle()
                    updateNotification()
                }
        }
        .padding([.leading, .trailing], 10)
    }
}

struct NotificationCell_Previews: PreviewProvider {
    static var previews: some View {
        NotificationCell(strTitle: K.appHeaderTitle.notifications, strImage: K.imgNames.notificationTab, callback: { show, error  in
        })
    }
}

extension NotificationCell {
    func updateNotification() {
        var params = [String : Any]()
        isON = self.isSwitchON ? 1 : 0
        params["status"] = self.isON
        self.viewModel?.updateNotificationPreference(parameters: params, completion: { (success, error) in
            if success {
                AppUtility.shared.userSettings.isNOtificationON = isSwitchON
            }
            callback(success, error)
        })
    }
}
