//
//  SignupOTPView.swift
//  Messangel
//
//  Created by Saad on 5/9/21.
//

import SwiftUI

struct SignupOTPView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var progress = 12.5 * 7
    @State private var valid = false
    @State private var code: String = ""
    var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
                Color.accentColor
                    .ignoresSafeArea()
                VStack(alignment: .leading) {
                    Spacer().frame(height: 50)
                    Text("Inscrivez le code reçu par SMS")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer().frame(height: 50)
                    CodeView(code: $code)
                    Spacer()
                    HStack {
                        Spacer()
                        VStack {
                            Text("Provient de message")
                            Text("0000").underline()
                        }
                        Spacer()
                        Rectangle()
                            .frame(width: 50, height: 50)
                            .cornerRadius(20)
                            .opacity(valid ? 1 : 0.5)
                            .overlay(
                                NavigationLink(destination: SignupDoneView()) {
                                    Image(systemName: "chevron.right").foregroundColor(.accentColor)
                                }
                                .isDetailLink(false)
                            )
                    }
                    Spacer()
                    SignupProgressView(progress: $progress)
                        .padding(.bottom, 1)
                }.padding(.horizontal)
            }
            .foregroundColor(.white)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.backward").foregroundColor(.white)
            })
            CustomNumberPad(value: $code, valid: $valid)
        }
        .background(Color("bg").ignoresSafeArea(.all, edges: .bottom))
    }
}

struct SignupOTPView_Previews: PreviewProvider {
    static var previews: some View {
        SignupOTPView()
    }
}
