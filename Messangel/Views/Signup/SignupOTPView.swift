//
//  SignupOTPView.swift
//  Messangel
//
//  Created by Saad on 5/9/21.
//

import SwiftUI
import NavigationStack

struct SignupOTPView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var progress = 12.5 * 7
    @State private var valid = false
    @State private var code: String = ""
    
    var body: some View {
        NavigationStackView("SignupOTPView") {
            VStack {
                ZStack(alignment: .topLeading) {
                    Color.accentColor
                        .ignoresSafeArea()
                    VStack(alignment: .leading) {
                        BackButton()
                        Spacer()
                        Text("Inscrivez le code reçu par SMS")
                            .font(.system(size: 22))
                            .fontWeight(.bold)
                        Spacer().frame(height: 50)
                        CodeView(code: $code)
                        Spacer()
                        HStack {
                            Spacer()
                            VStack {
                                Text("Provient de message")
                                    .font(.system(size: 13))
                                Text("0000")
                                    .font(.system(size: 17))
                                    .underline()
                            }
                            Spacer()
                            NextButton(source: "SignupOTPView", destination: AnyView(SignupDoneView()), active: $valid)
                        }
                        .padding(.bottom)
                        SignupProgressView(progress: $progress)
                            .padding(.bottom, 1)
                    }.padding(.horizontal)
                }
                .foregroundColor(.white)
                CustomNumberPad(value: $code, valid: $valid)
            }
            .background(Color("bg").ignoresSafeArea(.all, edges: .bottom))
        }
    }
}

struct SignupOTPView_Previews: PreviewProvider {
    static var previews: some View {
        SignupOTPView()
    }
}
