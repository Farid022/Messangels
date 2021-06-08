//
//  SignupBaseView.swift
//  Messengel
//
//  Created by Saad on 5/8/21.
//

import SwiftUI
import NavigationStack

struct SignupBaseView<Content: View>: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @ObservedObject private var keyboardResponder = KeyboardResponder()
    @Binding private var progress: Double
    @Binding private var valid: Bool
    private let content: Content
    private let destination: AnyView
    private let currentView: String
    private let footer: AnyView
    
    init(progress: Binding<Double>, valid: Binding<Bool>, destination: AnyView, currentView: String, footer: AnyView, @ViewBuilder content: () -> Content) {
        self.content = content()
        self._progress = progress
        self._valid = valid
        self.destination = destination
        self.currentView = currentView
        self.footer = footer
    }
    
    var body: some View {
        NavigationStackView(currentView) {
            ZStack {
                Color.accentColor
                    .ignoresSafeArea()
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        BackButton()
                        Spacer()
                        Image("logo")
                            .resizable()
                            .frame(width: 139.67, height: 47.89)
                        Spacer()
                    }
                    Spacer()
                    content
                    if keyboardResponder.currentHeight == 0 {
                        Spacer()
                    }
                    HStack {
                        footer
                        Spacer()
                        NextButton(source: currentView, destination: destination, active: $valid)
                    }
                    SignupProgressView(progress: $progress)
                }.padding()
                .offset(y: -keyboardResponder.currentHeight*0.85)
            }
            .ignoresSafeArea(.keyboard)
            .foregroundColor(.white)
            .textFieldStyle(MyTextFieldStyle())
        }
    }
}
