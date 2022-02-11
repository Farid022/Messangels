//
//  SignupPasswrdView.swift
//  Messengel
//
//  Created by Saad on 5/7/21.
//

import SwiftUI
import NavigationStack

struct SignupPasswrdView: View {
    enum PasswordField {
        case password
        case confirmPassword
    }
    
    @EnvironmentObject var navigationModel: NavigationModel
    @ObservedObject var userVM: UserViewModel
    @State private var conformPassword: String = ""
    @State private var progress = 12.5 * 5
    @State private var valid = false
    @State private var hidePassword = true
    @FocusState private var focusedField: PasswordField?
    
    var body: some View {
        SignupBaseView(progress: $progress, valid: $valid, destination: AnyView(SignupTelIntroView(userVM: userVM)), currentView: "SignupPasswrdView", footer: AnyView(Spacer())) {
            Text("Mot de passe Messangel")
                .font(.system(size: 22))
                .fontWeight(.bold)
            Text("Créez votre mot de passe (8 caractères minimum, dont une majuscule et un chiffre)")
                .font(.system(size: 15))
                .fixedSize(horizontal: false, vertical: true)
            Group {
                MyTextField(placeholder: "Mot de passe", text: $userVM.user.password.bound, isSecureTextEntry: $hidePassword) {
                    focusedField = .confirmPassword
                }
                .focused($focusedField, equals: .password)
                MyTextField(placeholder: "Confirmez mot de passe", text: $conformPassword, isSecureTextEntry: $hidePassword) {
                    hideKeyboard()
                }
                .focused($focusedField, equals: .confirmPassword)
            }
            .xTextFieldStyle()
            .overlay(HStack {
                Spacer()
                Image(systemName: hidePassword ? "eye" : "eye.slash")
                    .foregroundColor(.black)
                    .padding(.trailing, 20)
                    .animation(.default, value: hidePassword)
                    .onTapGesture {
                        hidePassword.toggle()
                    }
            })
            Text(userVM.user.password?.count ?? 0 < 8 ? "Sécurité : Insuffisant" : "✓ Sécurité : Bon")
                .font(.system(size: 13))
                .padding(.leading)
        }
        .onDidAppear {
            focusedField = .password
        }
        .onChange(of: userVM.user.password) { value in
            self.validate()
        }
        .onChange(of: self.conformPassword) { value in
            self.validate()
        }
    }
    
    private func validate() {
        self.valid = userVM.user.password?.count ?? 0 >= 8 && userVM.user.password == self.conformPassword
    }
}

// MARK: - MyTextField
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
        textField.returnKeyType = .next
        
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
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if let currentValue = textField.text as NSString? {
                let proposedValue = currentValue.replacingCharacters(in: range, with: string) as String
                self.parent.text = proposedValue
            }
            return true
        }
//        func textFieldDidEndEditing(_ textField: UITextField) {
//            parent.onCommit()
//        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            parent.onCommit()
            return true
        }
    }
}
