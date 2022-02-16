//
//  FuneralMusicDetails.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI
import NavigationStack

struct ObjectsDonationDetails: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    @ObservedObject var vm: ObjectDonationViewModel
    var donation: ObjectDonationDetails
    var confirmMessage = "Les informations liées seront supprimées définitivement"
    @State private var showDeleteConfirm = false
    
    var body: some View {
        ZStack {
            DetailsDeleteView(showDeleteConfirm: $showDeleteConfirm, alertTitle: "Supprimer ce donation") {
                vm.del(id: donation.id) { success in
                    if success {
                        navigationModel.popContent(String(describing: ObjectsDonationsList.self))
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
                        NavigationTitleView(menuTitle: "Objets")
                        HStack {
                            BackButton(iconColor: .gray)
                            Text(donation.object_name)
                                .font(.system(size: 22), weight: .bold)
                            Spacer()
                        }
                        HStack {
                            Image("ic_arrow_right")
                            Text("Donner à \((donation.object_contact_detail != nil ? "\(String(describing: donation.object_contact_detail?.first_name)) \(String(describing: donation.object_contact_detail?.last_name))" : donation.organization_detail?.name) ?? "")")
                                .fontWeight(.bold)
                            Spacer()
                        }
                        HStack {
                            Image("ic_item_info")
                            Text("Plusieurs objets")
                            Spacer()
                        }
                        DetailsNoteView(note: donation.object_note)
                        DetailsActionsView(showDeleteConfirm: $showDeleteConfirm) {
                            vm.objectDonation = ObjectDonation(id: donation.id, single_object: donation.single_object, single_object_note: donation.single_object_note, object_name: donation.object_name, object_contact_detail: donation.object_contact_detail?.id, organization_detail: donation.organization_detail?.id, object_photo: donation.object_photo, object_note: donation.object_note)
                            vm.updateRecord = true
                            navigationModel.pushContent(String(describing: Self.self)) {
                                ObjectsDonationCount(vm: vm)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
}
