//
//  FuneralTakeWithObjects.swift
//  Messangel
//
//  Created by Saad on 10/20/21.
//

import SwiftUI
import NavigationStack

struct FuneralTakeWithObjects: View {
    @State private var showNote = false
    @State private var loading = false
    @ObservedObject var vm: FeneralViewModel
    @EnvironmentObject var navModel: NavigationModel
    var title = "Indiquez si vous souhaitez emporter des objets ou accessoires"
    
    var body: some View {
        FuneralNoteCutomActionView(totalSteps: 12.0, showNote: $showNote, note: $vm.funeral.acessories_note, loading: $loading, menuTitle: wishesPersonal.first!.name, title: title) {
            loading.toggle()
            if vm.updateRecord {
                vm.update(id: vm.funeralChoices[0].id) { success in
                    loading.toggle()
                    if success {
                        navModel.pushContent(title) {
                            FuneralDoneView()
                        }
                    }
                }
            } else {
                vm.create() { success in
                    if success {
                        WishesViewModel.setProgress(tab: 1) { completed in
                            loading.toggle()
                            if completed {
                                navModel.pushContent(title) {
                                    FuneralDoneView()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
