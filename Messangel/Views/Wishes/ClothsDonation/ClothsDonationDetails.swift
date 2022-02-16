//
//  FuneralMusicDetails.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI
import NavigationStack

struct ClothsDonationDetails: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    @ObservedObject var vm: ClothDonationViewModel
    @State private var showDeleteConfirm = false
    var donation: ClothingDonation
    let  confirmMessage = "Les informations liées seront supprimées définitivement"
    
    var body: some View {
        ZStack {
            DetailsDeleteView(showDeleteConfirm: $showDeleteConfirm, alertTitle: "Supprimer ce donation") {
                vm.del(id: donation.id) { success in
                    if success {
                        navigationModel.popContent(String(describing: ClothsDonationsList.self))
                        vm.getAll { _ in }
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
                        NavigationTitleView(menuTitle: "Vêtements et accessoires")
                        DetailsTitleView(title: donation.clothing_name)
                        HStack {
                            Image("ic_arrow_right")
                            Text("Donner à \((donation.clothing_contact_detail != nil ? "\(String(describing: donation.clothing_contact_detail?.first_name)) \(String(describing: donation.clothing_contact_detail?.last_name))" : donation.clothing_organization_detail?.name) ?? "")")
                                .fontWeight(.bold)
                            Spacer()
                        }
                        HStack {
                            Image("ic_item_info")
                            Text("Plusieurs vêtements ou accessoires")
                            Spacer()
                        }
                        DetailsNoteView(note: donation.clothing_note)
                        DetailsActionsView(showDeleteConfirm: $showDeleteConfirm) {
                            vm.clothDonation = ClothDonation(id: donation.id, single_clothing: donation.single_clothing, single_clothing_note: donation.single_clothing_note, clothing_name: donation.clothing_name, clothing_contact_detail: donation.clothing_contact_detail?.id, clothing_organization_detail: donation.clothing_organization_detail?.id, clothing_photo: donation.clothing_photo, clothing_note: donation.clothing_note)
                            vm.updateRecord = true
                            navigationModel.pushContent(String(describing: Self.self)) {
                              ClothsDonationCount(vm: vm) // Update record
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
}
