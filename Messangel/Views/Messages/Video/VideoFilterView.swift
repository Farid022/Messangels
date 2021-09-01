//
//  DocTitleView.swift
//  Messangel
//
//  Created by Saad on 7/8/21.
//

import SwiftUI
import NavigationStack
import AVFoundation

let filters = [Color.clear, Color.green, Color.blue, Color.yellow]
let filterNames = ["Aucun", "Filtre 1", "Filtre 2"," Filtre 3"]

struct VideoFilterView: View {
    @EnvironmentObject var navigationModel: NavigationModel

    var filename: URL
    @State var selectedFilter = Color.clear
    
    var body: some View {
        NavigationStackView("VideoFilterView") {
            ZStack(alignment: .bottom) {
                MenuBaseView(height: 60, title: "Filtre") {
                    ZStack {
                        VideoPreview(fileUrl: filename)
                            .frame(width: 211.99, height: 392.53)
                            .padding(.bottom, 20)
                        Rectangle()
                            .foregroundColor(selectedFilter.opacity(0.15))
                            .frame(width: 211.99, height: 392.53)
                            .offset(y: -10)
                    }
                    Text("Choisir un filtre")
                        .font(.system(size: 17))
                        .fontWeight(.bold)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(){
                            ForEach(filters, id: \.self) { filter in
                                VStack(spacing: 0) {
                                    ZStack {
                                        VideoPreview(fileUrl: filename)
                                            .scaledToFill()
                                            .frame(width: 161, height: 44)
                                        Rectangle()
                                            .foregroundColor(filter.opacity(0.15))
                                            .frame(width: 161, height: 44)
                                    }
                                    Rectangle()
                                        .fill(filter == selectedFilter ? Color.accentColor : Color.gray)
                                        .frame(width: 161, height: 44)
                                        .overlay(
                                            Text(filterNames[filters.firstIndex(of: filter)!])
                                                .font(.system(size: 15), weight: filter == selectedFilter ? .semibold : .regular)
                                                .foregroundColor(.white)
                                        )
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 22))
                                .onTapGesture {
                                    selectedFilter = filter
                                }
                            }
                        }
                        .padding()
                    }
                    Spacer().frame(height: 50)
                } // MenuBaseView
                HStack {
                    Button(action: {
                        navigationModel.pushContent("VideoFilterView") {
                            VideoTitleView(filename: filename, selectedFilter: selectedFilter)
                        }
                    }, label: {
                        Text("Valider")
                            .font(.system(size: 15))
                            .padding(3)
                    })
                    .buttonStyle(MyButtonStyle(foregroundColor: .white, backgroundColor: .accentColor))
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
    }
}

struct VideoPreview: View {
    var fileUrl: URL
    @State private var videoImage = UIImage()
    var body: some View {
        Image(uiImage: videoImage)
            .resizable()
            .onAppear() {
                let timestamp = CMTime(seconds: 1, preferredTimescale: 60)
                let asset = AVURLAsset(url: fileUrl)
                let generator = AVAssetImageGenerator(asset: asset)
                generator.appliesPreferredTrackTransform = true
                if let imageRef = try? generator.copyCGImage(at: timestamp, actualTime: nil) {
                    videoImage = UIImage(cgImage: imageRef)
                }
            }
    }
}
