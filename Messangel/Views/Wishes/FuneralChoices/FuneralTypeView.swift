//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI

struct FuneralTypeView: View {
    var funeralTypes = [FuneralType.burial, FuneralType.crematization]
    @State private var valid = false
    @State private var selectedFuneral = FuneralType.none
    @State private var showNote = false
    @ObservedObject var vm: FeneralViewModel
    
    var body: some View {
        ZStack {
            if showNote {
               FuneralNote(showNote: $showNote, note: $vm.funeral.burial_type_note.bound)
                .zIndex(1.0)
                .background(.black.opacity(0.8))
                .edgesIgnoringSafeArea(.top)
            }
            FlowBaseView(stepNumber: 1.0, totalSteps: 12.0, noteText: $vm.funeral.burial_type_note.bound, note: true, showNote: $showNote, menuTitle: "Choix funéraires", title: "Quel rite souhaitez-vous ?", valid: .constant(vm.funeral.burial_type != 0), destination: AnyView(FuneralPlaceView(vm: vm))) {
                HStack {
                    ForEach(funeralTypes, id: \.self) { type in
                        ChoiceCard(text: type == .burial ? "Inhumation" : "Crématisation", selected: .constant(vm.funeral.burial_type == type.rawValue))
                            .onTapGesture {
                                vm.funeral.burial_type = type.rawValue
                            }
                    }
                }
            }
        }
    }
}
