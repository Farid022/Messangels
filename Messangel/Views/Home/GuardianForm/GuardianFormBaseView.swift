//
//  GuardianFormBaseView.swift
//  Messangel
//
//  Created by Saad on 5/18/21.
//

import SwiftUI
import NavigationStack

struct GuardianFormBaseView<Content: View>: View {
    @EnvironmentObject var navigationModel: NavigationModel
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
        NavigationStackView(title) {
            ZStack(alignment:.top) {
                Color.accentColor
                    .frame(height:70)
                    .edgesIgnoringSafeArea(.top)
                VStack(alignment: .leading, spacing: 20) {
                    Color.accentColor
                        .frame(height:90)
                        .padding(.horizontal, -20)
                        .overlay(
                    HStack {
                        BackButton()
                        Text("Quitter")
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                        Spacer()
                    }, alignment: .top)
                    
                    VStack {
                        Color.accentColor
                            .frame(height: 35)
                            .overlay(Text("Ange-gardien")
                                        .font(.system(size: 22))
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding([.leading, .bottom])
                                     ,
                                     alignment: .leading)
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
                        .font(.system(size: 17))
                        .fontWeight(.bold)
                        .padding(.top)
                    Spacer()
                    content
                    Spacer()
                    HStack {
                        Spacer()
                        Rectangle()
                            .fill(valid ? Color.accentColor : Color.gray.opacity(0.2))
                            .frame(width: 56, height: 56)
                            .cornerRadius(25)
                            .overlay(
                                Button(action: {
                                    navigationModel.pushContent(title) {
                                        destination
                                    }
                                }) {
                                    Image(systemName: "chevron.right").foregroundColor(valid ? Color.white : Color.gray)
                                }
                            )
                    }
                    SignupProgressView(progress: $progress, tintColor: .accentColor, progressMultiplier: 100/7)
                }
                .padding()
//                .background(Color.white)
            }
            .textFieldStyle(MyTextFieldStyle())
            .navigationTitle(Text("Ange-gardien"))
        }
    }
}
