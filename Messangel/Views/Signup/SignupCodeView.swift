//
//  SignupCodeView.swift
//  Messengel
//
//  Created by Saad on 5/7/21.
//

import SwiftUI
import Combine

struct SignupCodeView: View {
    @State private var progress = 12.5 * 7
    @State private var valid = false
    @State private var code: String = ""
    var body: some View {
        SignupBaseView(progress: $progress, valid: $valid, destination: AnyView(SignupDoneView()), footer: AnyView(HStack {
            Spacer()
            VStack {
                Text("Provient de message")
                Text("0000").underline()
            }
            Spacer()
        })) {
            Text("Inscrivez le code reçu par SMS")
                .font(.title2)
                .fontWeight(.bold)
            Spacer().frame(height: 50)
            
            CodeView(code: $code)
                .overlay(
                    TextField("", text: $code)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .keyboardType(.numberPad)
                        .textContentType(.oneTimeCode)
                        .accentColor(.white)
                        .opacity(0.1)
                        .padding(.horizontal, 50)
                        .onReceive(Just(code)) { inputValue in
                            if inputValue.count > 4 {
                                code.removeLast()
                            }
                        })
        }
    }
}

struct SignupCodeView_Previews: PreviewProvider {
    static var previews: some View {
        SignupCodeView()
    }
}

struct CodeView: View {
    @Binding var code: String
    
    var body: some View {
        HStack(spacing: 20){
            Spacer()
            ForEach(0..<4,id: \.self){index in
                VStack {
                    Rectangle()
                        .frame(width: 50,height: 50)
                        .cornerRadius(23)
                        .overlay(
                            VStack {
                                if code.count > index {
                                    Text("\(code[index].description)")
                                        .foregroundColor(.black)
                                        .font(.system(size: 20))
                                } else {
                                    Spacer().frame(height: 30)
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.8))
                                        .frame(width: 13, height: 3)
                                }
                            }
                        )
                }
            }
            Spacer()
        }
    }
}


