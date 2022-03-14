//
//  FuneralTypeView.swift
//  Messangel
//
//  Created by Saad on 10/18/21.
//

import SwiftUI
import NavigationStack

struct FuneralPlaceType: View {
    @EnvironmentObject private var navModel: NavigationModel
    @State private var loading = false
    @State private var showNote = false
    @ObservedObject var vm: FuneralLocationViewModel
    private let title = "Souhaitez-vous indiquer le lieu de votre cérémonie ?"
    
    var body: some View {
        ZStack {
            if showNote {
                FuneralNote(showNote: $showNote, note: $vm.location.location_of_ceremony_note.bound)
                    .zIndex(1.0)
                    .background(.black.opacity(0.8))
                    .edgesIgnoringSafeArea(.top)
            }
            FlowBaseView(stepNumber: 1.0, totalSteps: 6.0, isCustomAction: true, customAction: {
                if let indicateLocation = vm.location.location_of_ceremony, indicateLocation {
                    navModel.pushContent(title) {
                        FuneralPlaceSelection(vm: vm)
                    }
                } else {
                    loading.toggle()
                    if !vm.updateRecord {
                        vm.create() { success in
                            if success {
                                WishesViewModel.setProgress(tab: 17) { completed in
                                    loading.toggle()
                                    if completed {
                                        successAction(title, navModel: navModel)
                                    }
                                }
                            }
                        }
                    } else {
                        vm.update(id: vm.locations[0].id) { success in
                            loading.toggle()
                            if success {
                                successAction(title, navModel: navModel)
                            }
                        }
                    }
                }
                
            }, note: true, showNote: $showNote, menuTitle: "Lieux", title: title, valid: .constant(vm.location.location_of_ceremony != nil)) {
                HStack {
                    ForEach([true, false], id: \.self) { opt in
                        ChoiceCard(text: opt ? "Oui" : "Non", selected: .constant(vm.location.location_of_ceremony == opt))
                            .onTapGesture {
                                vm.location.location_of_ceremony = opt
                            }
                    }
                }
                if loading {
                    Loader()
                        .padding(.top)
                }
            }
        }
    }
}
