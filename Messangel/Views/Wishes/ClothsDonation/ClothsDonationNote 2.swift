//
//  FuneralMusicNote.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI
import NavigationStack

struct ClothsDonationNote: View {
    @State private var showNote = false
    @State private var loading = false
    @ObservedObject var vm: ClothDonationViewModel
    @EnvironmentObject var navModel: NavigationModel
    var title = "Ajoutez des informations complémentaires (exemples : vêtement fragile, cas particuliers)"

    var body: some View {
        FuneralNoteCutomActionView(showNote: $showNote, note: $vm.clothDonation.clothing_note, loading: $loading, menuTitle: "Vêtements et accessoires", title: title) {
            loading.toggle()
            vm.createClothDonation { success in
                loading.toggle()
                if success {
                    UserDefaults.standard.set(100.0, forKey: "Vêtements et accessoires")
                    navModel.pushContent(title) {
                        ClothsDonationsList(vm: vm)
                    }
                }
            }
        }
    }
}
