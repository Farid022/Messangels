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
    
    init(height: CGFloat = 105, title: String, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.title = title
        self.height = height
    }
    var body: some View {
        VStack(spacing: 0.0) {
            Color.accentColor
                .ignoresSafeArea()
                .frame(height: height)
                .overlay(HStack {
                    BackButton()
                        .padding(.leading)
                    Spacer()
                    Text(title)
                        .foregroundColor(.white)
                    Spacer()
                    Image("help")
                        .padding(.horizontal, -30)
                }.padding(.bottom, -30), alignment: .bottom)
            ScrollView {
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
