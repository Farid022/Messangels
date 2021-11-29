//
//  FuneralPlaceView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralPlaceView: View {
    @State private var showNote = false
    @State private var note = ""
    var funeralType: FuneralType
    
    var body: some View {
        FuneralNoteView(showNote: $showNote, note: $note, menuTitle: "Choix funéraires", title: "Vous pouvez indiquer le lieu d’inhumation (cimetière, caveau familial…)", destination: AnyView(FuneralCoffinMaterial(funeralType: funeralType)))
    }
}

struct FuneralNoteView: View {
    @Binding var showNote: Bool
    @Binding var note: String
    var menuTitle: String
    var title: String
    var destination: AnyView
    
    var body: some View {
        ZStack {
            if showNote {
                FuneralNote(showNote: $showNote, note: $note)
                    .zIndex(1.0)
                    .background(.black.opacity(0.8))
            }
            FuneralChoiceBaseView(note: false, showNote: .constant(false),menuTitle: menuTitle, title: title, valid: .constant(true), destination: destination) {
                VStack(spacing: 0.0) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 161, height: 207.52)
                        .clipShape(CustomCorner(corners: [.topLeft, .topRight]))
                        .overlay(
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(Color.gray)
                                .frame(width: 56, height: 56)
                                .overlay(
                                    Button(action: {
                                        showNote.toggle()
                                    }) {
                                        Image("ic_add_note")
                                    }
                                )
                        )
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 161, height: 44)
                        .clipShape(CustomCorner(corners: [.bottomLeft, .bottomRight]))
                        .overlay(Text("Note"))
                }
                .thinShadow()
            }
        }
    }
}
