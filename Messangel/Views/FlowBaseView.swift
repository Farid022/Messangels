//
//  GuardianFormBaseView.swift
//  Messangel
//
//  Created by Saad on 5/18/21.
//

import SwiftUI
import NavigationStack

struct FlowBaseView<Content: View>: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @Binding private var valid: Bool
    private var title: String
    private var menuTitle: String
    @Binding var noteText: String
    private var note: Bool
    private var addToList: Bool
    @Binding var showNote: Bool
    let content: Content
    private var destination: AnyView
    private var popToParent: Bool
    private var parentId: String
    var customAction: () -> Void = {}
    var isCustomAction: Bool
    var exitAction: () -> Void
    
    init(isCustomAction: Bool = false, customAction: @escaping () -> Void = {}, popToParent: Bool = false, parentId: String = TabBarView.id, addToList: Bool = false, noteText: Binding<String> = .constant(""), note: Bool = false, showNote: Binding<Bool> = .constant(false), menuTitle: String, title: String, valid: Binding<Bool>, destination: AnyView = AnyView(EmptyView()), exitAction: @escaping () -> Void = {}, @ViewBuilder content: () -> Content) {
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
        self.exitAction = exitAction
        self._noteText = noteText
    }
    
    var body: some View {
        NavigationStackView(title) {
            ZStack(alignment:.top) {
                Color.accentColor
                    .frame(height:70)
                    .edgesIgnoringSafeArea(.top)
                VStack(spacing: 20) {
                    NavigationTitleView(menuTitle: menuTitle, exitAction: exitAction)
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
                .padding()
            }
            .textFieldStyle(MyTextFieldStyle())
        }
    }
}

struct NavigationTitleView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    var menuTitle = ""
    var exitAction: (() -> Void)?
    var body: some View {
        VStack {
            Color.accentColor
                .frame(height:125)
                .padding(.horizontal, -20)
                .overlay(HStack {
                    VStack(alignment: .leading) {
                        Button {
                            if let exitAction = exitAction {
                                exitAction()
                            }
                            navigationModel.popContent(TabBarView.id)
                        } label: {
                           Image("ic_exit")
                        }
                        Spacer()
                        Text(menuTitle)
                            .font(.system(size: 22))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.bottom, 20)
                    }
                    Spacer()
            }, alignment: .top)
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
                    Image(note.isEmpty ? "ic_add_note" : "ic_notes")
                }
            )
    }
}
