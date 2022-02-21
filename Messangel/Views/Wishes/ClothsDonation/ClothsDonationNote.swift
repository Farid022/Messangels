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
    @State private var attachFiles = [URL]()
    @ObservedObject var vm: ClothDonationViewModel
    @EnvironmentObject var navModel: NavigationModel
    var title = "Ajoutez des informations complémentaires (exemples : vêtement fragile, cas particuliers)"

    var body: some View {
        FuneralNoteAttachCutomActionView(showNote: $showNote, note: $vm.clothDonation.clothing_note, loading: $loading, attachFiles: $attachFiles, menuTitle: "Vêtements et accessoires", title: title) {
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

// MARK: - Custom Note Views

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

struct NoteWithAttachementView: View {
    @Binding var showNote: Bool
    @Binding var note:String
    @State var expandedNote = false
    @FocusState private var isFocused: Bool
    @State private var showFileImporter = false
    @Binding var files: [URL]
    var multiple = true
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer().frame(height: 50)
            HStack {
                Button(action: {
                    showNote.toggle()
                }, label: {
                    Image("ic_close_note")
                })
                Spacer()
            }
            Spacer()
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundColor(.gray)
                .frame(height: 56)
                .overlay(
                    HStack {
                        Image("ic_notes")
                        Text("Notes")
                            .font(.system(size: 17), weight: .semibold)
                            .foregroundColor(.white)
                        Spacer()
                        Button(action: {
                            expandedNote.toggle()
                        }, label: {
                            Image("ic_expand_notes")
                        })
                    }
                    .padding(.horizontal)
                )
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundColor(.white)
                .frame(height: expandedNote ? 295 : 160)
                .overlay(
                    VStack {
                        TextEditor(text: $note)
                            .focused($isFocused)
                        HStack {
                            Button(action: {
                                showFileImporter.toggle()
                            }, label: {
                                HStack {
                                    Image("ic_attachement")
                                    Text("Joindre un fichier")
                                        .foregroundColor(.gray)
                                        .underline()
                                }
                            })
                            Spacer()
                            Button(action: {
                                showNote.toggle()
                            }, label: {
                                Image("ic_save_note")
                            })
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 20)
                )
            if !files.isEmpty {
                LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 16.0), count: files.count), alignment: .leading, spacing: 16.0) {
                    ForEach(files, id: \.self) { file in
                        FuneralCapsuleView(name: file.lastPathComponent) {
                            files.remove(at: files.firstIndex(of: file)!)
                        }
                    }
                }
            }
            Spacer()
        }
        .padding()
        .onAppear() {
            isFocused = true
        }
        .fileImporter(isPresented: $showFileImporter, allowedContentTypes: [.pdf, .image], allowsMultipleSelection: multiple) { result in
            switch result {
            case .success(let fileUrl):
                fileUrl.forEach { url in
                    self.files.append(url)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - FuneralNoteCutomActionView
struct FuneralNoteCutomActionView: View {
    @Binding var showNote: Bool
    @Binding var note: String
    @Binding var loading: Bool
    var menuTitle: String
    var title: String
    var customAction: () -> Void
    
    var body: some View {
        ZStack {
            if showNote {
                FuneralNote(showNote: $showNote, note: $note)
                    .zIndex(1.0)
                    .background(.black.opacity(0.8))
            }
            FlowBaseView(isCustomAction: true, customAction: customAction, note: false, showNote: .constant(false), menuTitle: menuTitle, title: title, valid: .constant(true)) {
                NoteView(showNote: $showNote, note: $note)
                if loading {
                    Loader()
                        .padding(.top)
                }
            }
        }
    }
}

struct FuneralNoteAttachCutomActionView: View {
    @Binding var showNote: Bool
    @Binding var note: String
    @Binding var loading: Bool
    @Binding var attachFiles: [URL]
    var menuTitle: String
    var title: String
    var customAction: () -> Void
    
    var body: some View {
        ZStack {
            if showNote {
                    NoteWithAttachementView(showNote: $showNote, note: $note, files: $attachFiles)
                        .zIndex(1.0)
                        .background(.black.opacity(0.8))
            }
            FlowBaseView(isCustomAction: true, customAction: customAction, note: false, showNote: .constant(false), menuTitle: menuTitle, title: title, valid: .constant(true)) {
                NoteView(showNote: $showNote, note: $note)
                if loading {
                    Loader()
                        .padding(.top)
                }
            }
        }
    }
}

