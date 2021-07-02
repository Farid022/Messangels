//
//  PublicMessagesView.swift
//  Messangel
//
//  Created by Saad on 5/31/21.
//

import SwiftUI
import NavigationStack

struct PublicMessagesView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @ObservedObject var viewModel: AlbumViewModel

    var body: some View {
        NavigationStackView("PublicMessagesView") {
            MenuBaseView(title: "Ma petite famille") {
                if viewModel.albumImages.count == 0 {
                    GalleryPlaceHolder(viewModel: viewModel)
                } else {
                    if let image = viewModel.albumImages.first?.image {
                        Image(uiImage: image)
                            .resizable()
                            .frame(height: 190)
                            .padding(-16)
                    } else {
                        GalleryPlaceHolder(viewModel: viewModel)
                    }
                }
                MiddleView()
                LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 16.0), count: 2), spacing: 16.0) {
                    CreateMessageCard()
                    MessageCard(image: "ic_contacts", name: "Éternel", icon: "ic_video")
                }
            }
        }
    }
}


struct GalleryPlaceHolder: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @ObservedObject var viewModel: AlbumViewModel
    var body: some View {
        Rectangle()
            .foregroundColor(.gray.opacity(0.5))
            .frame(height: 190)
            .padding(-16)
            .overlay(
                Button(action: {
                    navigationModel.pushContent(TabBarView.id) {
                        PhotosSelectionView(viewModel: viewModel)
                    }
                }) {
                    RoundedRectangle(cornerRadius: 30.0)
                        .frame(width: 66, height: 66)
                        .foregroundColor(.gray)
                        .overlay(Image(systemName: "photo.fill").foregroundColor(.white))
                }
            )
            .padding(.bottom, 25)
    }
}

struct MiddleView: View {
    var body: some View {
        HStack {
            HStack {
                Text("Ma petite famille")
                    .fontWeight(.bold)
                Spacer()
            }
        }
        HStack {
            Capsule()
                .foregroundColor(.white)
                .shadow(color: .gray.opacity(0.2), radius: 10)
                .frame(width: 160, height: 56)
                .overlay(HStack {
                    Text("0")
                        .foregroundColor(.accentColor)
                    Image("ic_contacts")
                    Text("Destinataires")
                        .font(.system(size: 13))
                })
            Spacer()
        }
        .padding(.bottom, 30)
    }
}

struct CreateMessageCard: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .frame(width: 160, height: 250)
            .foregroundColor(.white)
            .shadow(color: .gray.opacity(0.2), radius: 10)
            .overlay(VStack {
                Spacer().frame(height: 30)
                RoundedRectangle(cornerRadius: 28.0)
                    .frame(width: 66, height: 66)
                    .foregroundColor(.white)
                    .shadow(color: .gray.opacity(0.2), radius: 10)
                    .overlay(Image(systemName: "plus").foregroundColor(.gray))
                    .padding(.bottom, 10)
                Text("Créer un nouveau message")
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 13))
                Spacer()
                Divider()
                Text("03 aujourd’hui 2021")
                    .font(.system(size: 11))
                    .foregroundColor(.secondary.opacity(0.5))
                    .padding(5)
                    .padding(.bottom, 10)
            })
    }
}

struct MessageCard: View {
    var image = ""
    var name = ""
    var icon = ""
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .frame(width: 160, height: 250)
            .foregroundColor(.white)
            .shadow(color: .gray.opacity(0.2), radius: 10)
            .overlay(VStack {
                Spacer().frame(height: 30)
                RoundedRectangle(cornerRadius: 28.0)
                    .frame(width: 66, height: 66)
                    .foregroundColor(.white)
                    .shadow(color: .gray.opacity(0.2), radius: 10)
                    .overlay(Image(image))
                    .padding(.bottom, 10)
                Text(name)
                Spacer()
                Image(icon)
                    .renderingMode(.template)
                    .foregroundColor(.gray)
                    .padding(.bottom)
                Divider()
                Text("03 aujourd’hui 2021")
                    .font(.system(size: 11))
                    .foregroundColor(.secondary.opacity(0.5))
                    .padding(5)
                    .padding(.bottom, 10)
            })
    }
}

struct PublicMessagesView_Previews: PreviewProvider {
    static var previews: some View {
        PublicMessagesView(viewModel: AlbumViewModel())
    }
}
