//
//  FuneralCoffinMaterial.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralCoffinMaterial: View {
    var choices = [
        FuneralChoice(id: 1, name: "Chêne", image: ""),
        FuneralChoice(id: 2, name: "Sapin", image: ""),
        FuneralChoice(id: 3, name: "Pin", image: "")
    ]
    @State private var noteText = ""
    @ObservedObject var vm: FeneralViewModel
    
    var body: some View {
        FuneralChoicesView(noteText: $noteText, choices: choices, selectedChoice: $vm.funeral.coffin_material, menuTitle: "Choix funéraires", title: "Choisissez un matériau pour le cercueil", destination: AnyView(FuneralCoffinShape(vm: vm)))
    }
}

struct FuneralChoicesView: View {
    @State var showNote = false
    @Binding var noteText: String
    var choices: [FuneralChoice]
    @Binding var selectedChoice: Int
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
            FlowBaseView(note: true, showNote: $showNote, menuTitle: menuTitle, title: title, valid: .constant(selectedChoice != 0), destination: destination) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: -70){
                        ForEach(choices, id: \.self) { choice in
                            VStack(spacing: 0) {
                                Image(choice.name)
                                Rectangle()
                                    .foregroundColor(selectedChoice == choice.id ? .accentColor : .white)
                                    .frame(width: 161, height: 44)
                                    .clipShape(CustomCorner(corners: [.bottomLeft, .bottomRight]))
                                    .overlay(
                                        Text(choice.name)
                                            .foregroundColor(selectedChoice == choice.id ? .white : .black)
                                    )
                                    .padding(.top, -50)
                            }
                            .thinShadow()
                            .onTapGesture {
                                selectedChoice = choice.id
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
