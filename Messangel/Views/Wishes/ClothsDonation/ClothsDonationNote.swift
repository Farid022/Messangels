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
            Task {
                if vm.localPhoto.cgImage != nil {
                    self.vm.clothDonation.clothing_photo = await uploadImage(vm.localPhoto, type: "clothing")
                }
                if vm.updateRecord {
                    vm.update(id: vm.clothDonation.id ?? 0) { success in
                        loading.toggle()
                        if success {
                            navModel.popContent("ClothsDonationsList")
                            vm.getAll { _ in
                                print("ClothsDonationsList Updated")
                            }
                        }
                    }
                } else {
                    vm.createClothDonation { success in
                        if success && vm.donations.isEmpty {
                            WishesViewModel.setProgress(tab: 9) { completed in
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
}

struct NoteView: View {
    @Binding var showNote: Bool
    @Binding var note: String
    
    var body: some View {
        VStack(spacing: 0.0) {
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(width: 161, height: 207.52)
                .clipShape(CustomCorner(corners: [.topLeft, .topRight]))
                .overlay(
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(note.isEmpty ? Color.gray : Color.accentColor)
                        .frame(width: 56, height: 56)
                        .overlay(
                            Button(action: {
                                showNote.toggle()
                            }) {
                                Image(note.isEmpty ? "ic_add_note" : "ic_notes")
                            }
                        )
                )
            Rectangle()
                .fill(Color.white)
                .frame(width: 161, height: 44)
                .clipShape(CustomCorner(corners: [.bottomLeft, .bottomRight]))
                .overlay(Text("Note"))
        }
        .thinShadow()
    }
}
