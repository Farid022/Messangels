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
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.title = title
    }
    var body: some View {
        VStack(spacing: 0.0) {
            Color.accentColor
                .ignoresSafeArea()
                .frame(height: 105)
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
