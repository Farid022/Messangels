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
            if vm.updateRecord {
                vm.update(id: vm.donationOrg.id ?? 0) { success in
                    if success {
                        navModel.popContent("DonationOrgsList")
                        vm.getDonationOrgs { _ in }
                    }
                }
            } else {
                vm.create { success in
                    if success && vm.donationOrgs.isEmpty {
                        WishesViewModel.setProgress(tab: 13) { completed in
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
