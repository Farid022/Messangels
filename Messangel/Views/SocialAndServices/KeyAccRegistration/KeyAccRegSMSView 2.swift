//
//  KeyAccRegSMSView.swift
//  Messangel
//
//  Created by Saad on 12/13/21.
//

import SwiftUI
import NavigationStack

struct KeyAccRegSMSView: View {
    @State var code = ""
    @EnvironmentObject private var navModel: NavigationModel
    @ObservedObject var vm: SecureAccessViewModel
    var keyAccCase: KeyAccCase
    
    var body: some View {
        NavigationStackView("KeyAccRegSMSView") {
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
                        Text("")
                            .hidden()
                        Text("Inscrivez le code reçu par SMS")
                            .padding(.bottom)
                    }
                    .font(.system(size: 17), weight: .bold)
                    .foregroundColor(.white)
                    OTPTextFieldView(code: $code)
                    Spacer()
                    HStack {
                        Spacer()
                        NextButton(isCustomAction: true, customAction: {
                            vm.otp.otp = Int(code) ?? 0
                            vm.authOTP {
                                if vm.apiResponse.message == "1" {
                                    navModel.pushContent("KeyAccRegSMSView") {
                                        destinationView()
                                    }
                                }
                            }
                        },source: "KeyAccRegSMSView", destination: destinationView(), active: .constant(code.length == 4))
                    }
//                    Spacer().frame(height: 50)
                }
                .padding()
            }
            .foregroundColor(.white)
        }
    }
    
    private func destinationView() -> AnyView {
        switch keyAccCase {
            
        case .register:
            return AnyView(KeyAccRegEmailView(keyAccCase: .register))
        case .manage:
            return AnyView(KeyMailsAndPhonesView())
        
        default:
            return AnyView(EmptyView())
        }
    }
}


