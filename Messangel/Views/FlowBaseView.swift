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
    
    init(isCustomAction: Bool = false, customAction: @escaping () -> Void = {}, popToParent: Bool = false, parentId: String = TabBarView.id, addToList: Bool = false, note: Bool = false, showNote: Binding<Bool> = .constant(false), menuTitle: String, title: String, valid: Binding<Bool>, destination: AnyView = AnyView(EmptyView()), exitAction: @escaping () -> Void = {}, @ViewBuilder content: () -> Content) {
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
    }
    
    var body: some View {
        NavigationStackView(title) {
            ZStack(alignment:.top) {
                Color.accentColor
                    .frame(height:70)
                    .edgesIgnoringSafeArea(.top)
                VStack(spacing: 20) {
                    if menuTitle.components(separatedBy: "#").count > 1 {
                        NavbarButtonView(title: menuTitle.components(separatedBy: "#")[0], exitAction: exitAction)
                        NavigationTitleView(menuTitle: menuTitle.components(separatedBy: "#")[1])
                    } else {
                        NavbarButtonView(exitAction: exitAction)
                        NavigationTitleView(menuTitle: menuTitle)
                    }
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
                                FlowNoteButtonView(showNote: $showNote)
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
    var menuTitle: String
    
    var body: some View {
        VStack {
            Color.accentColor
                .frame(height: 35)
                .overlay(Text(menuTitle)
                            .font(.system(size: 22))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding([.leading, .bottom])
                         ,
                         alignment: .leading)
            Color.white
                .frame(height: 15)
        }
        .frame(height: 50)
        .padding(.horizontal, -16)
        .padding(.top, -16)
        .overlay(HStack {
            Spacer()
            Rectangle()
                .fill(Color.white)
                .frame(width: 60, height: 60)
                .cornerRadius(25)
                .normalShadow()
                .overlay(Image("info"))
        })
    }
}

struct NavbarButtonView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    var title = ""
    var exitAction: () -> Void
    var body: some View {
        Color.accentColor
            .frame(height:90)
            .padding(.horizontal, -20)
            .overlay(HStack {
                VStack(alignment: .leading) {
                    Button {
                        exitAction()
                        navigationModel.popContent(TabBarView.id)
                    } label: {
                       Image("ic_exit")
                    }
                    Text(title)
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                Spacer()
            }, alignment: .top)
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
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .foregroundColor(.gray)
            .frame(width: 56, height: 56)
            .overlay(
                Button(action: {
                    showNote.toggle()
                }) {
                    Image("ic_add_note")
                }
            )
    }
}
