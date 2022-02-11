//
//  AlbumPhotos.swift
//  Messangel
//
//  Created by Saad on 6/9/21.
//

import SwiftUI

struct AlbumImage: Hashable {
    var id : String
    var image : UIImage
}


struct MesMessage: Hashable {
    var icon : String
    var title : String
    var count : String
}


struct MesVolenteItem: Hashable {

    var title : String
    var type : String
}
