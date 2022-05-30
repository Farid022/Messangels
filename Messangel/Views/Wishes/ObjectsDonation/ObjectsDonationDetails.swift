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
    @State private var fullScreenPhoto = false
    
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
            if fullScreenPhoto, let imageUrlString = donation.object_photo {
                DetailsFullScreenPhotoView(imageUrlString: imageUrlString, fullScreenPhoto: $fullScreenPhoto)
            }
            NavigationStackView(String(describing: Self.self)) {
                ZStack(alignment:.top) {
                    Color.accentColor
                        .frame(height:70)
                        .edgesIgnoringSafeArea(.top)
                    VStack(spacing: 20) {
                        NavigationTitleView(menuTitle: "Objets", showExitAlert: .constant(false))
                        DetailsPhotoView(imageUrlString: donation.object_photo, fullScreenPhoto: $fullScreenPhoto)
                        ScrollView {
                            HStack {
                                BackButton(iconColor: .gray)
                                Text(donation.object_name)
                                    .font(.system(size: 22), weight: .bold)
                                Spacer()
                            }
                            HStack {
                                Image("ic_arrow_right")
                                Text("Donner à \((donation.object_contact_detail != nil ? "\( donation.object_contact_detail?.first_name ?? "") \(donation.object_contact_detail?.last_name ?? "")" : donation.organization_detail?.name) ?? "")")
                                    .fontWeight(.bold)
                                Spacer()
                            }
                            HStack {
                                Image("ic_item_info")
                                Text(donation.single_object ? "Un objet" : "Plusieurs objets")
                                Spacer()
                            }
                            DetailsNoteView(note: donation.object_note, attachments: donation.object_note_attachment, navId: String(describing: Self.self))
                            DetailsActionsView(showDeleteConfirm: $showDeleteConfirm) {
                                vm.objectDonation = ObjectDonation(id: donation.id, single_object: donation.single_object, single_object_note: donation.single_object_note, object_name: donation.object_name, object_contact_detail: donation.object_contact_detail?.id, organization_detail: donation.organization_detail?.id, object_photo: donation.object_photo, object_note: donation.object_note)
                                if let firstName = donation.object_contact_detail?.first_name, let lastName = donation.object_contact_detail?.last_name {
                                    vm.contactName = "\(firstName) \(lastName)"
                                }
                                if let orgName = donation.organization_detail?.name {
                                    vm.orgName = orgName
                                }
                                vm.objectDonation.single_object_note_attachments = addAttacments(donation.single_object_note_attachment)
                                vm.objectDonation.object_note_attachments = addAttacments(donation.object_note_attachment)
                                vm.updateRecord = true
                                navigationModel.pushContent(String(describing: Self.self)) {
                                    ObjectsDonationCount(vm: vm)
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
