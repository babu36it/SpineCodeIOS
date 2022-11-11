//
//  NotificationListCell.swift
//  Populist
//
//  Created by Mitun Patel on 12/07/21.
//

import SwiftUI

struct NotificationListCell: View {
    @State var notificationDetailModel : NotificationModel!
    @State private var isExpand: Bool = false
    @State private var isRead: Bool = false
    
    let collepsExpandCompletion: (_ obj:NotificationModel?) -> ()
    let readCompletion: (_ status:Bool, _ obj:NotificationModel?) -> ()
    
    var body: some View {
        
        VStack {
            HStack {
                Text(notificationDetailModel.title ?? "")
                    .lineLimit(nil)
                    .font(.custom(FontStyle.Montserrat_Medium.rawValue, size: 16))
                    .foregroundColor(Color.init(K.appColors.primaryBlack))
                    .padding([.top, .leading, .trailing], 20)
                    .multilineTextAlignment(.leading)
                Spacer()
                Text(notificationDetailModel.toDateValue())
                    .font(.custom(FontStyle.Montserrat_Regular.rawValue, size: 16))
                    .foregroundColor(Color.init(K.appColors.grey1))
                    .padding(.trailing, 10)
                    .multilineTextAlignment(.trailing)
            }
            if let desc = notificationDetailModel.desc,
               desc.isEmpty == false {
                HStack {
                    Text(desc)
                        .multilineTextAlignment(.leading)
                        .lineLimit((notificationDetailModel.isExpand) ? nil : 2)
                        .font(.custom(FontStyle.Montserrat_Regular.rawValue, size: 14))
                        .foregroundColor(Color.init(K.appColors.primaryBlack))
                        .padding(.top, 10)
                        .padding([.leading, .trailing], 20)
                        .padding(.bottom, 10)
                    Spacer()
                }
            }
            Divider()
        }
        .background(self.notificationDetailModel.isNotificationRead() ? .white : Color.init(K.appColors.grey4))
        .padding([.leading, .trailing], 20)
        .onTapGesture {
            updateNotification()
        }
    }
    
    func updateNotification() {
        let isReadNotification = notificationDetailModel.isNotificationRead()
        notificationDetailModel.isExpand = !notificationDetailModel.isExpand
        collepsExpandCompletion(notificationDetailModel)
        guard isReadNotification == false,
            let notficationId = notificationDetailModel.notficationId else { return }
        NotificationViewModel.readUnreadNotification(notificationId: notficationId, isRead: isReadNotification ? 0 : 1) { (status) in
            self.notificationDetailModel.isRead = isReadNotification ? 0 : 1
            readCompletion(status, self.notificationDetailModel)
        }
    }
}

struct NotificationListCell_Previews: PreviewProvider {
    static var previews: some View {
        
        NotificationListCell(notificationDetailModel: NotificationModel.init(title: "Your ballot has been submitted successfully dabnd ada nmadna d!", desc: "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet. \nAmet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet. ", date: "22 m"), collepsExpandCompletion: { (_) in
            //
        }, readCompletion: { (_, _) in
            //
        })
    }
}
