//
//  MenuBaseView.swift
//  Messangel
//
//  Created by Saad on 5/24/21.
//

import SwiftUI

struct MenuBaseView<Content: View>: View {
    let content: Content
    var title: String
    var height: CGFloat
    var backButton: Bool
    
    init(height: CGFloat = 105, title: String, backButton: Bool = true, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.title = title
        self.height = height
        self.backButton = backButton
    }
    var body: some View {
        VStack(spacing: 0.0) {
            Color.accentColor
                .ignoresSafeArea()
                .frame(height: height)
                .overlay(HStack {
                    if backButton {
                        BackButton()
                            .padding(.leading)
                    }
                    Spacer()
                    Text(title)
                        .foregroundColor(.white)
                        .font(.system(size: 17))
                        .fontWeight(.semibold)
                    Spacer()
                    Image("help")
                        .padding(.horizontal, -30)
                }.padding(.bottom, -30), alignment: .bottom)
            ScrollView(showsIndicators: false) {
                VStack {
                    content
                }
                .padding()
                .padding(.bottom, 80)
            }
            .background(Color.white)
        }
    }
}
