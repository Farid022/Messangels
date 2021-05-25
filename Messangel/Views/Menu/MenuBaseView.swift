//
//  MenuBaseView.swift
//  Messangel
//
//  Created by Saad on 5/24/21.
//

import SwiftUI

struct MenuBaseView<Content: View>: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let content: Content
    var title: String
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.title = title
    }
    var body: some View {
        VStack {
            Color.accentColor
                .ignoresSafeArea()
                .frame(height: .zero)
            ScrollView {
                VStack {
                    content
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.backward").foregroundColor(.white)
        })
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
            }
        }
    }
}
