//
//  FuneralMusicNote.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI
import NavigationStack

struct DonationOrgNote: View {
    @State private var showNote = false
    @State private var loading = false
    @ObservedObject var vm: DonationOrgViewModel
    @EnvironmentObject var navModel: NavigationModel
    var title = "Ajoutez des informations (montants, collecte à la cérémonie)"
    
    var body: some View {
        FuneralNoteCutomActionView(showNote: $showNote, note: $vm.donationOrg.donation_note, loading: $loading, menuTitle: "Dons et collectes", title: title) {
            loading.toggle()
            vm.create() { success in
                loading.toggle()
                if success {
                    UserDefaults.standard.set(100.0, forKey: "Dons et collectes")
                    navModel.pushContent(title) {
                        DonationOrgsList(vm: vm)
                    }
                }
            }
        }
    }
}
