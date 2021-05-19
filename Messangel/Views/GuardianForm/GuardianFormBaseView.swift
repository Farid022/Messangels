//
//  GuardianFormBaseView.swift
//  Messangel
//
//  Created by Saad on 5/18/21.
//

import SwiftUI

struct GuardianFormBaseView<Content: View>: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding private var progress: Double
    @Binding private var valid: Bool
    private var title = ""
    let content: Content
    private var destination: AnyView
    
    init(title: String, progress: Binding<Double>, valid: Binding<Bool>, destination: AnyView, @ViewBuilder content: () -> Content) {
        self.content = content()
        self._progress = progress
        self._valid = valid
        self.destination = destination
        self.title = title
    }
    
    var body: some View {
        ZStack {
            Color.accentColor
                .edgesIgnoringSafeArea(.top)
            VStack(alignment: .leading, spacing: 20) {
                VStack {
                    Color.accentColor
                        .frame(height: 35)
                    Color.white
                        .frame(height: 15)
                }
                .frame(height: 50)
                .padding(.horizontal, -16)
                .padding(.top, -16)
                .overlay(HStack {
                    Spacer()
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 60, height: 60)
                        .cornerRadius(25)
                        .shadow(color: .gray.opacity(0.2), radius: 10)
                        .overlay(Image("info"))
                })
                Text(title)
                    .fontWeight(.bold)
                    .padding(.top)
                Spacer()
                content
                Spacer()
                HStack {
                    Spacer()
                    Rectangle()
                        .fill(valid ? Color.accentColor : Color.gray.opacity(0.2))
                        .frame(width: 50, height: 50)
                        .cornerRadius(22)
                        .overlay(
                            NavigationLink(destination: destination) {
                                Image(systemName: "chevron.right").foregroundColor(valid ? Color.white : Color.gray)
                            }
                        )
                }
                SignupProgressView(progress: $progress, tintColor: .accentColor, progressMultiplier: 100/7)
            }
            .padding()
            .background(Color.white)
        }
        .textFieldStyle(MyTextFieldStyle())
        .navigationBarBackButtonHidden(true)
        .navigationTitle(Text("Ange-gardien"))
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.backward").foregroundColor(.white)
        })
    }
}
