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
    var title = "Ajoutez des informations pratiques sur *votre animal *vos animaux (alimentation, santé, fréquence de sortie, animaux nombreux)"

    var body: some View {
        FuneralNoteCutomActionView(showNote: $showNote, note: $vm.animalDonation.animal_note, loading: $loading, menuTitle: "ANIMAUX", title: title) {
            loading.toggle()
            vm.create() { success in
                loading.toggle()
                if success {
                    UserDefaults.standard.set(100.0, forKey: "ANIMAUX")
                    navModel.pushContent(title) {
                        AnimalDonationsList(vm: vm)
                    }
                }
            }
        }
    }
}
