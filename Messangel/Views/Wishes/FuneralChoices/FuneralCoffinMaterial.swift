//
//  FuneralCoffinMaterial.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralCoffinMaterial: View {
    var choices = ["Chêne", "Sapin", "Pin"]
    var funeralType: FuneralType
    @State private var selectedChoice = ""
    @State private var noteText = ""
    var body: some View {
        FuneralChoicesView(noteText: $noteText, choices: choices, selectedChoice: $selectedChoice, menuTitle: "Choix funéraires", title: "Choisissez un matériau pour le cercueil", destination: AnyView(FuneralCoffinShape(funeralType: funeralType)))
    }
}

struct FuneralChoicesView: View {
    @State var showNote = false
    @Binding var noteText: String
    var choices: [String]
    @Binding var selectedChoice: String
    var menuTitle: String
    var title: String
    var destination: AnyView
    
    var body: some View {
        ZStack {
            if showNote {
                FuneralNote(showNote: $showNote, note: $noteText)
                 .zIndex(1.0)
                 .background(.black.opacity(0.8))
                 .edgesIgnoringSafeArea(.top)
            }
            FuneralChoiceBaseView(note: true, showNote: $showNote, menuTitle: menuTitle, title: title, valid: .constant(!selectedChoice.isEmpty), destination: destination) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: -70){
                        ForEach(choices, id: \.self) { choice in
                            VStack(spacing: 0) {
                                Image(choice)
                                Rectangle()
                                    .foregroundColor(selectedChoice == choice ? .accentColor : .white)
                                    .frame(width: 161, height: 44)
                                    .clipShape(CustomCorner(corners: [.bottomLeft, .bottomRight]))
                                    .overlay(
                                        Text(choice)
                                            .foregroundColor(selectedChoice == choice ? .white : .black)
                                    )
                                    .padding(.top, -50)
                            }
                            .thinShadow()
                            .onTapGesture {
                                selectedChoice = choice
                            }
                        }
                    }
                    .padding(.leading, -20)
                }
                .padding(.top, -20)
            }
        }
    }
}
