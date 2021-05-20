//
//  SignupBaseView.swift
//  Messengel
//
//  Created by Saad on 5/8/21.
//

import SwiftUI

struct SignupBaseView<Content: View>: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject private var keyboardResponder = KeyboardResponder()
    @Binding private var progress: Double
    @Binding private var valid: Bool
    let content: Content
    private var destination: AnyView
    private var footer: AnyView
    
    init(progress: Binding<Double>, valid: Binding<Bool>, destination: AnyView, footer: AnyView, @ViewBuilder content: () -> Content) {
        self.content = content()
        self._progress = progress
        self._valid = valid
        self.destination = destination
        self.footer = footer
    }
    
    var body: some View {
        ZStack {
            Color.accentColor
                .ignoresSafeArea()
                .toolbar{
                    ToolbarItem(placement: .principal) {
                        Image("logo")
                            .resizable()
                            .frame(width: 128.33, height: 44)
                    }
                }
            VStack(alignment: .leading, spacing: 20) {
                Spacer()
                content
                if keyboardResponder.currentHeight == 0 {
                    Spacer()
                }
                HStack {
                    footer
                    Spacer()
                    Rectangle()
                        .frame(width: 50, height: 50)
                        .cornerRadius(20)
                        .opacity(valid ? 1 : 0.5)
                        .overlay(
                            NavigationLink(destination: destination) {
                                Image(systemName: "chevron.right").foregroundColor(.accentColor)
                            }
                            
                        )
                }
                SignupProgressView(progress: $progress)
            }.padding()
            .offset(y: -keyboardResponder.currentHeight*0.85)
        }
        .ignoresSafeArea(.keyboard)
        .foregroundColor(.white)
        .textFieldStyle(MyTextFieldStyle())
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.backward").foregroundColor(.white)
        })
    }
}
