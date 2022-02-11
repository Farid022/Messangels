//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct SpiritualTraditionChoice: View {
    var funeralTypes = [SpiritualType.non_religious, SpiritualType.religious]
    @State private var valid = false
    @State private var showNote = false
    @State private var note = ""
    @StateObject private var vm = FuneralSpritualityViewModel()
    
    var body: some View {
        ZStack {
            if showNote {
               FuneralNote(showNote: $showNote, note: $note)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
                .edgesIgnoringSafeArea(.top)
            }
            FlowBaseView(note: true, showNote: $showNote, menuTitle: "Spiritualité et traditions", title: "Quel type de cérémonie souhaitez-vous ?", valid: $valid, destination: AnyView(FuneralBurialPlace(vm: vm))) {
                HStack {
                    ForEach(funeralTypes, id: \.self) { type in
                        ChoiceCard(text: type == .non_religious ? "Non-religieuse" : "Religieuse ou philosophique", selected: .constant(vm.sprituality.spritual_ceremony == type.rawValue))
                            .onTapGesture {
                                vm.sprituality.spritual_ceremony = type.rawValue
                            }
                    }
                }
            }
            .onChange(of: vm.sprituality.spritual_ceremony) { value in
                valid = vm.sprituality.spritual_ceremony != SpiritualType.none.rawValue
            }
        }
    }
}
