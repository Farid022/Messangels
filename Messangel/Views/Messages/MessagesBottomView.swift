//
//  MessagesView.swift
//  Messangel
//
//  Created by Saad on 5/27/21.
//

import SwiftUI
import NavigationStack

struct MessagesBottomView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State private var loading = false
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Créer un message")
                    .fontWeight(.bold)
                HStack {
                    Spacer()
                    Button(action: {
                        navigationModel.pushContent(TabBarView.id) {
                            VideoRecoderView()
                        }
                    }) {
                        AddMessageView(text: "Vidéo", image: "ic_video")
                    }
                    Button(action: {
//                        loading = true
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                            let editor = RichEditorView(frame: .zero)
//                            loading = false
                             navigationModel.pushContent(TabBarView.id) {
                                 TextEditorView()
                             }
//                        }
                    }) {
                        AddMessageView(text: "Texte", image: "ic_text")
                    }
                    .overlay(Group {
                        if loading {
                            Loader()
                        }
                    })
                    Button(action: {
                        navigationModel.pushContent(TabBarView.id) {
                            AudioRecorderView()
                        }
                    }) {
                        AddMessageView(text: "Audio", image: "ic_audio")
                    }
                    Spacer()
                }
                Text("Destinataires")
                    .fontWeight(.bold)
                CreateGroupView()
                PublicView()
                Spacer().frame(height: 50)
            }
            .padding()
        }
    }
}

struct AddMessageView: View {
    var text = ""
    var image = ""
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .foregroundColor(.white)
            .frame(width: 108, height: 180)
            .shadow(color: .gray.opacity(0.2), radius: 10)
            .overlay(VStack {
                RoundedRectangle(cornerRadius: 25.0)
                    .frame(width: 56, height: 56)
                    .foregroundColor(.accentColor)
                    .overlay(Image(image))
                Text(text)
                    .foregroundColor(.black)
                Spacer().frame(height: 30)
                Image(systemName: "plus")
                    .foregroundColor(.accentColor)
            })
    }
}

struct CreateGroupView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .foregroundColor(.white)
            .frame(height: 110)
            .shadow(color: .gray.opacity(0.2), radius: 10)
            .overlay(
                HStack {
                    RoundedRectangle(cornerRadius: 25.0)
                        .stroke(Color.gray.opacity(0.2))
                        .frame(width: 56, height: 56)
                        .foregroundColor(.white)
                        .overlay(Image(systemName: "plus").foregroundColor(.gray.opacity(0.5)))
                    VStack(alignment: .leading, spacing: 7.0) {
                        Text("Créer un groupe")
                            .fontWeight(.bold)
                        Text("Créer un destinataire ou un groupe de destinataires.")
                            .foregroundColor(.secondary)
                            .font(.system(size: 13))
                    }
                }
                .padding(.horizontal, 20),
                alignment: .leading
            )
    }
}

struct PublicView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .foregroundColor(.white)
            .frame(height: 110)
            .shadow(color: .gray.opacity(0.2), radius: 10)
            .overlay(
                Button(action: {
                    navigationModel.pushContent("Messages") {
                        PublicMessagesView(viewModel: AlbumViewModel())
                    }
                }) {
                    HStack {
                        RoundedRectangle(cornerRadius: 25.0)
                            .frame(width: 56, height: 56)
                            .foregroundColor(.gray)
                            .overlay(Image("ic_public"))
                        VStack(alignment: .leading, spacing: 7.0) {
                            Text("Tout le monde (public)")
                                .fontWeight(.bold)
                            Text("Pour votre cérémonie et tout autre diffusion publique")
                                .foregroundColor(.secondary)
                                .font(.system(size: 13))
                            HStack {
                                Image("ic_public_media")
                                Text("0 MÉDIA")
                                    .font(.system(size: 9))
                                    .foregroundColor(.secondary)
                            }
                        }
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal, 20),
                alignment: .leading
            )
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesBottomView()
    }
}
