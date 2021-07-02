//
//  AlbumViewModel.swift
//  Messangel
//
//  Created by Saad on 6/9/21.
//

import SwiftUI
import Photos
import Combine

class AlbumViewModel: ObservableObject {
    @Published var albumImages: [AlbumImage]
//        private var cancellable: AnyCancellable?
//
//        init<T: Publisher>(
//            albumImage: [AlbumImage],
//            publisher: T
//        ) where T.Output == [AlbumImage], T.Failure == Never {
//            self.albumImage = albumImage
//            self.cancellable = publisher.assign(to: \.albumImage, on: self)
//        }
    init() {
        albumImages = []
    }
}
