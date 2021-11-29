//
//  SignupPasswrdView.swift
//  Messengel
//
//  Created by Saad on 5/7/21.
//

import SwiftUIX
import NavigationStack

struct SignupPasswrdView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @ObservedObject var userVM: UserViewModel
    @State private var conformPassword: String = ""
    @State private var progress = 12.5 * 5
    @State private var valid = false
    @State private var hidePassword = true
    
    
    var body: some View {
        SignupBaseView(progress: $progress, valid: $valid, destination: AnyView(SignupTelIntroView(userVM: userVM)), currentView: "SignupPasswrdView", footer: AnyView(Spacer())) {
            Text("Mot de passe Messangel")
                .font(.system(size: 22))
                .fontWeight(.bold)
            Text("Créez votre mot de passe (8 caractères minimum, dont une majuscule et un chiffre)")
                .font(.system(size: 15))
                .fixedSize(horizontal: false, vertical: true)
            Group {
                MyTextField(placeholder: "Mot de passe", text: $userVM.user.password.bound, isSecureTextEntry: $hidePassword)
                MyTextField(placeholder: "Confirmez mot de passe", text: $conformPassword, isSecureTextEntry: $hidePassword, onCommit:  {
//                    if valid {
//                        navigationModel.pushContent("SignupPasswrdView") {
//                            SignupTelIntroView(userVM: userVM)
//                        }
//                    }
                })
            }
            .xTextFieldStyle()
            .overlay(HStack {
                Spacer()
                Image(systemName: hidePassword ? "eye" : "eye.slash")
                    .foregroundColor(.black)
                    .padding(.trailing, 20)
                    .animation(.default)
                    .onTapGesture {
                        hidePassword.toggle()
                    }
            })
            Text(userVM.user.password!.count < 8 ? "Sécurité : Insuffisant" : "✓ Sécurité : Bon")
                .font(.system(size: 13))
                .padding(.leading)
        }
        .onChange(of: userVM.user.password) { value in
            self.validate()
        }
        .onChange(of: self.conformPassword) { value in
            self.validate()
        }
    }
    
    private func validate() {
        self.valid = userVM.user.password!.count >= 8 && userVM.user.password! == self.conformPassword
    }
}

//struct SignupPasswrdView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignupPasswrdView()
//    }
//}

struct MyTextField: UIViewRepresentable {
    var placeholder = ""
    @Binding var text: String
    @Binding var isSecureTextEntry: Bool
    var onCommit: () -> Void = { }
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.setContentHuggingPriority(.defaultHigh, for: .vertical)
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        textField.placeholder = placeholder
       
        textField.delegate = context.coordinator
        
        _ = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: textField)
            .compactMap {
                guard let field = $0.object as? UITextField else {
                    return nil
                }
                return field.text
            }
            .sink {
                self.text = $0
            }
        
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.isSecureTextEntry = isSecureTextEntry
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: MyTextField
        
        init(_ textField: MyTextField) {
            self.parent = textField
        }
        
//        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//            if let value = textField.text {
//                parent.text = value
//                parent.onChange?(value)
//            }
//
//            return true
//        }
        func textFieldDidEndEditing(_ textField: UITextField) {
            parent.onCommit()
        }
    }
}
