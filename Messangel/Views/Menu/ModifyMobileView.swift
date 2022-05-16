//
//  ModifyPasswordView.swift
//  Messangel
//
//  Created by Saad on 7/19/21.
//

import SwiftUIX
import Combine
import NavigationStack

struct ModifyMobileView: View {
    @EnvironmentObject private var auth: Auth
    @EnvironmentObject private var navModel: NavigationModel
    @State private var new_mobile = ""
    @State private var apiResponse = APIService.APIResponse(message: "")
    @State private var apiError = APIService.APIErr(error: "", error_description: "")
    @State private var valid = false
    @State private var editing = false
    
    var body: some View {
        NavigationStackView(String(describing: Self.self)) {
        MenuBaseView(title: "Modifier téléphone mobile") {
            if !editing {
                AccessSecurityHeader()
            }
            HStack {
                VStack(spacing: 20) {
                    Text("Téléphone mobile actuel")
                        .font(.system(size: 17), weight: .bold)
                    Text(auth.user.phone_number.separate())
                        .font(.system(size: 15))
                        .foregroundColor(.secondary)
                        .padding(.leading, -90)
                }
                Spacer()
            }
            .padding(.bottom)
            HStack {
                Text("Nouveau téléphone mobile")
                    .font(.system(size: 17))
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                Spacer()
            }
            CocoaTextField("Numéro de téléphone", text: $new_mobile) { isEditing in
                self.editing = isEditing
            }
            .keyboardType(.numberPad)
            .textContentType(.telephoneNumber)
            .xTextFieldStyle()
            .normalShadow()
            .padding(.bottom, 30)
            
            Button(action: {
                if !valid {
                    return
                }
                navModel.pushContent(String(describing: Self.self)) {
                    ModifyMobileSecView(new_mobile: $new_mobile)
                }
            }, label: {
                Text("Enregister")
            })
            .buttonStyle(MyButtonStyle(foregroundColor: .white, backgroundColor: .accentColor))
        }
    }
        .textFieldStyle(MyTextFieldStyle())
        .onReceive(Just(new_mobile)) { inputValue in
            if inputValue.count > 17 {
                new_mobile.removeLast()
            }
        }
        .onChange(of: new_mobile) { value in
            new_mobile = value.applyPatternOnNumbers(pattern: "## ## ## ## ## ##", replacmentCharacter: "#")
            self.validate()
        }
    }
    
    private func validate() {
        self.valid = new_mobile.replacingOccurrences(of: " ", with: "") != auth.user.phone_number && (new_mobile.count == 14 || new_mobile.count == 17)
    }
}
