//
//  GuardianFormBaseView.swift
//  Messangel
//
//  Created by Saad on 5/18/21.
//

import SwiftUI
import NavigationStack

struct FlowBaseView<Content: View>: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    @State private var showExitAlert = false
    @Binding var valid: Bool
    @Binding var noteText: String
    @Binding var showNote: Bool
    private var tab: Int
    private var stepNumber: Double
    private var totalSteps: Double
    private var title: String
    private var menuTitle: String
    private var note: Bool
    private var addToList: Bool
    private let content: Content
    private var destination: AnyView
    private var popToParent: Bool
    private var parentId: String
    var isCustomAction: Bool
    var customAction: () -> Void = {}
    
    init(tab: Int = 0, stepNumber: Double, totalSteps: Double, isCustomAction: Bool = false, customAction: @escaping () -> Void = {}, popToParent: Bool = false, parentId: String = TabBarView.id, addToList: Bool = false, noteText: Binding<String> = .constant(""), note: Bool = false, showNote: Binding<Bool> = .constant(false), menuTitle: String, title: String, valid: Binding<Bool>, destination: AnyView = AnyView(EmptyView()), exitAction: @escaping () -> Void = {}, @ViewBuilder content: () -> Content) {
        self.content = content()
        self._valid = valid
        self.destination = destination
        self.title = title
        self.menuTitle = menuTitle
        self.note = note
        self._showNote = showNote
        self.addToList = addToList
        self.parentId = parentId
        self.popToParent = popToParent
        self.isCustomAction = isCustomAction
        self.customAction = customAction
        self._noteText = noteText
        self.stepNumber = stepNumber
        self.totalSteps = totalSteps
        self.tab = tab
    }
    
    var body: some View {
        ZStack {
            NavigationStackView(title) {
                ZStack(alignment:.top) {
                    GeometryReader { proxy in
                        Color.accentColor
                            .frame(height: proxy.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    }
                    VStack(spacing: 20) {
                        NavigationTitleView(stepNumber: stepNumber, totalSteps: totalSteps, menuTitle: menuTitle, confirmExit: false, showExitAlert: $showExitAlert)
                        if addToList {
                            Spacer()
                            Text(title)
                                .font(.system(size: 17))
                                .fontWeight(.bold)
                            Button(action: {
                                navigationModel.pushContent(title) {
                                    destination
                                }
                            }, label: {
                                Image("ic_add_btn")
                            })
                            Spacer()
                        }
                        else {
                            FlowBaseTitleView(title: title)
                            content
                            Spacer()
                            HStack {
                                if note {
                                    FlowNoteButtonView(showNote: $showNote, note: $noteText)
                                }
                                Spacer()
                                FlowNextButtonView(valid: $valid, title: title, destination: destination, popToParent: popToParent, parentId: parentId, customAction: customAction, isCustomAction: isCustomAction)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
                .textFieldStyle(MyTextFieldStyle())
            }
            if showExitAlert {
                Color.black.opacity(0.8)
                    .ignoresSafeArea()
                    .overlay(MyAlert(title: "Quitter \(self.menuTitle)", message: "Vos modifications ne seront pas enregistrées.", ok: "Oui", cancel: "Non", action: {
                        WishesViewModel.setProgress(Int((stepNumber/totalSteps)*100.0), tab: self.tab) { _ in
                            navigationModel.popContent(TabBarView.id)
                        }
                    }, showAlert: $showExitAlert))
            }
        }
    }
}

struct NavigationTitleView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    var stepNumber = 0.0
    var totalSteps = 0.0
    var menuTitle = ""
    var confirmExit = false
    @Binding var showExitAlert: Bool
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Color.accentColor
                    .frame(height:140)
                    .padding(.horizontal, -20)
                    .overlay(
                        HStack {
                        VStack(alignment: .leading) {
                            Button {
                                if confirmExit {
                                    showExitAlert.toggle()
                                } else
                                {
                                    navigationModel.popContent(TabBarView.id)
                                }
                            } label: {
                               Image("ic_exit")
                            }
                            .padding(.top)
                            Spacer()
                            Text(menuTitle)
                                .font(.system(size: 22))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.bottom, 20)
                        }
                        Spacer()
                    }, alignment: .top)
                if totalSteps > 0.0 {
                    FlowProgressView(progress: .constant((100/totalSteps)*stepNumber), progressMultiplier: 100/totalSteps)
                        .shadow(radius: 5)
                        .offset(y: 2)
                }
            }
            HStack {
                Spacer()
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 60, height: 60)
                    .cornerRadius(25)
                    .normalShadow()
                    .overlay(Image("info"))
            }
            .padding(.top, -40)
        }
    }
}

struct FlowBaseTitleView: View {
    var title: String
    
    var body: some View {
        VStack(spacing: 0.0) {
            HStack {
                BackButton(iconColor: .gray)
                Spacer()
            }
            HStack {
                Text(title)
                    .font(.system(size: 17))
                    .fontWeight(.bold)
                    .padding(.top)
                Spacer()
            }
            .padding(.bottom)
        }
        .padding(.top, -20)
    }
}

struct FlowNextButtonView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @Binding var valid: Bool
    var title: String
    var destination: AnyView
    var popToParent: Bool
    var parentId: String
    var customAction: () -> Void
    var isCustomAction: Bool
    
    var body: some View {
        Rectangle()
            .fill(valid ? Color.accentColor : Color.gray.opacity(0.2))
            .frame(width: 56, height: 56)
            .cornerRadius(25)
            .overlay(
                Button(action: {
                    if !valid {
                        return
                    }
                    if isCustomAction {
                        customAction()
                    }
                    else if popToParent {
                        navigationModel.popContent(parentId)
                    } else {
                        navigationModel.pushContent(title) {
                            destination
                        }
                    }
                }) {
                    Image(systemName: "chevron.right").foregroundColor(valid ? Color.white : Color.gray)
                }
            )
    }
}

struct FlowNoteButtonView: View {
    @Binding var showNote: Bool
    @Binding var note: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .foregroundColor(note.isEmpty ? .gray : .accentColor)
            .frame(width: 56, height: 56)
            .overlay(
                Button(action: {
                    showNote.toggle()
                }) {

                    Image(note.isEmpty ? "ic_notes" : "ic_notes")
                    
                }
            )
    }
}
