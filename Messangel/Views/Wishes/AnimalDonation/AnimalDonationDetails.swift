//
//  FuneralMusicDetails.swift
//  Messangel
//
//  Created by Saad on 11/18/21.
//

import SwiftUI
import NavigationStack

struct AnimalDonationDetails: View {
    @EnvironmentObject private var navigationModel: NavigationModel
    @ObservedObject var vm: AnimalDonatiopnViewModel
    var donation: AnimalDonationDetail
    var confirmMessage = "Les informations liées seront supprimées définitivement"
    @State private var showDeleteConfirm = false
    
    var body: some View {
        ZStack {
            DetailsDeleteView(showDeleteConfirm: $showDeleteConfirm, alertTitle: "Supprimer ce donation") {
                vm.del(id: donation.id) { success in
                    if success {
                        navigationModel.popContent(String(describing: AnimalDonationsList.self))
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
                        NavigationTitleView(menuTitle: "ANIMAUX")
                        ScrollView {
                            HStack {
                                BackButton(iconColor: .gray)
                                Text(donation.animal_name)
                                    .font(.system(size: 22), weight: .bold)
                                Spacer()
                            }
                            HStack {
                                Image("ic_arrow_right")
                                Text("Donner à \((donation.animal_contact_detail != nil ? "\(String(describing: donation.animal_contact_detail?.first_name)) \(String(describing: donation.animal_contact_detail?.last_name))" : donation.animal_organization_detail?.name) ?? "")")
                                    .fontWeight(.bold)
                                Spacer()
                            }
                            HStack {
                                Image("ic_item_info")
                                Text("Espèce – Labrador")
                                Spacer()
                            }
                            HStack {
                                Image("ic_item_info")
                                Text("Plusieurs animaux")
                                Spacer()
                            }
                            DetailsNoteView(note: donation.animal_note)
                            DetailsActionsView(showDeleteConfirm: $showDeleteConfirm) {
                                vm.animalDonation = AnimalDonation(id: donation.id, single_animal: donation.single_animal, single_animal_note: donation.single_animal_note, animal_name: donation.animal_name, animal_name_note: donation.animal_name_note, animal_contact_detail: donation.animal_contact_detail?.id, animal_organization_detail: donation.animal_organization_detail?.id, animal_species: donation.animal_species, animal_species_note: donation.animal_species_note, animal_photo: donation.animal_photo, animal_note: donation.animal_note, animal_note_attachment: donation.animal_note_attachment)
                                if let firstName = donation.animal_contact_detail?.first_name, let lastName = donation.animal_contact_detail?.last_name {
                                    vm.contactName = "\(firstName) \(lastName)"
                                }
                                if let orgName = donation.animal_organization_detail?.name {
                                    vm.orgName = orgName
                                }
                                vm.updateRecord = true
                                navigationModel.pushContent(String(describing: Self.self)) {
                                    AnimalDonationCount(vm: vm)
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
}
