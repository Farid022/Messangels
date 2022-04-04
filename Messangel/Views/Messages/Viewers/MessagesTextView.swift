//
//  MessagesTextView.swift
//  Messangel
//
//  Created by Saad on 1/30/22.
//

import SwiftUI
import WebKit
import NavigationStack

struct MessagesTextView: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    @StateObject private var vm = TextViewModel()
    @State private var showDeleteConfirm = false
    @State private var deleting = false
    var text: MsgText
    var headerImage: String
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
            VStack(spacing: 0.0) {
                MessagesViewerTopbar {
                    
                } deleteAction: {
                    showDeleteConfirm.toggle()
                }

                Image(headerImage)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width - 20, height: 90)
                HTMLStringView(htmlUrl: text.message)
                    .padding(.horizontal, 10)
                Spacer()
            }
            DetailsDeleteView(showDeleteConfirm: $showDeleteConfirm, alertTitle: "Supprimer ce message", confirmMessage: "Êtes-vous sur de vouloir supprimer ce message texte ?") {
                deleting.toggle()
                vm.delete(id: text.id) { success in
                    deleting.toggle()
                    if success {
                        navigationModel.popContent(TabBarView.id)
                    }
                }
            }
            if deleting {
                Loader()
            }
        }
    }
}

struct HTMLStringView: UIViewRepresentable {
    let htmlUrl: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        do {
            if let url = URL(string: htmlUrl) {
                let htmlContent = try String(contentsOf: url, encoding: .utf8)
                uiView.loadHTMLString(htmlContent, baseURL: nil)
            }
        } catch let error {
            print("HTML Load Error: \(error)")
        }
    }
}
