//
//  FuneralMusicDetails.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI
import NavigationStack

struct DonationOrgDetails: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    @ObservedObject var vm: DonationOrgViewModel
    var org: DonationOrgDetail
    var confirmMessage = "Les informations liées seront supprimées définitivement"
    @State private var showDeleteConfirm = false
    
    var body: some View {
        ZStack {
            DetailsDeleteView(showDeleteConfirm: $showDeleteConfirm, alertTitle: "Supprimer ce donation org") {
                vm.del(id: org.id) { success in
                    if success {
                        navigationModel.popContent(String(describing: DonationOrgsList.self))
                        vm.getDonationOrgs { _ in }
                    }
                }
            }
            NavigationStackView(String(describing: Self.self)) {
                ZStack(alignment:.top) {
                    Color.accentColor
                        .frame(height:70)
                        .edgesIgnoringSafeArea(.top)
                    VStack(spacing: 20) {
                        NavbarButtonView()
                        NavigationTitleView(menuTitle: "Dons et collectes")
                        HStack {
                            BackButton(iconColor: .gray)
                            Text(org.donation_organization.name)
                                .font(.system(size: 22), weight: .bold)
                            Spacer()
                        }
                        HStack {
                            Image("ic_item_info")
                            Text("Destinataire du don –  Croix Rouge")
                            Spacer()
                        }
                        DetailsNoteView(note: org.donation_note)
                        DetailsActionsView(showDeleteConfirm: $showDeleteConfirm) {
                            vm.donationOrg = DonationOrg(id: org.id, donation_organization: org.donation_organization.id ?? 1, donation_note: org.donation_note)
                            vm.updateRecord = true
                            navigationModel.pushContent(String(describing: Self.self)) {
                                DonationOrgsSelectionView(vm: vm)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
}
