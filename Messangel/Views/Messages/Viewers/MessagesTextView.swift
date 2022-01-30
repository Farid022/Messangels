//
//  MessagesTextView.swift
//  Messangel
//
//  Created by Saad on 1/30/22.
//

import SwiftUI
import WebKit

struct MessagesTextView: View {
    var htmlUrl: String
    var headerImage: String
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
            VStack(spacing: 0.0) {
                MessagesViewerTopbar()
                Image(headerImage)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width - 20, height: 90)
                HTMLStringView(htmlUrl: htmlUrl)
                    .padding(.horizontal, 10)
                Spacer()
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
