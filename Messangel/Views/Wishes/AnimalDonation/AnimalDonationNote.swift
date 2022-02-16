//
//  FuneralMusicNote.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI
import NavigationStack

struct AnimalDonationNote: View {
    @State private var showNote = false
    @State private var loading = false
    @ObservedObject var vm: AnimalDonatiopnViewModel
    @EnvironmentObject var navModel: NavigationModel
    var title: String {
        return "Ajoutez des informations pratiques sur \(vm.animalDonation.animal_name) (alimentation, santé, fréquence de sortie, animaux nombreux)"
    }

    var body: some View {
        FuneralNoteCutomActionView(showNote: $showNote, note: $vm.animalDonation.animal_note, loading: $loading, menuTitle: "ANIMAUX", title: title) {
            loading.toggle()
            if vm.updateRecord {
                vm.update(id: vm.animalDonation.id ?? 0) { success in
                    if success {
                        navModel.popContent("AnimalDonationsList")
                        vm.getAll { _ in }
                    }
                }
            } else {
                vm.create { success in
                    if success && vm.donations.isEmpty {
                        WishesViewModel.setProgress(tab: 12) { completed in
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
        }
    }
}
