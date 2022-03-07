//
//  ClothsDonationName.swift
//  Messangel
//
//  Created by Saad on 11/19/21.
//

import SwiftUI
import NavigationStack

struct PracticalCodeText: View {
    @ObservedObject var vm: PracticalCodeViewModel
    @State private var loading = false
    @State private var showNote = false
//    @State private var codeCount = 1
    @EnvironmentObject var navModel: NavigationModel
    var title = "Entrez votre code. Vous pouvez ajouter des codes complémentaires si nécessaires"
    
    var body: some View {
        ZStack {
            if showNote {
                FuneralNote(showNote: $showNote, note: $vm.practicalCode.note)
                    .zIndex(1.0)
                    .background(.black.opacity(0.8))
            }
            FlowBaseView(isCustomAction: true, customAction: {
                vm.createPracticalCode { success in
                    navModel.pushContent(title) {
                        PracticalCodesList(vm: vm)
                    }
                }
            }, note: true, showNote: $showNote, menuTitle: "Codes pratiques", title: title, valid: .constant(!vm.code.code.isEmpty)) {
//                ForEach(0 ..< codeCount, id: \.self) { item in
                    SecureField("Code", text: $vm.code.code)
                        .normalShadow()
//                }
                Button {
                    if vm.code.code.isEmpty  {
                        return
                    }
//                    if codeCount < 3 {
                        loading.toggle()
                        vm.addCode { success in
                            loading.toggle()
                            vm.practicalCode.codes.append(vm.code.id ?? 0)
                            vm.code.code = ""
//                            codeCount += 1
                        }
//                    }
                } label: {
                    Text("+ Ajouter un code à \(vm.practicalCode.name)")
                        .underline()
                        .foregroundColor(.secondary)
                }
                if loading {
                    Loader()
                }
            }
        }
    }
}


