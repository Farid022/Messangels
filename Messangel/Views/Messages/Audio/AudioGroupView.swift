//
//  DocGroupView.swift
//  Messangel
//
//  Created by Saad on 7/12/21.
//

import SwiftUI
import NavigationStack

struct AudioGroupView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var selectedGroup = 0
    var fileUrl: URL
    var audioImage: UIImage
    @State private var valid = false
    @State private var loading = false
    @State private var showNewGroupBox = false
    @State private var fullScreen = false
    @ObservedObject var player: Player
    @ObservedObject var vm: AudioViewModel
    @EnvironmentObject var groupVM: GroupViewModel
    
    var body: some View {
        NavigationStackView("AudioGroupView") {
            ZStack {
                if loading {
                    RoundedRectangle(cornerRadius: 15.0)
                        .foregroundColor(.white)
                        .frame(width:236, height: 51)
                        .shadow(radius: 10)
                        .overlay(
                            Text("Audéo enregistrée")
                                .font(.system(size: 17), weight: .semibold)
                                .foregroundColor(.accentColor)
                        )
                        .zIndex(1.0)
                }
                if showNewGroupBox {
                    InputAlert(title: "Donnez un nom au groupe", message: newGroupMessage) { result in
                        showNewGroupBox.toggle()
                        if let text = result {
                            if !text.isEmpty && text.count > 2 {
                                groupVM.group.name = text
                                groupVM.group.user = getUserId()
                                groupVM.create { success in
                                    print("Group \(text) created: \(success)")
                                        if success {
                                            groupVM.getAll()
                                        }
                                }
                            }
                        }
                    }
                    .zIndex(1.0)
                }
                ZStack(alignment: .bottom) {
                    if loading {
                        Color.black.opacity(0.3)
                            .ignoresSafeArea()
                            .zIndex(1.0)
                    }
                    MenuBaseView(height: 60, title: "Destinataires") {
                        ZStack {
                            if audioImage.cgImage == nil {
                                Rectangle()
                                    .foregroundColor(.gray.opacity(0.5))
                                    .frame(width: 252, height: screenSize.width / 1.15)
                                    .padding(.bottom, 30)
                                Image("audio_preview_waves")
                            } else {
                                Image(uiImage: audioImage)
                                    .resizable()
                                    .frame(width: 252, height: screenSize.width / 1.15)
                                    .padding(.bottom, 30)
                            }
                            AudioPlayerButton(player: self.player)
                        }
                    }
                    VStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 0.0){
                                ForEach(groupVM.groups, id: \.self) { group in
                                    ZStack {
                                        if group.id == selectedGroup {
                                            RoundedRectangle(cornerRadius: 20.0)
                                                .stroke(Color.accentColor)
                                                .frame(width: 341, height: 111)
                                        }
                                        GroupCapsule(group: group, tappable: false, width: 339)
                                            .onTapGesture {
                                                selectedGroup = group.id
                                                if selectedGroup > 0 {
                                                    valid = true
                                                }
                                            }
                                            .padding()
                                    }
                                }
                                CreateGroupView(width: 339, showNewGroupBox: $showNewGroupBox)
                            }
                            .padding()
                        }
                        HStack {
                            Button(action: {
                                if valid {
                                    Task {
                                        loading.toggle()
                                        if audioImage.cgImage != nil {
                                            let image = await uploadImage(audioImage, type: "audio")
                                            vm.audio.audio_image = image
                                        }
                                        await uploadAudio()
                                        loading.toggle()
                                    }
                                }
                            }, label: {
                                Text("Valider")
                                    .font(.system(size: 15))
                                    .padding(3)
                            })
                            .buttonStyle(MyButtonStyle(foregroundColor: .white, backgroundColor: valid ? .accentColor : .gray))
                            .padding(.bottom, 50)
                            .padding(.top, 20)
                        }
                        .frame(maxWidth: .infinity)
                        .background(
                            Color.white
                                .clipShape(CustomCorner(corners: [.topLeft,.topRight]))
                        )
                        .shadow(color: Color.gray.opacity(0.15), radius: 5, x: -5, y: -5)
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
            }
        }
    }
    
    func uploadAudio() async {
        do {
            let data = try Data(contentsOf: fileUrl)
            let response = await Networking.shared.upload(data, fileName: fileUrl.lastPathComponent, fileType: "audio")
            if let response = response {
                DispatchQueue.main.async {
                    vm.uploadResponse = response
                    vm.audio.audio_link = response.files.first?.path ?? ""
                    vm.audio.size = "\(response.files.first?.size ?? 0)"
                    vm.audio.group = selectedGroup
                    vm.create {
                        navigationModel.popContent(TabBarView.id)
                    }
                }
            }
        } catch let err {
            print(err)
        }
    }
}
