//
//  SignupBaseView.swift
//  Messengel
//
//  Created by Saad on 5/8/21.
//

import SwiftUIX
import NavigationStack

struct SignupBaseView<Content: View>: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @ObservedObject private var keyboardResponder = KeyboardResponder()
    @Binding private var progress: Double
    @Binding private var valid: Bool
//    @Binding private var editing: Bool
    private let content: Content
    private let destination: AnyView
    private let currentView: String
    private let footer: AnyView
    private let isCustomAction: Bool
    private let customAction: () -> Void
    
    init(isCustomAction: Bool = false, customAction: @escaping () -> Void = {}, progress: Binding<Double>, valid: Binding<Bool>, destination: AnyView, currentView: String, footer: AnyView, @ViewBuilder content: () -> Content) {
        self.content = content()
        self._progress = progress
        self._valid = valid
        self.destination = destination
        self.currentView = currentView
        self.footer = footer
//        self._editing = editing
        self.isCustomAction = isCustomAction
        self.customAction = customAction
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
                        Image("logo_only")
                            .resizable()
                            .frame(width: 139.67, height: 35.1)
                        Spacer()
                    }
                    
                    Spacer().frame(height: 15)
                    content
//                    if (Keyboard.main.isShowing && !editing) || currentView == "SignupGenderView" || currentView == "SignupPostcodeView" {
                        Spacer()
//                    }
                    HStack {
                        footer
                        Spacer()
                        if !isCustomAction {
                            NextButton(source: currentView, destination: destination, active: $valid)
                        } else {
                            NextButton(source: currentView, destination: destination, customAction: customAction, isCustomAction: isCustomAction, active: $valid)
                        }
                    }
                    SignupProgressView(progress: $progress)
                }.padding()
//                .offset(y: -keyboardResponder.currentHeight*0.85)
            }
//            .ignoresSafeArea(.keyboard)
            .foregroundColor(.white)
            .textFieldStyle(MyTextFieldStyle())
        }
    }
}
