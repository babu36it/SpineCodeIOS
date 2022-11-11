//
//  TextFieldWithBottomLine.swift
//  spine

import SwiftUI
import UIKit
import Combine

struct TextFieldWithBottomLine: View {
    @State var text: String = ""
    private var placeholder = ""
    private let lineThickness = CGFloat(1.0)

    init(placeholder: String) {
        self.placeholder = placeholder
    }

    var body: some View {
        VStack {
            TextField(placeholder, text: $text)
                .font(.custom(FontStyle.Montserrat_SemiBold.rawValue, size: 20))
            HorizontalLine(color: Color.init(K.appColors.grey2))
        }.padding(.bottom, lineThickness)
    }
}

struct TextFieldWithBottomLine_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldWithBottomLine(placeholder: "Placeholder")
    }
}

struct SecureFieldWithBottomLine: View {
    @State var text: String = ""
    private var placeholder = ""
    private let lineThickness = CGFloat(1.0)

    init(placeholder: String) {
        self.placeholder = placeholder
    }

    var body: some View {
        VStack {
            SecureField(placeholder, text: $text)
                .font(.custom(FontStyle.Montserrat_SemiBold.rawValue, size: 20))
            HorizontalLine(color: Color.init(K.appColors.grey2))
        }.padding(.bottom, lineThickness)
    }
}

struct HorizontalLineShape: Shape {
    func path(in rect: CGRect) -> Path {
        let fill = CGRect(x: 0, y: 0, width: rect.size.width, height: rect.size.height)
        var path = Path()
        path.addRoundedRect(in: fill, cornerSize: CGSize(width: 2, height: 2))
        return path
    }
}

struct HorizontalLine: View {
    private var color: Color? = nil
    private var height: CGFloat = 1.0

    init(color: Color, height: CGFloat = 1.0) {
        self.color = color
        self.height = height
    }

    var body: some View {
        HorizontalLineShape().fill(self.color!).frame(minWidth: 0, maxWidth: .infinity, minHeight: height, maxHeight: height)
    }
}

struct HorizontalLine_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalLine(color: Color.init(K.appColors.grey2))
    }
}

struct CustomInputTextField : UIViewRepresentable {

    @Binding var text: String
    var placeholder: String
    var keyboardType : UIKeyboardType

    let textField = UITextField(frame: CGRect(x:0, y:0, width: 100, height: 32))

    func makeUIView(context: UIViewRepresentableContext<CustomInputTextField>) -> UITextField {
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<CustomInputTextField>) {
        self.textField.text = text
        self.textField.placeholder = placeholder
        self.textField.keyboardType = keyboardType
        self.textField.font = UIFont(name: FontStyle.Montserrat_Regular.rawValue, size: 16)
    }

    func makeCoordinator() -> CustomInputTextField.Coordinator {
        let coordinator = Coordinator(self)

        // configure a toolbar with a Done button
        let toolbar = UIToolbar()
        toolbar.setItems([
            // just moves the Done item to the right
            UIBarButtonItem(
                barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace
                , target: nil
                , action: nil
            )
            , UIBarButtonItem(
                title: "Done"
                , style: UIBarButtonItem.Style.done
                , target: coordinator
                , action: #selector(coordinator.onSet)
            )
            ]
            , animated: true
        )
        toolbar.barStyle = UIBarStyle.default
        toolbar.sizeToFit()

        textField.inputAccessoryView = toolbar
        return coordinator
    }

    typealias UIViewType = UITextField

    class Coordinator: NSObject {
        let owner: CustomInputTextField
        private var subscriber: AnyCancellable

        init(_ owner: CustomInputTextField) {
            self.owner = owner
            subscriber = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: owner.textField)
                .sink(receiveValue: { _ in
                    owner.$text.wrappedValue = owner.textField.text ?? ""
                })
        }

        @objc fileprivate func onSet() {
            owner.textField.resignFirstResponder()
        }
    }
}
