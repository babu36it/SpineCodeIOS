//
//  PaymentView.swift
//  spine
//
//  Created by Mac on 11/08/22.
//

import SwiftUI

struct PaymentView: View {
    @Environment(\.dismiss) var dismiss
    @State var showConfirmSheet = false
    @EnvironmentObject var createAdVM: CreateAdViewModel
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 0) {
                LinearGradient(colors: [.white, Color(.sRGB, white: 0.85, opacity: 0.3)], startPoint: .bottom, endPoint: .top).frame(height: 4)//.padding(.top, 10)
                
                VStack(spacing: 20) {
                    Header3(title: "Ad Post")
                    Header5(title: "Ad type: \(createAdVM.selectedAdType)")
                    VStack {
                        Title4(title: "Duration: \(createAdVM.getOnlyDuration)")
                        Title4(title: "Start date: \(createAdVM.startDateT.toString("dd MMM yyyy"))")
                        Title4(title: "Time: \(createAdVM.startTimeT.toString("HH:mm"))") //"yyyy-MM-dd'T'HH:mm:ss"
                    }
                    Header(title: "\(createAdVM.getOnlyPrice)")
                    Divider()
                }.padding()
                
                VStack {
                    Header5(title: "Select payment method").padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    SelectionView().frame(height: 150)
                }
                
                VStack(spacing: 20) {
                    Button("See more") {
                        
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    
                    Title4(title: "By clicking “Pay Now & Publish”, you agree to the Ad Guidelines and Ad Terms and Conditions of the Spiritual Network.")
                    
                    LargeButton(title: "PAY NOW & PUBLISH", width: 300, height: 40, bColor: Color.lightBrown, fSize: 15, fColor: .white) {
                       showConfirmSheet = true
                    }
                }.padding()
            }
        }
        .fullScreenCover(isPresented: $showConfirmSheet, content: {
            PaymentConfirmView()
        })
        .navigationBarTitle(Text("PAYMENT"), displayMode: .inline)
        .modifier(BackButtonModifier(action: {
            self.dismiss()
        }))
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView()
    }
}

struct SelectionView: View {

    let paymentTypes: [PaymentType] = [.creditCard, .paypal, .bankAccount]
    @State var selectedType: PaymentType? = nil

    var body: some View {
        List {
            ForEach(paymentTypes, id: \.self) { type in
                HStack(spacing: 10) {
                    Image(systemName: type == selectedType ? "checkmark.circle" : "circle").font(.title)
                    Title4(title: type.rawValue)
                }
                .onTapGesture {
                    self.selectedType = type
                }
            }
            .listRowSeparator(.hidden)
        }.listStyle(.plain)
    }
}

struct SelectionCell: View {

    let fruit: String
    @Binding var selectedFruit: String?

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: fruit == selectedFruit ? "checkmark.circle" : "circle")
            Text(fruit)
        }   .onTapGesture {
                self.selectedFruit = self.fruit
            }
    }
}
