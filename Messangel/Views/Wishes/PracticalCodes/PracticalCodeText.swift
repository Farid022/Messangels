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
            FlowBaseView(stepNumber: 3.0, totalSteps: 3.0, isCustomAction: true, customAction: {
                if vm.updateRecord {
                    vm.update(id: vm.practicalCode.id ?? 0) { success in
                        if success {
                            navModel.popContent("PracticalCodesList")
                            vm.getPracticalCodes { _ in }
                        }
                    }
                } else {
                    vm.createPracticalCode { success in
                        if success && vm.practicalCodes.isEmpty {
                            WishesViewModel.setProgress(tab: 14) { completed in
                                loading.toggle()
                                if completed {
                                    navModel.pushContent(title) {
                                        FuneralDoneView()
                                    }
                                }
                            }
                        } else {
                            loading.toggle()
                            if success {
                                navModel.pushContent(title) {
                                    FuneralDoneView()
                                }
                            }
                        }
                    }
                }
            }, note: true, showNote: $showNote, menuTitle: "Codes pratiques", title: title, valid: .constant(!vm.practicalCode.codes.isEmpty)) {
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


