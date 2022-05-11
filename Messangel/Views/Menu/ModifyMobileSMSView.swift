//
//  KeyAccRegSecView.swift
//  Messangel
//
//  Created by Saad on 12/13/21.
//

import SwiftUI
import NavigationStack

struct ModifyMobileSMSView: View {
    @StateObject private var vm = SecureAccessViewModel()
    @EnvironmentObject private var navModel: NavigationModel
    @Binding var new_mobile: String
    var body: some View {
        NavigationStackView(String(describing: Self.self)) {
            ZStack(alignment: .top) {
                Color.accentColor
                    .ignoresSafeArea()
                VStack(spacing: 7) {
                    HStack {
                        BackButton()
                        Spacer()
                    }
                    Spacer()
                    Image("ic_lock_white")
                    Group {
                        Text("Accès sécurisé")
                        Text("Entrez votre mot de passe Messangel")
                            .padding(.bottom)
                    }
                    .font(.system(size: 17), weight: .bold)
                    SecureField("Mot de passe", text: $vm.password.password)
                        .textFieldStyle(MyTextFieldStyle())
                    Spacer()
                        .frame(height: 100)
                    MyLink(text: "Politique de confidentialité", fontSize: 15)
                    Spacer()
                    HStack {
                        Spacer()
                        NextButton(isCustomAction: true, customAction: {
                            vm.authPassword {
                                if vm.apiResponse.message == "1" {
                                    navModel.pushContent(String(describing: Self.self)) {
                                        ModifyMobileOTPView(new_mobile: $new_mobile, vm: vm)
                                    }
                                }
                            }
                        },source: "KeyAccRegSecView", active: .constant(!vm.password.password.isEmpty))
                    }
                    Spacer()
                        .frame(height: 50)
                }
                .foregroundColor(.white)
                .padding()
            }
        }
    }
}


