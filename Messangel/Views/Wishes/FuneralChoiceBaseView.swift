//
//  GuardianFormBaseView.swift
//  Messangel
//
//  Created by Saad on 5/18/21.
//

import SwiftUI
import NavigationStack

struct FuneralChoiceBaseView<Content: View>: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @Binding private var valid: Bool
    private var title = ""
    private var menuTitle = ""
    private var note = false
    private var addToList = false
    @Binding var showNote: Bool
    let content: Content
    private var destination: AnyView
    
    init(addToList: Bool = false, note: Bool = false, showNote: Binding<Bool> = .constant(false), menuTitle: String, title: String, valid: Binding<Bool>, destination: AnyView, @ViewBuilder content: () -> Content) {
        self.content = content()
        self._valid = valid
        self.destination = destination
        self.title = title
        self.menuTitle = menuTitle
        self.note = note
        self._showNote = showNote
        self.addToList = addToList
    }
    
    var body: some View {
        NavigationStackView(title) {
            ZStack(alignment:.top) {
                Color.accentColor
                    .frame(height:70)
                    .edgesIgnoringSafeArea(.top)
                VStack(spacing: 20) {
                    Color.accentColor
                        .frame(height:90)
                        .padding(.horizontal, -20)
                        .overlay(
                    HStack {
                        BackButton()
                        Text("Quitter")
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                        Spacer()
                    }, alignment: .top)
                    
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
                    HStack {
                        Text(title)
                            .font(.system(size: 17))
                            .fontWeight(.bold)
                            .padding(.top)
                        Spacer()
                    }
                    .padding(.bottom)
                    content
                    Spacer()
                    HStack {
                        if note {
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
                        Spacer()
                        Rectangle()
                            .fill(valid ? Color.accentColor : Color.gray.opacity(0.2))
                            .frame(width: 56, height: 56)
                            .cornerRadius(25)
                            .overlay(
                                Button(action: {
                                    if !valid {
                                        return
                                    }
                                    navigationModel.pushContent(title) {
                                        destination
                                    }
                                }) {
                                    Image(systemName: "chevron.right").foregroundColor(valid ? Color.white : Color.gray)
                                }
                            )
                    } // HStack
                    }
                }
                .padding()
//                .background(Color.white)
            }
            .textFieldStyle(MyTextFieldStyle())
        }
    }
}
