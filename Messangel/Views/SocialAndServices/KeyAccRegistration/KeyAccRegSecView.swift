//
//  KeyAccRegSecView.swift
//  Messangel
//
//  Created by Saad on 12/13/21.
//

import SwiftUI
import NavigationStack

struct KeyAccRegSecView: View {
    @StateObject private var vm = SecureAccessViewModel()
    @EnvironmentObject private var navModel: NavigationModel
    var keyAccCase: KeyAccCase
    
    var body: some View {
        NavigationStackView("KeyAccRegSecView") {
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
                                    navModel.pushContent("KeyAccRegSecView") {
                                        KeyAccRegSMSView(vm: vm, keyAccCase: keyAccCase)
                                    }
                                }
                            }
                        },source: "KeyAccRegSecView", destination: AnyView(KeyAccRegSMSView(vm: vm, keyAccCase: keyAccCase)), active: .constant(!vm.password.password.isEmpty))
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

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        KeyAccRegSecView()
//    }
//}


