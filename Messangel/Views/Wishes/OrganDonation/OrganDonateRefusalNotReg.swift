//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUIX
import NavigationStack

struct OrganDonateRefusalNotReg: View {
    @State private var valid = false
    @State private var showNote = false
    @State private var note = ""
    
    var body: some View {
        ZStack {
            if showNote {
                FuneralNote(showNote: $showNote, note: $note)
                    .zIndex(1.0)
                    .background(.black.opacity(0.8))
                    .edgesIgnoringSafeArea(.top)
            }
            FuneralChoiceBaseView(note: true, showNote: $showNote, menuTitle: "Don d’organes ou du corps à la science", title: "Pour refuser le don d’organes, vous devez être inscrit sur le registre national des refus.", valid: .constant(true), destination: AnyView(FuneralDoneView())) {
                HStack {
                    Button(action: {
                        
                    }, label: {
                        Text("Voir notre guide Messangel")
                    })
                    .buttonStyle(MyButtonStyle(foregroundColor: .white, backgroundColor: .accentColor))
                    Spacer()
                }
            }
            
        }
    }
}